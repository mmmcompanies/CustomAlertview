//
//  ViewController.m
//  Looks Guru
//
//  Created by Techno Softwares on 06/01/15.
//  Copyright (c) 2015 Technosoftwares. All rights reserved.
//

#import "ViewController.h"
#import "Validate.h"
#import "LGPrivacyAndTCViewController.h"

//#import <GoogleOpenSource/GoogleOpenSource.h>
//#import <GooglePlus/GooglePlus.h>

@interface ViewController ()

@end



@implementation ViewController

static NSString * const kClientId = @"284666893917-ffc3gvhuc0dnu4r7n81pogl890rr8gic.apps.googleusercontent.com";

@synthesize signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    lblTitle.font = BRANDON_FONT((IS_IPAD)?70: 35);
    
    lblTitle.text = @"LOOKS GURU";
    
//    for (NSString *familyName in [UIFont familyNames]) {
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            NSLog(@"%@", fontName);
//        }
//    }
    
    viewAdd.layer.cornerRadius = viewAdd.frame.size.width/2;

    viewAdd.layer.borderColor = [UIColor whiteColor].CGColor;
    viewAdd.layer.borderWidth = 1.0;
    
    if(IS_IPHONE_4S)
    {
        imgBackground.image = [UIImage imageNamed:@"bg.png"];
    }
    else if (IS_IPHONE_6_PLUS)
    {
        imgBackground.image = [UIImage imageNamed:@"bg_iPhone6+"];
    }
    else if (IS_IPHONE_6)
    {
        imgBackground.image = [UIImage imageNamed:@"bg_iPhone6"];
    }
    
    
    
    loginData = [[LGLoginData alloc] init];
    locationManger = [[CLLocationManager alloc] init];
    loginData.strUserTypes = @"LooksGuru";
    
    txtEmail.font = BRANDON_REGULAR_FONT ((IS_IPAD)?40: 20);
    txtPassword.font = BRANDON_REGULAR_FONT((IS_IPAD)?40: 20);
    
    txtEmail.tintColor = [UIColor whiteColor];
    txtPassword.tintColor = [UIColor whiteColor];
    
    btnSignIn.layer.borderColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0].CGColor;
    btnSignIn.layer.borderWidth = 1.0f;
    btnSignIn.layer.cornerRadius = 8.0;
    btnSignIn.titleLabel.font = MYRIAD_PRO_REGULAR_FONT((IS_IPAD)?30: 20);
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    CGFloat x = viewSignIn.frame.size.width;
    
    viewCreateProfile.frame = CGRectMake(x, viewCreateProfile.frame.origin.y, viewCreateProfile.frame.size.width, viewCreateProfile.frame.size.height);
    
    lblOrSignInWith.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 18);
    
//    btn_FB.frame = CGRectMake(btn_FB.bounds.origin.x, ([UIScreen mainScreen].bounds.size.height * 0.833), btn_FB.frame.size.width, btn_FB.frame.size.height);
    
    CGRect frameRect =  btn_FB.frame;
    frameRect.origin.y = ([UIScreen mainScreen].bounds.size.height * 0.833);
    btn_FB.frame = frameRect;
    
    btnCreateAccount.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 11);
    btnForgotPassword.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 11);
    
    lblEmailErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 15);
    lblPasswordErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 15);
    
    [lblRememberMe setFont:BRANDON_REGULAR_FONT((IS_IPAD)?30: 14)];
    
    NSString *strForgotPassword = URL_FORGOT_PASSWORD;
    urlForgotPassword = [[NSURL alloc] initWithString:strForgotPassword];
    
    NSString *strLogin = URL_LOGIN;
    urlLogin = [[NSURL alloc] initWithString:strLogin];
    
    [btnSignIn setTitle:@"Sign In" forState:UIControlStateNormal];
    
    
    if ([txtEmail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
        txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
        txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
        
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email", @"user_relationships", @"read_stream", @"user_birthday"]];
    loginView.delegate = self;
    
    [self startSignificantChangeUpdates];
    
    [self startSplashAnimation];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"username"])
    {
        //[GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];
        
        NSLog(@"User already logged in........");
        strLoginWith = @"simple";
        txtEmail.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        txtPassword.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        [self loginUser];
    }
    else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FacebookEmail"])
    {
        //[GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];
        
        NSLog(@"User already logged in........");
        strLoginWith = @"facebook";
        strFacebookEMail = [[NSUserDefaults standardUserDefaults] objectForKey:@"FacebookEmail"];
        strFacebookName = [[NSUserDefaults standardUserDefaults] objectForKey:@"FacebookName"];
        [self loginUser];
    }
    
    else
    {
        //[viewSplashView setHidden:YES];
        notLogin = YES;
    }
    
