//
//  AppDelegate.m
//  Looks Guru
//
//  Created by Techno Softwares on 06/01/15.
//  Copyright (c) 2015 Technosoftwares. All rights reserved.
//

#import "AppDelegate.h"
#import <Google/Analytics.h>


@interface AppDelegate () <UIAlertViewDelegate>

{
    NSDictionary *dictNotificationPayload;
}

@end

@implementation AppDelegate
@synthesize soundFileObject, soundFileURLRef, window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [FBLoginView class];
    
    // Configure tracker from GoogleService-Info.plist.
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // Optional: configure GAI options.
//    GAI *gai = [GAI sharedInstance];
//    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
//    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
    {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIBarStyleBlackTranslucent;

    if (![CLLocationManager locationServicesEnabled]) {
        // location services is disabled, alert user
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DisabledTitle", @"DisabledTitle")
                                                                        message:NSLocalizedString(@"DisabledMessage", @"DisabledMessage")
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(@"OKButtonTitle", @"OKButtonTitle")
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    dictNotificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if(dictNotificationPayload.count > 0)
    {
        isPushNotification = YES;
        
        NSLog(@"Launched from push notification");
        NSDictionary *notification = [[NSDictionary alloc] init];
        notification = [dictNotificationPayload objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        NSString *strKey = [[dictNotificationPayload valueForKey:@"aps"] valueForKey:@"key"];
        strUserIDToGetFollowList = [[dictNotificationPayload valueForKey:@"aps"] valueForKey:@"user_id"];
        strPostIDFromPush = [[dictNotificationPayload valueForKey:@"aps"] valueForKey:@"post_id"];
        if(strKey.length > 0 && strKey)
        {
            [[NSUserDefaults standardUserDefaults] setObject:strKey forKey:@"notification"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //if ([strKey isEqualToString:@"Request"])
            {
                [[[UIAlertView alloc] initWithTitle:@"Message" message:[[dictNotificationPayload valueForKey:@"aps"] valueForKey:@"alert"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }
        }
        // Do something with the notification dictionary
    }
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState )state error:(NSError *)error
{
      [FBSession.activeSession closeAndClearTokenInformation];
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        
        // Show the user the logged-in UI
        //[self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelfblogin" object:nil];
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            //  [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                // [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                // [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
    }
}

- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation
{
//    return [GPPURLHandler handleURL:url
//                  sourceApplication:sourceApplication
//                         annotation:annotation];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSDKAppEvents activateApp];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken: %@", deviceToken);
    NSString *dt = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    dt = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    strDeviceToken = [[NSString alloc] initWithString:dt];//[NSString stringWithFormat:@"%@", deviceToken];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateDeviceToken" object:nil];
    
    if([loginData strUserId])
    {
        [self updateDeviceToken];
    }
    
    NSLog(@"~~~~devToken(dv)=%@",deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"ios"
                                                withExtension: @"mp3"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef, &soundFileObject);
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    dictNotificationPayload = userInfo;
    NSString *strKey = [[userInfo valueForKey:@"aps"] valueForKey:@"key"];
    strUserIDToGetFollowList = [[userInfo valueForKey:@"aps"] valueForKey:@"user_id"];
    strPostIDFromPush = [[userInfo valueForKey:@"aps"] valueForKey:@"post_id"];
    if(strKey.length > 0 && strKey)
    {
//        [[NSUserDefaults standardUserDefaults] setObject:strKey forKey:@"notification"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //if ([strKey isEqualToString:@"Request"])
        {
            [[[UIAlertView alloc] initWithTitle:@"Message" message:[[userInfo valueForKey:@"aps"] valueForKey:@"alert"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }
    //    intWarningNotificationCount = 0;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *strKey = [[dictNotificationPayload valueForKey:@"aps"] valueForKey:@"key"];
    
    if(strKey.length > 0 && strKey)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushnotification" object:nil userInfo:[NSDictionary dictionaryWithObject:dictNotificationPayload forKey:@"push"]];
    }
}

- (void)updateDeviceToken
{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL_UPDATE_DEVICE_TOKEN]];
    
    [request setPostValue:loginData.strUserId forKey:@"user_id"];
    [request setPostValue:strDeviceToken forKey:@"device_token"];
    
    [request setTimeOutSeconds:99999999999999999];
    
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [request responseString];
        
        responseString = [[responseString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        NSLog(@"%@", responseString);
        id results;
        
        SBJSON *parser = [[SBJSON alloc]init];
        
        results = [parser objectWithString:responseString error:nil];
        
        if ([[results objectForKey:@"result"] isEqualToString:@"success"])
        {
            NSLog(@"Device token updated for user id :  %@", loginData.strUserId);
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"%@",error);
    }];
    [request startAsynchronous];
}


@end