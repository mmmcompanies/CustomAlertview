//
//  LGCreateProfileViewController.m
//  Looks Guru
//
//  Created by Apple Mac Mini on 08/01/15.
//  Copyright (c) 2015 Technosoftwares. All rights reserved.
//

#import "LGCreateProfileViewController.h"

@interface LGCreateProfileViewController ()

@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation LGCreateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [btnNotification setHidden:YES];
    [btnAddPost setHidden:YES];
    [btnLeft setHidden:YES];
    intValue = 0;
//  arrGender = [[NSMutableArray alloc] initWithObjects:@"Male", @"Female", nil];
    
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
    
    datePicker.maximumDate = [NSDate date];
    
    NSString *strCreateProfile = URL_CREATE_PROFILE;
    
    urlCreateProfile = [[NSURL alloc] initWithString:strCreateProfile];
    
    if ([txtFirstName respondsToSelector:@selector(setAttributedPlaceholder:)])
    {
        
        UIColor *color = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0];
        
        txtDisplayName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Display Name" attributes:@{NSForegroundColorAttributeName: color}];
        txtFirstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
        
        txtLastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
     
      
        txtGender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
        txtLocation.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: color}];
        txtBirthdate.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Birthday" attributes:@{NSForegroundColorAttributeName: color}];
        
    }
    else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }

    
    
    btnNext.layer.borderColor = [UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0].CGColor;
    btnNext.layer.borderWidth = 1.0f;
    btnNext.layer.cornerRadius = 8.0;
    
    btnNext.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?40: 20);
    //[btnSelect setTitle:@"Gender" forState:UIControlStateNormal];
   // [btnSelect setTitleColor:[UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    
    lblTitle.text = @"CREATE PROFILE";
    
    lblDisplayErrorMessages.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 15);
    lblFirstNameErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 15);
    lblLastNameErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 15);
    lblGenderErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?22: 15);
    lblLocationErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 15);
    lblBirthdateErrorMessage.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 15);
    
    lblUploadYourPhoto.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 13);
    
    txtDisplayName.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 20);
    txtFirstName.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 20);
    txtLastName.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 20);
    txtGender.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 20);
    txtLocation.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 20);
    txtBirthdate.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 20);
    
    txtDisplayName.tintColor = [UIColor whiteColor];
    txtFirstName.tintColor = [UIColor whiteColor];
    txtLastName.tintColor = [UIColor whiteColor];
    txtGender.tintColor = [UIColor whiteColor];
    txtLocation.tintColor = [UIColor whiteColor];
    txtBirthdate.tintColor = [UIColor whiteColor];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    tblGender.frame = CGRectMake(tblGender.frame.origin.x, tblGender.frame.origin.y, 108, 0);
    tblGender.layer.cornerRadius = 6;
    tblGender.layer.borderWidth = 2;
    tblGender.layer.borderColor = [UIColor whiteColor].CGColor;
    
    tblGender.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:17.0/255.0 blue:33.0/255.0 alpha:1.0];
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 600);
    
    btnCamera.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 17);
    btnImageGallery.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 17);
    btnFacebook.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 17);
    btnCancel.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?20: 17);
    btnDatePickerCancel.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 17);
    btnDone.titleLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?30: 17);
    
    btnCancel.layer.borderColor = [UIColor colorWithRed:48.0/255.0 green:29.0/255.0 blue:68.0/255.0 alpha:1.0].CGColor;
    btnCancel.layer.borderWidth = 1.0f;
    btnCancel.layer.cornerRadius = 6.0;
    
    viewActionSheet.layer.borderColor = [UIColor colorWithRed:48.0/255.0 green:29.0/255.0 blue:68.0/255.0 alpha:1.0].CGColor;
    viewActionSheet.layer.borderWidth = 1.0f;
    viewActionSheet.layer.cornerRadius = 6.0;
    
    imgProfilePic.layer.cornerRadius = imgProfilePic.frame.size.width/2;
    [imgProfilePic setClipsToBounds:YES];
    
    viewImageFacebook.layer.cornerRadius = viewImageFacebook.frame.size.width/2;
    [viewImageFacebook setClipsToBounds:YES];
    viewImageFacebook.layer.borderWidth = 2.0;
    viewImageFacebook.layer.borderColor = [UIColor whiteColor].CGColor;
    
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDate * currentDate = [NSDate date];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    [comps setYear: -100];
    NSDate * minDate = [gregorian dateByAddingComponents: comps toDate: currentDate options: 0];

    imgProfilePic.layer.borderWidth = 2.0;
    imgProfilePic.layer.borderColor = [UIColor whiteColor].CGColor;
    
    viewProgress.hidden = YES;
    
    
   // datePicker.delegate = self;
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(datePicker.frame), self.view.frame.size.width, 40)];
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.dateLabel];
    
    viewProgress.layer.cornerRadius = 75;
    
    if(loginData.strUserId)
    {
        if(![loginData.strGender length] == 0)
        {
            txtGender.text = loginData.strGender;
        }
        if(![loginData.strBirthday length] == 0)
        {
            txtBirthdate.text = loginData.strBirthday;
            [btnDOB setUserInteractionEnabled:NO];
        }
        if(![loginData.strLocation length] == 0)
        {
            txtLocation.text = loginData.strLocation;
        }
        if(loginData.imgProfile)
        {
            imgProfilePic.image = loginData.imgProfile;
        }
        
        if(![loginData.strFirstName length] == 0)
        {
            txtFirstName.text = loginData.strFirstName;
        }
        if(![loginData.strLastName length] == 0)
        {
            txtLastName.text = loginData.strLastName;
        }
    }
    
    
    if([strLoginWith isEqualToString:@"facebook"])
    {
        [viewImageFacebook setHidden:NO];
        [imgProfilePic setHidden:YES];
    }
    else
    {
        [viewImageFacebook setHidden:YES];
        [imgProfilePic setHidden:NO];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    viewCover.hidden = YES;
    viewCover.alpha = 0.0;
    viewActionSheet.frame = CGRectMake(viewActionSheet.frame.origin.x, self.view.frame.size.height + 76, viewActionSheet.frame.size.width, viewActionSheet.frame.size.height);
    btnCancel.frame = CGRectMake(btnCancel.frame.origin.x, self.view.frame.size.height + 76, btnCancel.frame.size.width, btnCancel.frame.size.height);
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    viewDatePicker.frame = CGRectMake(viewDatePicker.frame.origin.x, self.view.frame.size.height + 208, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height);
}