#ifdef REGISTRATION_CODE
    
    lblRegisterTitle.font = BRANDON_FONT((IS_IPAD)?60: 35);
    
    lblRegisterTitle.text = @"LOOKS GURU";
    
    if(IS_IPHONE_4S)
    {
        imgRegisterBackground.image = [UIImage imageNamed:@"bg.png"];
    }
    else if (IS_IPHONE_6_PLUS)
    {
        imgRegisterBackground.image = [UIImage imageNamed:@"bg_iPhone6+"];
    }
    else if (IS_IPHONE_6)
    {
        imgRegisterBackground.image = [UIImage imageNamed:@"bg_iPhone6"];
    }
    
    txtRegisterEmail.font = BRANDON_REGULAR_FONT((IS_IPAD)?40: 20);
    txtRegisterPassword.font = BRANDON_REGULAR_FONT((IS_IPAD)?40: 20);
    txtRegisterConfirmPassword.font = BRANDON_REGULAR_FONT((IS_IPAD)?40: 20);
    
    txtRegisterEmail.tintColor = [UIColor whiteColor];
    txtRegisterPassword.tintColor = [UIColor whiteColor];
    txtRegisterConfirmPassword.tintColor = [UIColor whiteColor];
    
    NSString *strSignUp = URL_REGISTER;
    
    urlSignUp = [[NSURL alloc] initWithString:strSignUp];
    
    lblRegisterEmailErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 15);
    lblRegisterPasswordErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 15);
    lblRegisterConfirmPasswordErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 15);
    
    btnSignUp.layer.borderColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0].CGColor;
    btnSignUp.layer.borderWidth = 1.0f;
    btnSignUp.layer.cornerRadius = 8.0;
    btnSignUp.titleLabel.font = MYRIAD_PRO_REGULAR_FONT((IS_IPAD)?40: 20);
    [btnSignUp setTitle:@"Sign Up" forState:UIControlStateNormal];
    
    btnSiginInHere.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?40: 17);
    
    
    if ([txtRegisterEmail respondsToSelector:@selector(setAttributedPlaceholder:)])
    {
        UIColor *color = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
        txtRegisterEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
        txtRegisterPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
        txtRegisterConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color}];
    }
    else
    {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
#endif
    
    if([CommonFunctions isConnectedToInternet])
    {
        [self performSelectorInBackground:@selector(getAlertMessagesFromServer) withObject:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [viewSplashView setHidden:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark-btnMethod
- (IBAction)btnCheckMarkClicked:(id)sender
{
        //[imgCheckBox setImage:[UIImage imageNamed:@"chk-box.png"]];
    
    if([btnCheckMark tag] == 0)
    {
        //[btnCheckMark setBackgroundImage:[UIImage imageNamed: @"chk-box.png"] forState:UIControlStateNormal];
        [imgCheckBox setImage:[UIImage imageNamed:@"chk-box.png"]];
        [btnCheckMark setTag:1];
    }
    else
    {
        //[btnCheckMark setBackgroundImage:[UIImage imageNamed: @"box.png"] forState:UIControlStateNormal];
        [imgCheckBox setImage:[UIImage imageNamed:@"box.png"]];
        [btnCheckMark setTag:0];
    }
}


-(IBAction)btnSubmitClicked:(id)sender
{
    BOOL isValid = YES;
    if(txtEmail.text.length == 0)
    {
        isValid = NO;
        [txtEmail becomeFirstResponder];
        lblEmailErrorMessage.text = @"Please enter your e-mail address.";
        [self fadein:lblEmailErrorMessage];
        return;
    }
    else if (![Validate isValidEmailId:txtEmail.text])
    {
        isValid = NO;
        [txtEmail becomeFirstResponder];
        lblEmailErrorMessage.text = @"Invalid e-mail address.";
        [self fadein:lblEmailErrorMessage];
        return;
    }
    else if (!txtPassword.text.length > 0)
    {
        isValid = NO;
        [txtPassword becomeFirstResponder];
        lblPasswordErrorMessage.text = @"Please enter your password.";
        [self fadein:lblPasswordErrorMessage];
        return;
    }
    
    
    else
    {
        [GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];
        strLoginWith = @"simple";
        
        [self performSelectorInBackground:@selector(loginUser) withObject:nil];
    }
}


- (IBAction)btnCreateAccountClicked:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [viewSignIn setFrame:CGRectMake(viewSignIn.frame.origin.x - viewSignIn.frame.size.width, viewSignIn.frame.origin.y, viewSignIn.frame.size.width, viewSignIn.frame.size.height)];
    
    [viewCreateProfile setFrame:CGRectMake(viewCreateProfile.frame.size.width - viewCreateProfile.frame.origin.x, viewCreateProfile.frame.origin.y, viewCreateProfile.frame.size.width, viewCreateProfile.frame.size.height)];
    
    [UIView commitAnimations];
}

- (IBAction)btnAlreadyMemberClicked:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    [viewSignIn setFrame:CGRectMake(viewSignIn.frame.size.width + viewSignIn.frame.origin.x, viewSignIn.frame.origin.y, viewSignIn.frame.size.width, viewSignIn.frame.size.height)];
    
    [viewCreateProfile setFrame:CGRectMake(viewCreateProfile.frame.size.width + viewCreateProfile.frame.origin.x, viewCreateProfile.frame.origin.y, viewCreateProfile.frame.size.width, viewCreateProfile.frame.size.height)];
    
    [UIView commitAnimations];
}

-(IBAction)btnForgotPasswordClicked:(id)sender
{
    isAlertTextField = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password?" message:@"Please enter your email address" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send e-mail", nil];
    alert.delegate = self;
    alert.alertViewStyle= UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        UITextField *title1 = [alertView textFieldAtIndex:0];
        
        title1= [alertView textFieldAtIndex:0];
        NSString *title = title1.text;
        NSLog(@"The name is %@",title);
        NSLog(@"Using the Textfield: %@",[[alertView textFieldAtIndex:0] text]);
        
        strTextField = [[alertView textFieldAtIndex:0] text];
        
        [GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];
        
        [self performSelectorInBackground:@selector(forgotPassword) withObject:nil];
        
    }
    isAlertTextField = NO;
}

