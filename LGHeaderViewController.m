//
//  LGHeaderViewController.m
//  Looks Guru
//
//  Created by Apple Mac Mini on 08/01/15.
//  Copyright (c) 2015 Technosoftwares. All rights reserved.
//

#import "LGHeaderViewController.h"
#import "LGNotificationsCenterViewController.h"
#import "LGPostLookViewController.h"
#import "Constants.h"
#import "SWRevealViewController.h"
@interface LGHeaderViewController ()

@end

@implementation LGHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (IS_IPAD) ? 85.0f : 65)];
   // [self setNeedsStatusBarAppearanceUpdate];

    
    viewHeader.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:17.0/255.0 blue:33.0/255.0 alpha:1.0];
    [self.view addSubview:viewHeader];
    
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,(IS_IPAD) ? 25.0f: 20, self.view.frame.size.width, 40)];
    lblTitle.font = BRANDON_REGULAR_FONT((IS_IPAD)?32: 16);
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [viewHeader addSubview:lblTitle];
    
//    imgProfilePicView = [[UIImageView alloc] initWithFrame:CGRectMake(50, (IS_IPAD) ? 35.0f: 22.5, 35, 35)];
    imgProfilePicView = [[UIImageView alloc] initWithFrame:CGRectMake(50, (IS_IPAD)?30: 25, (IS_IPAD)? 40 : 30,(IS_IPAD)?40: 30)];
    imgProfilePicView.layer.cornerRadius = 17;
    imgProfilePicView.clipsToBounds = YES;
    imgProfilePicView.layer.cornerRadius = imgProfilePicView.frame.size.width/2;
    [imgProfilePicView setClipsToBounds:YES];
    imgProfilePicView.layer.borderWidth = 1.0;
    [imgProfilePicView setContentMode:UIViewContentModeScaleAspectFill];
    imgProfilePicView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(1, (IS_IPAD) ? 32.5f: 20, 45, 40)];
    [btnLeft setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
    [btnLeft setTitle:@"" forState:UIControlStateNormal];
    btnLeft.backgroundColor = [UIColor clearColor];
    
//    [btnLeft addTarget:self.revealViewController action:@selector(btnLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnLeft addTarget:self action:@selector(btnLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    btnBack = [[UIButton alloc]initWithFrame:CGRectMake(5,(IS_IPAD)?30: 25, (IS_IPAD)? 40 : 30,(IS_IPAD)?40: 30)];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack setTitle:@"" forState:UIControlStateNormal];
    btnBack.backgroundColor = [UIColor clearColor];
    
    [btnBack addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    btnAddPost = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - ((IS_IPAD)? 45 : 35), (IS_IPAD) ? 32.5f: 25, (IS_IPAD)? 40 : 30, (IS_IPAD)? 40 : 30)];
    [btnAddPost setImage:[UIImage imageNamed:@"add-cap.png"] forState:UIControlStateNormal];
    [btnAddPost setTitle:@"" forState:UIControlStateNormal];
    btnAddPost.backgroundColor = [UIColor clearColor];
    [btnAddPost setClipsToBounds:YES];
    [[btnAddPost layer] setCornerRadius:btnAddPost.frame.size.height / 2];
    [[btnAddPost layer] setBorderWidth:1.0];
    [[btnAddPost layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [btnAddPost addTarget:self action:@selector(btnAddPostClicked) forControlEvents:UIControlEventTouchUpInside];
    
    btnNotification = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - ((IS_IPAD)? 90 : 70), (IS_IPAD) ? 32.5f: 25, (IS_IPAD)? 40 : 30, (IS_IPAD)? 40 : 30)];
    //[btnNotification setBackgroundImage:[UIImage imageNamed:@"notification.png"] forState:UIControlStateNormal];
    [btnNotification setTitle:@"!" forState:UIControlStateNormal];
    btnNotification.backgroundColor = [UIColor clearColor];
    [btnNotification setClipsToBounds:YES];
    [[btnNotification layer] setCornerRadius:btnNotification.frame.size.height / 2];
    [[btnNotification layer] setBorderWidth:1.0];
    [[btnNotification layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [btnNotification addTarget:self action:@selector(btnNotificationCenterClicked) forControlEvents:UIControlEventTouchUpInside];
    
    btnUploadLook = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 65, (IS_IPAD) ? 55.0f: 30, 50, 20)];
    
    if (IS_IPAD)
    {
        btnUploadLook.frame = CGRectMake(self.view.frame.size.width -90, 40,80,30);
    }
    
    [btnUploadLook setTitle:@"POST" forState:UIControlStateNormal];
    btnUploadLook.backgroundColor = [UIColor clearColor];
    [btnUploadLook addTarget:self action:@selector(btnUploadLookClicked) forControlEvents:UIControlEventTouchUpInside];
    [[btnUploadLook titleLabel] setFont:[UIFont fontWithName:[[[btnUploadLook titleLabel] font] fontName] size:(IS_IPAD)?19:15]];
    [btnUploadLook setClipsToBounds:YES];
    [[btnUploadLook layer] setCornerRadius:btnUploadLook.frame.size.height / 2];
    [[btnUploadLook layer] setBorderWidth:1.0];
    [[btnUploadLook layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [btnUploadLook setHidden:YES];
    [btnBack setHidden:YES];
    
    btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - ((IS_IPAD)? 45 : 35), (IS_IPAD) ? 32.5f: 25, (IS_IPAD)? 40 : 30, (IS_IPAD)? 40 : 30)];
    [btnSearch setImage:[UIImage imageNamed:@"search-icon.png"] forState:UIControlStateNormal];
    [btnSearch setTitle:@"" forState:UIControlStateNormal];
    btnSearch.backgroundColor = [UIColor clearColor];
    [btnSearch setClipsToBounds:YES];
    [[btnSearch layer] setCornerRadius:btnSearch.frame.size.height / 2];
    [[btnSearch layer] setBorderWidth:1.0];
    [[btnSearch layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [btnSearch addTarget:self action:@selector(btnShoFindboxClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnSearch setHidden:YES];
    [viewHeader addSubview:btnSearch];
    
    btnReportUser = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - ((IS_IPAD)? 45 : 35), (IS_IPAD) ? 32.5f: 25, (IS_IPAD)? 40 : 30, (IS_IPAD)? 40 : 30)];
    [btnReportUser setImage:[UIImage imageNamed:@"report_flag.png"] forState:UIControlStateNormal];
    [btnReportUser setTitle:@"" forState:UIControlStateNormal];
    btnReportUser.backgroundColor = [UIColor whiteColor];
    [btnReportUser setClipsToBounds:YES];
    [[btnReportUser layer] setCornerRadius:btnReportUser.frame.size.height / 2];
    [[btnReportUser layer] setBorderWidth:1.0];
    [[btnReportUser layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [btnReportUser addTarget:self action:@selector(btnReportImageClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [viewHeader addSubview:btnReportUser];
    [btnReportUser setHidden:YES];
    
    [imgProfilePicView setHidden:YES];
    
    btnUserLikes = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - ((IS_IPAD)? 90 : 70), (IS_IPAD) ? 32.5f: 25, (IS_IPAD)? 40 : 30, (IS_IPAD)? 40 : 30)];
    [btnUserLikes setImage:[UIImage imageNamed:@"UserLikes.png"] forState:UIControlStateNormal];
    btnUserLikes.backgroundColor = [UIColor clearColor];
    [btnUserLikes setClipsToBounds:YES];
    [[btnUserLikes layer] setCornerRadius:btnUserLikes.frame.size.height / 2];
    [[btnUserLikes layer] setBorderWidth:1.0];
    [[btnUserLikes layer] setBorderColor:[[UIColor colorWithRed:140.0/255.0 green:79.0/255.0 blue:140.0/255.0 alpha:1.0] CGColor]];
    [btnUserLikes addTarget:self action:@selector(btnUserLikesClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnUserLikes setHidden:YES];
    
    btnEditingDone = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 65, (IS_IPAD) ? 55.0f: 30, 50, 20)];
    
    if (IS_IPAD)
    {
        btnEditingDone.frame = CGRectMake(self.view.frame.size.width -90, 40,80,30);
    }
    
    [btnEditingDone setTitle:@"DONE" forState:UIControlStateNormal];
    btnEditingDone.backgroundColor = [UIColor clearColor];
    [btnEditingDone addTarget:self action:@selector(btnDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[btnEditingDone titleLabel] setFont:[UIFont fontWithName:[[[btnEditingDone titleLabel] font] fontName] size:(IS_IPAD)?19:15]];
    [btnEditingDone setClipsToBounds:YES];
    [[btnEditingDone layer] setCornerRadius:btnEditingDone.frame.size.height / 2];
    [[btnEditingDone layer] setBorderWidth:1.0];
    [[btnEditingDone layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [btnEditingDone setHidden:YES];
    
    [viewHeader addSubview:btnUploadLook];
    [viewHeader addSubview:btnLeft];
    [viewHeader addSubview:btnAddPost];
    [viewHeader addSubview:imgProfilePicView];
    [viewHeader addSubview:btnNotification];
    [viewHeader addSubview:btnBack];
    [viewHeader addSubview:btnUserLikes];
    [viewHeader addSubview:btnEditingDone];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushnotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushReceived:) name:@"pushnotification" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if(isPushNotification)// && [[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"Report"])
//    {
//        NSString *strScreenName;
//        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"Like"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"Comment"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"Ratings"])
//        {
//            strScreenName = @"Comment";
//        }
//        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"Follow"])
//        {
//            strScreenName = @"FollowView";            
//        }
//        else
//        {
//            strScreenName = @"HomeViewController";
//        }
//        
//        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:strScreenName];
//        
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"notification"];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//        isPushNotification = NO;
//        isCommentScreen = YES;
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushnotification" object:nil];
}

-(void)btnAddPostClicked
{
    LGPostLookViewController *look = (LGPostLookViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"addpost"];
    [self.navigationController pushViewController:look animated:YES];
}

- (void)btnNotificationCenterClicked
{
    LGNotificationsCenterViewController *notification = (LGNotificationsCenterViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"NotificationCenter"];
    [self.navigationController pushViewController:notification animated:YES];
}

-(void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushReceived:(NSNotification *)notification
{
    NSDictionary *dict = [[notification userInfo] valueForKey:@"push"];
    NSString *strScreenName;
    if([[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Like"] || [[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Comment"] || [[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Ratings"])
    {
        strScreenName = @"Comment";
    }
    else if ([[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Follow"])
    {
        strScreenName = @"FollowView";
    }
    else
    {
        strScreenName = @"HomeViewController";
    }
    
    isComingFromPush = YES;
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:strScreenName];
    
    if(([[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Request"]) && !isOnHomeScreen)
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (([[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Like"] || [[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Comment"] || [[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Ratings"]) && !isCommentScreen)
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (([[[dict valueForKey:@"aps"] valueForKey:@"key"] isEqualToString:@"Follow"]) && !isUserLooksScreen)
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