-(void)viewDidDisappear:(BOOL)animated
{
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
  
}

- (void)getUserImageFromFBView
{
    UIImage *img = nil;
    //1 - Solution to get UIImage obj
    for (NSObject *obj in [viewImageFacebook subviews])
    {
        if ([obj isMemberOfClass:[UIImageView class]])
        {
            UIImageView *objImg = (UIImageView *)obj;
            img = objImg.image;
            break;
        }
    }
    
    loginData.imgProfile = img;
    imgProfilePic.image =img;
    
    imageData = UIImageJPEGRepresentation(imgProfilePic.image, 0.5);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(30.0, 0.0, 50.0, 50.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont boldSystemFontOfSize:40.0]];
    [label setText:[NSString stringWithFormat:@"%d", (int)row]];
    
    return label;
}

-(IBAction)btnSelelctImage:(id)sender
{
    
    UIActionSheet *imageActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallery", nil];
    imageActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    imageActionSheet.alpha=1.0;
    imageActionSheet.tag = 1;
    if(IS_IPAD)
    {
        [imageActionSheet showFromRect:[btnImgPro frame] inView:self.view animated:YES];
    }
    else
    {
        [imageActionSheet showInView:self.view];
    }
    imageActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
//    viewCover.hidden = NO;
//    
//    viewCover.alpha = 0.0;
//    
//    
//    viewActionSheet.frame = CGRectMake(viewActionSheet.frame.origin.x, self.view.frame.size.height + 76, viewActionSheet.frame.size.width, viewActionSheet.frame.size.height);
//    btnCancel.frame = CGRectMake(btnCancel.frame.origin.x, self.view.frame.size.height + 76, btnCancel.frame.size.width, btnCancel.frame.size.height);
//    
//    [UIView animateWithDuration:0.3 animations:^
//     {
//         viewCover.alpha = 0.6;
//         viewActionSheet.frame = CGRectMake(viewActionSheet.frame.origin.x, self.view.frame.size.height - btnCancel.frame.size.height - 160, viewActionSheet.frame.size.width, viewActionSheet.frame.size.height);
//     }
//                     completion:^(BOOL finished)
//     {
//         [UIView animateWithDuration:0.15 animations:^
//          {
//              btnCancel.frame = CGRectMake(btnCancel.frame.origin.x, self.view.frame.size.height - 60, btnCancel.frame.size.width, btnCancel.frame.size.height);
//          }
//                          completion:^(BOOL finished)
//          {
//              [UIView animateWithDuration:0.15 animations:^
//               {
//                   btnCancel.frame = CGRectMake(btnCancel.frame.origin.x, self.view.frame.size.height - 48, btnCancel.frame.size.width, btnCancel.frame.size.height);
//               }
//                               completion:^(BOOL finished)
//               {
//                   
//               }];
//          }];
//     }];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#ifdef MYCHANGES
- (IBAction)selectClicked:(id)sender
{
    btnSelect = sender;
    NSArray * arr = [[NSArray alloc] init];
      //  arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    arr = [NSArray arrayWithObjects:@"Male", @"Female",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"],nil];// [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f =  (IS_IPAD)?120: 80;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    txtGender.text = strSelectedGender;
    [btnSelect setTitle:@"" forState:UIControlStateNormal];
    
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
#endif
-(IBAction)btnCancelClicked:(id)sender
{
    viewCover.alpha = 0.6;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //don't forget to add delegate.....
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:0.4];
    viewCover.hidden = YES;
    viewCover.alpha = 0.0;
    viewActionSheet.frame = CGRectMake(viewActionSheet.frame.origin.x, self.view.frame.size.height + 76, viewActionSheet.frame.size.width, viewActionSheet.frame.size.height);
    btnCancel.frame = CGRectMake(btnCancel.frame.origin.x, self.view.frame.size.height + 76, btnCancel.frame.size.width, btnCancel.frame.size.height);
    
    //also call this before commit animations......
   // [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}

-(IBAction)btnCameraClicked:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;

    if (IS_IPAD)
    {
        if ( ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]))
        {
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;                imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
           [popover presentPopoverFromRect:imgProfilePic.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
            popover.delegate = self;
            popOver = popover;
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Message"message:@"No camera detected in your device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }

    }
    else
    {
        if ( ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]))
        {
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Message"message:@"No camera detected in your device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }

    }
    
}