-(IBAction)loginWithFacebook:(id)sender
{
    if([CommonFunctions isConnectedToInternet])
    {
        strLoginWith = @"facebook";
        
        if (FBSession.activeSession.state == FBSessionStateOpen
            || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
            
            // Close the session and remove the access token from the cache
            // The session state handler (in the app delegate) will be called automatically
            [FBSession.activeSession closeAndClearTokenInformation];
            
            // If the session state is not any of the two "open" states when the button is clicked
        } else {
            // Open a session showing the user the login UI
            // You must ALWAYS ask for basic_info permissions when opening a session
            [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email", @"read_stream", @"user_relationships", @"user_birthday"]
                                               allowLoginUI:YES
                                          completionHandler:
             ^(FBSession *session, FBSessionState state, NSError *error) {
                 
                 // Retrieve the app delegate
                 AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                 // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
                 [appDelegate sessionStateChanged:session state:state error:error];
             }];
        }
    }
    else
    {
        [CommonFunctions alertForNoInternetConnection];
    }
}

#pragma mark
#pragma mark webServiceMethod
-(void)forgotPassword
{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:urlForgotPassword];
    
    [request setPostValue:strTextField forKey:@"email"];
    
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestForForgotPasswordFail:)];
    [request setDidFinishSelector:@selector(requestForgotPasswordSuccess:)];
    
    [request setTimeOutSeconds:99999999999];
    [request startAsynchronous];
}

-(void)requestForForgotPasswordFail:(ASIFormDataRequest *)request
{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSLog(@"%@", request.responseString);
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [CommonFunctions alertForNoInternetConnection];
                   });
}

-(void)requestForgotPasswordSuccess:(ASIFormDataRequest *)request
{
    NSString *responseString = [request responseString];
    responseString = [[responseString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    NSMutableDictionary *results = [parser objectWithString:responseString error:nil];
    
    NSString *strResult = [results objectForKey:@"result"];
    
    if([strResult isEqualToString:@"success"])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [[[UIAlertView alloc] initWithTitle:@"Your password has been sent to your email." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                           [GMDCircleLoader hideFromView:self.view animated:YES];
                       });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [[[UIAlertView alloc] initWithTitle:@"This email id is not registerd with any account!" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                           
                           [GMDCircleLoader hideFromView:self.view animated:YES];
                       });
    }
}

- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManger)
        locationManger = [[CLLocationManager alloc] init];
    
    locationManger.desiredAccuracy = kCLLocationAccuracyBest;
    
    locationManger.delegate = self;
    
    if ([locationManger  respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManger requestWhenInUseAuthorization];
    }
    [locationManger startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];

    if (location)//abs(howRecent) < 15.0)
    {
        loginData.strLongitidue  = [NSString stringWithFormat:@"%.6f", location.coordinate.longitude];
        loginData.strLatitude   = [NSString stringWithFormat:@"%.6f", location.coordinate.latitude];
        
        //NSLog(@"latitude %+.6f, longitude %+.6f\n", location.coordinate.latitude, location.coordinate.longitude);
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
//                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           //NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
                       strGetLocation = placemark.locality;
//                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                       NSLog(@"placemark.country %@",placemark.country);
//                       NSLog(@"placemark.postalCode %@",placemark.postalCode);
//                       NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//                       NSLog(@"placemark.locality %@",placemark.locality);
//                       NSLog(@"placemark.subLocality %@",placemark.subLocality);
//                       NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
                       
                   }];
}

