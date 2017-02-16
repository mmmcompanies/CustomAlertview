//
//  AppDelegate.h
//  Looks Guru
//
//  Created by Techno Softwares on 06/01/15.
//  Copyright (c) 2015 Technosoftwares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
//#import <GooglePlus/GooglePlus.h>
#import  <FBSDKCoreKit/FBSDKCoreKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CommonFunctions.h"
#import "Constants.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *contactsArray;
}

@property (strong, nonatomic) UIWindow *window;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (strong, nonatomic)	NSString	*deviceToken;
@property (strong, nonatomic)	NSString	*payload;
@property (strong, nonatomic)	NSString	*certificate;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState *) state error:(NSError* )error;

@end