-(IBAction)btnImageGalleryClicked:(id)sender
{
    [self performSegueWithIdentifier:@"gallery" sender:self];
}

-(IBAction)btnFacebookClicked:(id)sender
{
    
    
    
}

-(IBAction)btnDatePickerCancelClicked:(id)sender
{
    viewCover.alpha = 0.6;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.37];
    
    viewCover.hidden = NO;
    viewCover.alpha = 0.0;
    
    viewDatePicker.frame = CGRectMake(viewDatePicker.frame.origin.x, self.view.frame.size.height + 208, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height);
    
    [UIView commitAnimations];
}


-(IBAction)btnDoneClicked:(id)sender
{
    viewCover.alpha = 0.6;
    NSLog(@"%@", [datePicker date]);
    scrollView.contentOffset = CGPointMake(0, 0);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.37];
    
    viewCover.hidden = NO;
    viewCover.alpha = 0.0;
    
    viewDatePicker.frame = CGRectMake(viewDatePicker.frame.origin.x, self.view.frame.size.height + 208, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    txtBirthdate.text = [dateFormatter stringFromDate:[datePicker date]];
    
    [UIView commitAnimations];
}

-(void)setSelectedImage:(UIImage *)imgSelected
{
    imgProfilePic.image = imgSelected;
    [imgProfilePic setContentMode:UIViewContentModeScaleAspectFill];
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    [[actionSheet layer] setBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:17.0/255.0 blue:33.0/255.0 alpha:1.0].CGColor];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
        
        {
            if (IS_IPAD)
            {
                if (buttonIndex == 0)
                {
                    if ( ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]))
                    {
                        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                        //imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
                        imagePicker.allowsEditing = NO;
                        
                        
                        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                        //[popover presentPopoverFromRect:btnAddPicture.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
                        {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                
                                [popover presentPopoverFromRect:btnImgPro.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                            }];
                        }
                        else
                        {
                            [popover presentPopoverFromRect:btnImgPro.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                        }
                        
                        popover.delegate = self;
                        popOver = popover;
                    }
                    else
                    {
                        [[[UIAlertView alloc] initWithTitle:@"Message"message:@"No camera detected in your device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                    }
                    
                }
                if (buttonIndex == 1)
                {
                    imagePicker.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
                    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
                    //[self presentViewController:imagePicker animated:YES completion:NULL];
                    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            [popover presentPopoverFromRect:btnImgPro.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                        }];
                        
                    }
                    else
                    {
                        [popover presentPopoverFromRect:btnImgPro.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    }
                    popover.delegate = self;
                    popOver = popover;
                }
                //[[UIApplication sharedApplication] setStatusBarHidden:YES];
            }
            else
            {
                if (buttonIndex == 0)
                {
                    if ( ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]))
                    {
                        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:imagePicker animated:YES completion:NULL];
                    }
                    else
                    {
                        [[[UIAlertView alloc] initWithTitle:@"Message"message:@"No camera detected in your device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                    }
                }
                if (buttonIndex == 1)
                {
                    imagePicker.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
                    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
                    [self presentViewController:imagePicker animated:YES completion:NULL];
                }
            }

//            if (buttonIndex == 0)
//            {
//                
//                if ( ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]))
//                {
//                    isImageCapturedFromCamera = YES;
//                    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
//                    [self presentViewController:imagePicker animated:YES completion:NULL];
//                }
//                else
//                {
//                    [[[UIAlertView alloc] initWithTitle:@"Message"message:@"No camera detected in your device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                }
//                
//            }
//            if (buttonIndex == 1)
//            {
//                isImageCapturedFromCamera = NO;
//                imagePicker.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
//                imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
//                [self presentViewController:imagePicker animated:YES completion:NULL];
//            }
            
        }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrGender count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"genderCell";
    NSString *version = [[UIDevice currentDevice] systemVersion];
    BOOL isAtLeast6 = [version floatValue] >= 6.0;
    UITableViewCell *cell;
    
    if(isAtLeast6)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    }
    
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"genderCell" ];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = BRANDON_REGULAR_FONT((IS_IPAD)?40: 20);
    cell.textLabel.text = [arrGender objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    txtGender.text = [arrGender objectAtIndex:indexPath.row];
    [UIView setAnimationDuration:0.37];
    
    tblGender.frame = CGRectMake(tblGender.frame.origin.x, tblGender.frame.origin.y, 108, 0);
    
    [UIView commitAnimations];
}