-(void)loginUser
{
    NSString *strFirstName;
    NSString *strLastName;
    
    NSScanner *scanner = [NSScanner scannerWithString:strFacebookName];
    [scanner scanUpToString:@" " intoString:&strFirstName];
    
    [scanner scanString:@" " intoString:nil];
    
    strLastName = [strFacebookName substringFromIndex:scanner.scanLocation];
    strLastName = [strLastName stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:urlLogin];
    
    if([strLoginWith isEqualToString:@"simple"])
    {
        [request setPostValue:txtEmail.text forKey:@"email"];
        [request setPostValue:txtPassword.text forKey:@"password"];
       
        [request setPostValue:strLoginWith forKey:@"login_with"];
    }
    else if ([strLoginWith isEqualToString:@"facebook"])
    {
        [request setPostValue:strFacebookEMail forKey:@"email"];
        [request setPostValue:strFirstName forKey:@"first_name"];
        [request setPostValue:strLastName forKey:@"last_name"];
        [request setPostValue:strLoginWith forKey:@"login_with"];
    }
    
    if(!loginData.strLatitude || !loginData.strLongitidue)
    {
        [request setPostValue:@"0" forKey:@"latitude"];
        [request setPostValue:@"0" forKey:@"longitude"];
    }
    else
    {
        [request setPostValue:loginData.strLatitude forKey:@"latitude"];
        [request setPostValue:loginData.strLongitidue forKey:@"longitude"];
    }
    
    [request setPostValue:@"iOS" forKey:@"device_type"];
    [request setPostValue:strDeviceToken forKey:@"device_token"];
    
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestForLoginFail:)];
    [request setDidFinishSelector:@selector(requestForLoginSuccess:)];
    
    [request setTimeOutSeconds:99999999999];
    [request startSynchronous];
}

-(void)requestForLoginFail:(ASIFormDataRequest *)request
{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSLog(@"%@", request.responseString);
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [GMDCircleLoader hideFromView:self.view animated:YES];
                       [viewSplashView setHidden:YES];
                       [CommonFunctions alertForNoInternetConnection];
                   });
}


