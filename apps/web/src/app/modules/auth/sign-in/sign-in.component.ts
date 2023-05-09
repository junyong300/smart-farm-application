import { AfterContentInit, AfterViewInit, Component, ElementRef, OnInit, ViewChild, ViewEncapsulation } from '@angular/core';
import { UntypedFormBuilder, UntypedFormGroup, NgForm, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { fuseAnimations } from '@front/animations';
import { AuthService } from '@front/auth/auth.service';
import { FuseAlertType } from '@front/components/alert/alert.types';
import { FrontConfigService } from '@front/services/config';
import { TranslocoService } from '@ngneat/transloco';

@Component({
  selector: 'auth-sign-in',
  templateUrl: './sign-in.component.html',
  encapsulation: ViewEncapsulation.None,
  animations: fuseAnimations,
})
export class AuthSignInComponent implements OnInit, AfterViewInit {
  @ViewChild('userId') userIdElement: ElementRef;
  @ViewChild('signInNgForm') signInNgForm: NgForm;

  alert: { type: FuseAlertType; message: string } = {
    type: 'success',
    message: '',
  };
  signInForm: UntypedFormGroup;
  showAlert = false;
  siteCode: string;
  showOrganization = true;

  constructor(
    private _activatedRoute: ActivatedRoute,
    private _authService: AuthService,
    private _formBuilder: UntypedFormBuilder,
    private _router: Router,
    private _configService: FrontConfigService,
    private translocoService: TranslocoService,
  ) {}

  ngOnInit(): void {
    this.siteCode = this._configService.siteConfig.code;
    if (this.siteCode == 'dm' || this.siteCode == 'cy' || this.siteCode=='dm' || this.siteCode=='fcdm') {
      this.showOrganization = false;
    }

    this.signInForm = this._formBuilder.group({
      userId: ['admin', [Validators.required]],
      password: ['Rlaangus', Validators.required],
      rememberMe: [''],
    });
  }

  ngAfterViewInit() {
    // detection error를 우회하기 위해 setTimeout을 걸어야 한다
    setTimeout(() => this.userIdElement.nativeElement.focus(), 0);
  }

  signIn(): void {
    // Return if the form is invalid
    if (this.signInForm.invalid) {
      return;
    }

    // Disable the form
    this.signInForm.disable();

    // Hide the alert
    this.showAlert = false;

    // Sign in
    this._authService.signIn(this.signInForm.value).subscribe({
      next: (res) => {
        // Set the redirect url.
        // The '/signed-in-redirect' is a dummy url to catch the request and redirect the user
        // to the correct page after a successful sign in. This way, that url can be set via
        // routing file and we don't have to touch here.
        const redirectURL = this._activatedRoute.snapshot.queryParamMap.get('redirectURL') || '/signed-in-redirect';

        // Navigate to the redirect url
        this._router.navigateByUrl(redirectURL);
      },
      error: (res) => {
        // Re-enable the form
        this.signInForm.enable();

        // Reset the form
        //this.signInNgForm.resetForm();

        // Set the alert
        this.alert = {
          type: 'error',
          message: this.translocoService.translate('auth.wrongIdOrPassword'),
        };

        // Show the alert
        this.showAlert = true;
      }
    });
  }
}