-(void)scrollViewDidScroll:(UIScrollView *)scroll
{
    if (scroll ==scrollView)
    {
        [dropDown hideDropDown:btnSelect];
        [self rel];
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //if([textField isEqual:txtUsername])
    {
        NSLog(@"%@", textField.text);
        
        [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];
        //[self performSelector:@selector(callMeAfterTwoSeconds) withObject:nil afterDelay:2.0];
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    return YES;
//    if (textField == prvsTextField)
//    {
//        intValue = 0;
//        
//        return  YES;
//
//    }
//    else
//    {
//        if([string isEqualToString:@" "] && intValue== 0)
//        {
//            return NO;
//        }
//        else if (![string isEqualToString:@" "])
//            
//        {
//            prvsTextField = textField;
//            intValue++;
//            return YES;
//        }
//
//    }
    
    
    
    
   
}
  

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (txtDisplayName == textField)
    {
        [txtDisplayName resignFirstResponder];
        [txtFirstName becomeFirstResponder];
        //[textField becomeFirstResponder];
        
    }
    
    if (txtFirstName == textField)
    {
        [txtFirstName resignFirstResponder];
        [txtLastName becomeFirstResponder];
    }
    
//    if (txtLastName == textField)
//    {
//        [txtLastName resignFirstResponder];
//        [txtGender becomeFirstResponder];
//        
//    }
//    
//    if (txtGender == textField)
//    {
//        [txtGender resignFirstResponder];
//        [txtBirthdate becomeFirstResponder];
//        
//    }
    else
    {
        
        [textField resignFirstResponder];
    }
    
    
    
    return NO;

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [dropDown hideDropDown:btnSelect];
                       [txtBirthdate resignFirstResponder];
                   });
    if(textField == txtBirthdate)
    {
        viewCover.hidden = NO;
        viewCover.alpha = 0.0;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.37];
        
        viewCover.alpha = 0.6;
        viewDatePicker.frame = CGRectMake(viewDatePicker.frame.origin.x, self.view.frame.size.height - 208, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height);
        
        [UIView commitAnimations];
    }
    
}
//if(textField == txtGender)
//{
//    //        [UIView beginAnimations:nil context:NULL];
//    //        [UIView setAnimationDuration:0.37];
//    //
//    //        tblGender.frame = CGRectMake(tblGender.frame.origin.x, tblGender.frame.origin.y, 108, 100);
//    //
//    //        [UIView commitAnimations];
//}