-(void)requestForLoginSuccess:(ASIFormDataRequest *)request
{
    NSString *responseString = [request responseString];
    responseString = [[responseString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    NSMutableDictionary *results = [parser objectWithString:responseString error:nil];
    
    NSString *strResult = [results objectForKey:@"result"];
    
    if([strResult isEqualToString:@"success"])
    {
        loginData.strUserId = [NSString stringWithFormat:@"%@", [results objectForKey:@"id"]];
        loginData.strFirstName = [NSString stringWithFormat:@"%@", [results objectForKey:@"first_name"]];
        loginData.strLastName = [NSString stringWithFormat:@"%@", [results objectForKey:@"last_name"]];
        loginData.strDisplayName = [NSString stringWithFormat:@"%@", [results objectForKey:@"display_name"]];
        
        NSString *text = loginData.strDisplayName;
        if (text.length>0)
        {
            loginData.strDisplayName = [[[text substringToIndex:1] uppercaseString] stringByAppendingString:[text substringFromIndex:1]];
        }
        NSLog(@"%@ uppercased is %@", text, loginData.strDisplayName);
        
        loginData.strBirthday = [NSString stringWithFormat:@"%@", [results objectForKey:@"dob"]];
        loginData.strUserProfile = [NSString stringWithFormat:@"%@/%@", URL_MAIN, [results objectForKey:@"image"]];
        loginData.strGender = [NSString stringWithFormat:@"%@", [results objectForKey:@"gender"]];
        loginData.strLocation = [NSString stringWithFormat:@"%@", [results objectForKey:@"location"]];
        
        NSString *straboutPic = [[results objectForKey:@"style_mantra"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"[%@]", straboutPic);
        straboutPic = [straboutPic stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        loginData.strStyleMantra = straboutPic;
        loginData.strPostCount = [NSString stringWithFormat:@"%@", [results objectForKey:@"post_count"]];
        loginData.strFollowingCount = [NSString stringWithFormat:@"%@", [results objectForKey:@"count_following"]];
        loginData.strFollowersCount = [NSString stringWithFormat:@"%@", [results objectForKey:@"count_follower"]];
        loginData.strPrivacyStatus = [NSString stringWithFormat:@"%@", [results objectForKey:@"user_privacy"]];
        loginData.strUserTypes = [NSString stringWithFormat:@"%@", [results objectForKey:@"user_type"]];
        loginData.strEmail = txtEmail.text;
        
        dictUserData = [[NSMutableDictionary alloc] init];
        dictUserData = [[[NSUserDefaults standardUserDefaults] objectForKey:loginData.strUserId] mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           if(isAnimationCompleted)
                           {
                               [self taskAfterLogin];
                           }
                       });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [[[UIAlertView alloc] initWithTitle:@"" message:strResult delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                           
                           [GMDCircleLoader hideFromView:self.view animated:YES];
                            [viewSplashView setHidden:YES];
                       });
    }
}

- (void)taskAfterLogin
{
    if(loginData.strGender.length == 0)
    {
        if([dictFacebookUswerData objectForKey:@"gender"])
        {
            loginData.strGender = [[[[dictFacebookUswerData objectForKey:@"gender"] substringToIndex:1] uppercaseString] stringByAppendingString:[[dictFacebookUswerData objectForKey:@"gender"] substringFromIndex:1]];
        }
        if([dictFacebookUswerData objectForKey:@"first_name"])
        {
            loginData.strFirstName = [dictFacebookUswerData objectForKey:@"first_name"];
        }
        if([dictFacebookUswerData objectForKey:@"last_name"])
        {
            loginData.strLastName = [dictFacebookUswerData objectForKey:@"last_name"];
        }
        if([dictFacebookUswerData objectForKey:@"birthday"])
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MM/dd/yyyy";
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            NSDate *dob = [dateFormatter dateFromString:[dictFacebookUswerData objectForKey:@"birthday"]];
            loginData.strBirthday = [dateFormatter stringFromDate:dob];
        }
        
        [self performSegueWithIdentifier:@"createprofile" sender:self];
    }
    else if (loginData.strStyleMantra.length == 0)
    {
        loginData.imgProfile = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:loginData.strUserProfile]]];
        CGSize newSize = [CommonFunctions getCustomHeightForProfilePic:loginData.imgProfile];
        NSLog(@"New Height: %f %f", newSize.width, newSize.height);
        loginData.imgProfile = [CommonFunctions imageWithImage:loginData.imgProfile scaledToSize:newSize];
        
        [self performSegueWithIdentifier:@"first_look" sender:self];
    }
    else
    {
        loginData.imgProfile = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:loginData.strUserProfile]]];
        CGSize newSize = [CommonFunctions getCustomHeightForProfilePic:loginData.imgProfile];
        NSLog(@"New Height: %f %f", newSize.width, newSize.height);
        loginData.imgProfile = [CommonFunctions imageWithImage:loginData.imgProfile scaledToSize:newSize];
        
        [self performSegueWithIdentifier:@"logintohome" sender:self];
    }
    
    if(btnCheckMark.tag == 1 || [strLoginWith isEqualToString:@"facebook"])
    {
        if([strLoginWith isEqualToString:@"facebook"])
        {
            loginData.strEmail = strFacebookEMail;
            [[NSUserDefaults standardUserDefaults] setObject:strFacebookEMail forKey:@"FacebookEmail"];
            [[NSUserDefaults standardUserDefaults] setObject:strFacebookName forKey:@"FacebookName"];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:txtEmail.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:txtPassword.text forKey:@"password"];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [txtEmail setText:@""];
    [txtPassword setText:@""];
    
    [GMDCircleLoader hideFromView:self.view animated:YES];
}

-(void)fadein:(UILabel *)lblMessage;
{
    lblShowMessage = lblMessage;
    lblShowMessage.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //don't forget to add delegate.....
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:1.5];
    lblShowMessage.alpha = 1;
    
    //also call this before commit animations......
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished  context:(void *)context
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:6];
    lblShowMessage.alpha = 0;
    [UIView commitAnimations];
}

#define MYCHANGES
#ifdef MYCHANGES

