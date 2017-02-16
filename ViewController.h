//
//  ViewController.h
//  Looks Guru
//
//  Created by Techno Softwares on 06/01/15.
//  Copyright (c) 2015 Technosoftwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "ASIFormDataRequest.h"
#import "CommonFunctions.h"
#import "LGAlertView.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
//#import <GooglePlus/GooglePlus.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#define REGISTRATION_CODE

@class GPPSignInButton;

@interface ViewController : UIViewController<FBLoginViewDelegate,CLLocationManagerDelegate>

{
    IBOutlet UIView *viewSignIn;
    IBOutlet UIView *viewCreateProfile;
    IBOutlet UIView *viewSplashView;
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblOrSignInWith;
    IBOutlet UILabel *lblEmailErrorMessage;
    IBOutlet UILabel *lblPasswordErrorMessage;
    IBOutlet UILabel *lblRememberMe;
    UILabel *lblShowMessage;
    CLLocationManager * locationManger;
   
    
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    
    IBOutlet UIView *viewAdd;
    
    IBOutlet UIImageView *imgBackground;
    IBOutlet UIImageView *imgCheckBox;
    
    IBOutlet UIButton *btnSignIn;
    IBOutlet UIButton *btnCreateAccount;
    IBOutlet UIButton *btnForgotPassword;
    IBOutlet UIButton *btnCheckMark;
    
    IBOutlet UIButton *btn_FB;
    BOOL isAlertTextField;
    
    NSString *strTextField;
    NSString *strFacebookEMail;
    NSString *strFacebookName;
    
    MBProgressHUD *HUD;
    
    NSURL *urlForgotPassword;
    NSURL *urlLogin;
    
    NSMutableDictionary *userData;
    
    FBProfilePictureView *profilePictureView;
    
    FBLoginView *loginView;
    
#ifdef REGISTRATION_CODE
    
    IBOutlet UILabel *lblRegisterTitle;
    IBOutlet UILabel *lblRegisterEmailErrorMessage;
    IBOutlet UILabel *lblRegisterPasswordErrorMessage;
    IBOutlet UILabel *lblRegisterConfirmPasswordErrorMessage;
    
    UILabel *lblRegisterShowMessage;
    
    IBOutlet UITextField *txtRegisterEmail;
    IBOutlet UITextField *txtRegisterPassword;
    IBOutlet UITextField *txtRegisterConfirmPassword;
    
    IBOutlet UIView *viewAlert;
    
    IBOutlet UIImageView *imgRegisterBackground;
    
    IBOutlet UIButton *btnSignUp;
    IBOutlet UIButton *btnSiginInHere;
    
    NSURL *urlSignUp;
#endif
    
    
#ifndef SPALSH_ANIMATION
    IBOutlet UIImageView *imageAnimate;
    IBOutlet UIImageView *imageLogo;
    IBOutlet UIImageView *imageLogoWIthText;
    IBOutlet UIView *viewLogo;
    
    IBOutlet UILabel *lblAppName;
       IBOutlet UILabel *lbl_tagline;
    
    BOOL isAnimationCompleted, notLogin;
#endif
    
}

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;

-(IBAction)btnSubmitClicked:(id)sender;
-(IBAction)btnForgotPasswordClicked:(id)sender;
- (IBAction)btnCheckMarkClicked:(id)sender;

@end