-(IBAction)btnDobClicked:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [dropDown hideDropDown:btnSelect];
                       [txtBirthdate resignFirstResponder];
                       [txtFirstName resignFirstResponder];
                       [txtLastName resignFirstResponder];
                       [txtDisplayName resignFirstResponder];
                   });
       {
        viewCover.hidden = NO;
        viewCover.alpha = 0.0;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.37];
        
        viewCover.alpha = 0.6;
        viewDatePicker.frame = CGRectMake(viewDatePicker.frame.origin.x, self.view.frame.size.height - 208, viewDatePicker.frame.size.width, viewDatePicker.frame.size.height);
        
        [UIView commitAnimations];
    }

}

-(IBAction)btnNextClicked:(id)sender
{
    BOOL isValid = YES;
    
    if(txtDisplayName.text.length == 0 || [self checkForSpace:[txtDisplayName text]])
    {
         isValid = NO;
        [txtDisplayName becomeFirstResponder];
        lblDisplayErrorMessages.text = @"Please enter your display name";
        [self fadein:lblDisplayErrorMessages];
        return;
    }

    else if (txtFirstName.text.length<=0 || [self checkForSpace:[txtFirstName text]])
    {
        isValid = NO;
        [txtFirstName becomeFirstResponder];
        lblFirstNameErrorMessage.text = @"Please enter your first name";
        [self fadein:lblFirstNameErrorMessage];
        return;
    }

    
    else if (txtLastName.text.length == 0 || [self checkForSpace:[txtLastName text]])
    {
        isValid = NO;
        [txtLastName becomeFirstResponder];

        lblLastNameErrorMessage.text = @"Please enter your last name.";
        [self fadein:lblLastNameErrorMessage];
        return;
    }
//    else if (txtDisplayName.text.length == 0)
//    {
//        isValid = NO;
//       
//
//        lblLastNameErrorMessage.text = @"Please enter your display name.";
//        [self fadein:lblLastNameErrorMessage];
//        return;
//    }
    else if (txtGender.text.length == 0)
    {
        isValid = NO;
        lblGenderErrorMessage.text = @"Please select your gender.";
        [self fadein:lblGenderErrorMessage];
        return;
    }
       else if (txtBirthdate.text.length == 0)
    {
        isValid = NO;
        lblBirthdateErrorMessage.text = @"Please enter your birthday.";
        [self fadein:lblBirthdateErrorMessage];
        return;
    }
    else
    {
        [GMDCircleLoader setOnView:self.view withTitle:@"" animated:YES];
        
        viewProgress.hidden = NO;
        
        [self performSelectorInBackground:@selector(createProfile) withObject:nil];
    }
}

-(BOOL)checkForSpace:(NSString *)strTxtfieldString
{
    NSString *rawString = strTxtfieldString;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0)
    {
        return YES;
        
    }
    return NO;
}

-(void)createProfile
{
    if([strLoginWith isEqualToString:@"facebook"] && ![viewImageFacebook isHidden])
    {
        [self getUserImageFromFBView];
    }
    
    if(imageData == 0)
    {
        imageData = UIImageJPEGRepresentation(imgProfilePic.image, 1.0);
    }
    
    NSString *strBaseEncode = [Base64 encode:imageData];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:urlCreateProfile];
    
    [request setPostValue:loginData.strUserId forKey:@"id"];
    [request setPostValue:txtDisplayName.text forKey:@"display_name"];
    [request setPostValue:txtFirstName.text forKey:@"first_name"];
    [request setPostValue:txtLastName.text forKey:@"last_name"];
    [request setPostValue:txtGender.text forKey:@"gender"];
    [request setPostValue:@"" forKey:@"location"];
    [request setPostValue:txtBirthdate.text forKey:@"dob"];
    [request setPostValue:strBaseEncode forKey:@"avatar"];
    [request setUploadProgressDelegate:viewProgress];
    
    
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestForcreateProfileFail:)];
    [request setDidFinishSelector:@selector(requestForcreateProfileSuccess:)];
    
    [request setTimeOutSeconds:99999999999];
    [request startSynchronous];
}