-(IBAction)btnFacebookClicked:(id)sender
{
    FBSDKLoginManager *login = [FBSDKLoginManager new];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [login logOut];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] handler:^(FBSDKLoginManagerLoginResult* result, NSError* error) {
        if (error)
        {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations"
        } else {
            
            FBSDKProfilePictureView *picture = [FBSDKProfilePictureView new];
            
            picture.profileID = @"me";
            
            NSLog(@"%@",result);
            
            if ([FBSDKAccessToken currentAccessToken])
            {
                [GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];

                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result, NSError *error) {
                     if (!error) {
                         
                         NSLog(@"%@",result);
                         FBSDKProfile *profile = [FBSDKProfile currentProfile];
                         NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:profile.userID,@"UserId",profile.name,@"UserName", nil];                         
                         NSLog(@"%@",dict);
                         
                         dictFacebookUswerData = [[NSDictionary alloc] initWithDictionary:result];
                         strLoginWith = @"facebook";
                         strFacebookEMail = [result valueForKey:@"email"];
                         strFacebookName = [result valueForKey:@"name"];                         
                         
                        [self performSelectorInBackground:@selector(loginUser) withObject:nil];
                     }
                 }];
            }
            
            
            //[self performSegueWithIdentifier:@"details" sender:self];
            
        }
    }];
}

#endif


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    @try {
        profilePictureView.profileID = [user objectForKey:@"id"];
        
        userData = [[NSMutableDictionary alloc]init];
        NSDictionary *dict = [user objectForKey:@"location"];
        
        [userData setObject:[user objectForKey:@"id"] forKey:@"userid"];
        if([user objectForKey:@"email"])
        {
            [userData setObject:[user objectForKey:@"email"] forKey:@"email"];
            strFacebookEMail = [user objectForKey:@"email"];
        }
        
        [userData setObject:[user objectForKey:@"name"] forKey:@"name"];
        strFacebookName = [user objectForKey:@"name"];
        
        if(dict)
        {
            [userData setObject:[dict objectForKey:@"name"] forKey:@"location"];
        }
        
        if([user objectForKey:@"gender"])
        {
            [userData setObject:[user objectForKey:@"gender"] forKey:@"gender"];
        }
        
        NSURL *url;
        if(IS_IPAD)
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&redirect=true&width=720&height=720",[user objectForKey:@"id"]]];
        }
        else
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&redirect=true&width=720&height=720",[user objectForKey:@"id"]]];
        }
        
        NSData *imgData =  [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:nil];
        if(imgData)
        {
            [userData setObject:imgData forKey:@"image"];
        }
        else
        {
            
        }
        
        strLoginWith = @"facebook";
        
        [GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];

        [self loginUser];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    @finally {
        
    }
    
}

//- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
//                   error: (NSError *) error {
//    NSLog(@"Received error %@ and auth object %@",error, auth);
//    if (error) {
//        // Do some error handling here.
//    } else {
//       // [self refreshInterfaceBasedOnSignIn];
//    }
//}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    if (![Validate isValidEmailId:textField.text])
    {
        return NO;
    }
    return YES;
}


#ifdef REGISTRATION_CODE

-(IBAction)btnSignUpClicked:(id)sender
{
    BOOL isValid = YES;
    if(txtRegisterEmail.text.length == 0)
    {
        isValid = NO;
        [txtRegisterEmail becomeFirstResponder];
        lblRegisterEmailErrorMessage.text = @"Please enter your e-mail address";
        [self fadein:lblRegisterEmailErrorMessage];
        return;
    }
    else if (![Validate isValidEmailId:txtRegisterEmail.text])
    {
        isValid = NO;
        [txtRegisterEmail becomeFirstResponder];
        lblRegisterEmailErrorMessage.text = @"Invalid e-mail address.";
        [self fadein:lblRegisterEmailErrorMessage];
        return;
    }
    else if (txtRegisterPassword.text.length == 0)
    {
        isValid = NO;
        [txtRegisterPassword becomeFirstResponder];
        lblRegisterPasswordErrorMessage.text = @"Please enter your password.";
        [self fadein:lblRegisterPasswordErrorMessage];
        return;
    }
    else if (txtRegisterPassword.text.length < 6)
    {
        isValid = NO;
        [txtRegisterPassword becomeFirstResponder];
        lblRegisterPasswordErrorMessage.text = @"Password must be atleast 6 characters long.";
        [self fadein:lblRegisterPasswordErrorMessage];
        return;
    }
//    else if (![Validate isValidPasswordCharcter:txtRegisterPassword.text])
//    {
//        isValid = NO;
//        [txtRegisterPassword becomeFirstResponder];
//        lblRegisterPasswordErrorMessage.text = @"Invalid password.";
//        [self fadein:lblRegisterPasswordErrorMessage];
//        return;
//    }
    
    else if ([self FindCharacter:txtRegisterPassword.text])
    {
        isValid = NO;
        [txtRegisterPassword becomeFirstResponder];
        lblRegisterPasswordErrorMessage.text = @"Must Contain Special Charchter.";
        [self fadein:lblRegisterPasswordErrorMessage];
        return;
    }
    
    else if (!txtRegisterConfirmPassword.text.length > 0)
    {
        isValid = NO;
        [txtRegisterConfirmPassword becomeFirstResponder];
        lblRegisterConfirmPasswordErrorMessage.text = @"Please enter Confirm Password.";
        [self fadein:lblRegisterConfirmPasswordErrorMessage];
        return;
    }
    
    
    else if (![txtRegisterPassword.text isEqualToString:txtRegisterConfirmPassword.text])
    {
        isValid = NO;
        lblRegisterConfirmPasswordErrorMessage.text = @"Confirm Password & Password are not same.";
        [self fadein:lblRegisterConfirmPasswordErrorMessage];
        return;
    }
    else
    {
        [self performSelectorInBackground:@selector(registerUser) withObject:nil];
        [GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];
    }
}