-(void)requestForcreateProfileFail:(ASIFormDataRequest *)request
{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSLog(@"%@", request.responseString);
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [CommonFunctions alertForNoInternetConnection];
                   });
}


-(void)requestForcreateProfileSuccess:(ASIFormDataRequest *)request
{
    NSString *responseString = [request responseString];
    responseString = [[responseString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    
    NSMutableDictionary *results = [parser objectWithString:responseString error:nil];
    
    NSString *strResult = [results objectForKey:@"result"];
    NSString *strMessage = [results objectForKey:@"message"];
    
    dictUserData = [[NSMutableDictionary alloc] init];
    
    
    if([strResult isEqualToString:@"success"])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           loginData.strFirstName = txtFirstName.text;
                           loginData.strDisplayName = txtDisplayName.text;
                           loginData.strLastName = txtLastName.text;
                           loginData.strGender = txtGender.text;
                           loginData.strLocation = txtLocation.text;
                           loginData.strBirthday = txtBirthdate.text;
                           loginData.imgProfile = imgProfilePic.image;
                                                      
                           [self performSegueWithIdentifier:@"firstlook" sender:self];
                           [GMDCircleLoader hideFromView:self.view animated:YES];
                       });
        
    }
    
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [[[UIAlertView alloc] initWithTitle:@"" message:strMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                           
                          [GMDCircleLoader hideFromView:self.view animated:YES];
                       });
    }
}


-(void)fadein:(UILabel *)lblMessage;
{
    lblShowMessage = lblMessage;
    lblShowMessage.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //don't forget to add delegate.....
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:1.6];
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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gallery"])
    {
        LGImageGalleryViewController *vc = (LGImageGalleryViewController *)[segue destinationViewController];
        vc.delegate = self;
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    if(IS_IPAD)
    {
        [popOver dismissPopoverAnimated:YES];
    }
    
    NSData *data = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 1.0);
    
    UIImage *imagePro = [UIImage imageWithData:data];
    
    imageData = UIImageJPEGRepresentation(imagePro, 1.0);
    
    float  newHeights = [self getCustomHeightForEachElement:imagePro];
    NSLog(@"New Height: %f", newHeights);
    
    UIImage* myImage = [self imageWithImage:imagePro scaledToSize:CGSizeMake(100, 100)];
    
    [viewImageFacebook setHidden:YES];
    [imgProfilePic setHidden:NO];
    
    if (IS_IPAD)
    {
        [imgProfilePic setImage:myImage];
    }
    else
    {
        [imgProfilePic setImage:myImage];
    }
    
    imageData = UIImageJPEGRepresentation(myImage, 1.0);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGFloat)getCustomHeightForEachElement:(UIImage *)deal
{
    // Image Height Auto Adjustment
    int maxImgWidth = (IS_IPAD)? 250 : (IS_IPHONE_6_PLUS) ? 150 : (IS_IPHONE_6) ? 120 : 100;
    int maxImgHeight = (IS_IPAD)? 250 : (IS_IPHONE_6_PLUS) ? 150 : (IS_IPHONE_6) ? 120 : 100;
    
    float oldWidth = maxImgWidth, oldHeight = maxImgHeight;
    if(deal)
    {
        oldWidth = deal.size.width;
        oldHeight = deal.size.height;
    }
    
    float scaleFactor;
    if(oldHeight > oldWidth)
    {
        scaleFactor = maxImgWidth / oldWidth;
    }
    else
    {
        scaleFactor = maxImgHeight / oldHeight;
    }
    
    newHeight = oldHeight * scaleFactor;
    newWidth = oldWidth * scaleFactor;
    
    int finalHeight =  newHeight;
    
    return finalHeight;
}

- (void)didReceiveMemoryWarning
{
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