-(BOOL)FindCharacter:(NSString *)string
{
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    if ([string rangeOfCharacterFromSet:set].location != NSNotFound) {
        return NO;
    }
    return YES;
}

-(void)registerUser
{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:urlSignUp];
    
    [request setPostValue:txtRegisterEmail.text forKey:@"email"];
    [request setPostValue:txtRegisterPassword.text forKey:@"password"];
    
    if(!loginData.strLatitude || !loginData.strLongitidue)
    {
        [request setPostValue:@"0" forKey:@"latitude"];
        [request setPostValue:@"0" forKey:@"longitude"];
    }
    else
    {
        [request setPostValue:loginData.strLatitude forKey:@"latitude"];
        [request setPostValue:loginData.strLongitidue forKey:@"longitude"];
    }
    
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestForRegisterFail:)];
    [request setDidFinishSelector:@selector(requestForRegisterSuccess:)];
    
    [request setTimeOutSeconds:99999999999];
    [request startSynchronous];
}

-(void)requestForRegisterFail:(ASIFormDataRequest *)request
{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSLog(@"%@", request.responseString);
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [CommonFunctions alertForNoInternetConnection];
                   });
}

-(void)requestForRegisterSuccess:(ASIFormDataRequest *)request
{
    NSString *responseString = [request responseString];
    responseString = [[responseString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    
    NSMutableDictionary *results = [parser objectWithString:responseString error:nil];
    
    NSString *strResult = [results objectForKey:@"result"];
    
    dictUserData = [[NSMutableDictionary alloc] init];    
    
    if([strResult isEqualToString:@"success"])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           loginData.strUserId = [NSString stringWithFormat:@"%@", [results objectForKey:@"user_id"]];
                           loginData.strFirstName = @"";
                           loginData.strLastName = @"";
                           loginData.strDisplayName = @"";
                           loginData.strBirthday = @"";
                           loginData.strGender = @"";
                           loginData.strLocation = @"";
                           loginData.strPrivacyStatus = @"0";
                           loginData.strUserTypes = @"simple";
                           strLoginWith = @"simple";
                           loginData.strEmail = [txtEmail text];
                           
                           [txtRegisterEmail setText:@""];
                           [txtRegisterPassword setText:@""];
                           [txtRegisterConfirmPassword setText:@""];
                           
                           [[NSUserDefaults standardUserDefaults] setObject:[results objectForKey:@"user_id"] forKey:@"userid"];
                           [[NSUserDefaults standardUserDefaults] synchronize];
                           [self performSegueWithIdentifier:@"createprofile" sender:self];
                           [GMDCircleLoader hideFromView:self.view animated:YES];
                           [self btnAlreadyMemberClicked:btnSiginInHere];
                       });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [[[UIAlertView alloc] initWithTitle:@"" message:strResult delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                           [GMDCircleLoader hideFromView:self.view animated:YES];
                       });
    }
}

#endif

#pragma mark - Get Alert Messages From Server

- (void)getAlertMessagesFromServer
{
    __block ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URL_ALERT_MESSAGES_CONTENTS]];
    
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        responseString = [[responseString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        SBJSON *parser = [[SBJSON alloc]init];
        
        
        id results = [parser objectWithString:responseString error:nil];
        if([results isKindOfClass:[NSArray class]])
        {
            arrAlertMessages = [[NSMutableArray alloc] init];
            for(int i = 0; i < [results count]; i++)
            {
                LGAlertMessage *alert = [[LGAlertMessage alloc] init];
                [alert setStrAlertID:[[results objectAtIndex:i] objectForKey:@"id"]];
                [alert setStrALertType:[[results objectAtIndex:i] objectForKey:@"type"]];
                [alert setStrAlertTitle:[[results objectAtIndex:i] objectForKey:@"title"]];
                [alert setStrAlertContent:[[results objectAtIndex:i] objectForKey:@"content"]];
                
                [arrAlertMessages addObject:alert];
            }
        }
        else
        {
            NSLog(@"Wromg output: %@", results);
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error);
    }];
    [request setTimeOutSeconds:99999999];
    [request startAsynchronous];
}

#pragma mark - touchMethod

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (txtEmail == textField)
    {
        [txtEmail resignFirstResponder];
        [txtPassword becomeFirstResponder];
        //[textField becomeFirstResponder];
        
    }
    else
    {
        
        [textField resignFirstResponder];
    }
    
    return NO;
}

#ifndef SPALSH_ANIMATION

- (void)startSplashAnimation
{
    UIImage *amin = [UIImage animatedImageNamed:@"moonwalk-" duration:1.0f];
    
    [imageAnimate setImage:amin];
    
    lbl_tagline.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width /2) - 75, ([UIScreen mainScreen].bounds.size.height /2) + 90, lbl_tagline.frame.size.width, lbl_tagline.frame.size.height);
    
    [imageAnimate setAlpha:1.0];
    imageAnimate.frame = CGRectMake(-imageAnimate.frame.size.width, imageAnimate.frame.origin.y, imageAnimate.frame.size.width, imageAnimate.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:7.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    // [imageAnimate setAlpha:0.0];
    imageAnimate.frame = CGRectMake(self.view.frame.size.width, imageAnimate.frame.origin.y, imageAnimate.frame.size.width, imageAnimate.frame.size.height);
    [UIView commitAnimations];
    
    [viewLogo setAlpha:1.0];
    [self performSelector:@selector(startLogoAnimation) withObject:nil afterDelay:4.0];
    
    lblAppName.layer.shadowColor = [lblAppName.textColor CGColor];
    lblAppName.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    
    lblAppName.layer.shadowRadius = 5.0;
    lblAppName.layer.shadowOpacity = 0.7;
    
    lblAppName.layer.masksToBounds = NO;
    [lblAppName setAlpha:0.0];
    
    lbl_tagline.layer.shadowColor = [lbl_tagline.textColor CGColor];
    lbl_tagline.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    
    lbl_tagline.layer.shadowRadius = 5.0;
    lbl_tagline.layer.shadowOpacity = 0.7;
    
    lbl_tagline.layer.masksToBounds = NO;
    [lbl_tagline setAlpha:0.0];
    
    imageLogoWIthText.layer.shadowColor = [lblAppName.textColor CGColor];
    imageLogoWIthText.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    
    imageLogoWIthText.layer.shadowRadius = 5.0;
    imageLogoWIthText.layer.shadowOpacity = 0.7;
    
    imageLogoWIthText.layer.masksToBounds = NO;
    [imageLogoWIthText setAlpha:0.0];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    isAnimationCompleted = YES;
    
    if(loginData.strUserId)
    {
        [self taskAfterLogin];
    }
    else if (notLogin)
    {
        [viewSplashView setHidden:YES];
    }
}

- (void)endGlowingAnimation
{
    
}

-(void)startLogoAnimation
{
    [lblAppName setAlpha:0.0];
    [lbl_tagline setAlpha:0.0];
    
    [imageLogoWIthText setAlpha:0.0];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endGlowingAnimation)];
    [lblAppName setAlpha:1.0];
    [imageLogoWIthText setAlpha:1.0];
    [lbl_tagline setAlpha:1.0];
    [UIView commitAnimations];
}

#endif

- (IBAction)btnPrivacyClicked:(id)sender
{
    LGPrivacyAndTCViewController *privacy = (LGPrivacyAndTCViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyAndTCView"];
    privacy.strURLToLoad = @"http://looksguru.com/privacy";
    [self presentViewController:privacy animated:YES completion:nil];
}

- (IBAction)btnTermsAndConditionsClicked:(id)sender
{
    LGPrivacyAndTCViewController *tnc = (LGPrivacyAndTCViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyAndTCView"];
    tnc.strURLToLoad = @"http://looksguru.com/terms";
    [self presentViewController:tnc animated:YES completion:nil];
}

@end