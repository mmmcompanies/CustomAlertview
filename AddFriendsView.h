//
//  AddFriendsView.h
//  Looks Guru
//
//  Created by Techno Softwares on 14/02/17.
//  Copyright © 2017 Techno Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendsView : UIViewController<UITableViewDelegate,UITableViewDataSource>


{
    NSArray *itemArray;
    NSArray *imgArray;

    
//    {
        UIView *viewHeader;
        
        UILabel *lblTitle;
        
        UIImageView *imgProfilePicView;
        UIButton * btnSearch;
        UIButton *btnLeft;
        UIView * vwMenuBtn;
        UIButton *btnAddPost;
        UIButton * btnBack;
        
        UIButton * btnUploadLook;
        UIButton *btnNotification;
        
        UIButton *btnReportUser;
        UIButton *btnUserLikes;
        
        UIButton *btnEditingDone;
//    }
}
@property (strong, nonatomic) IBOutlet UITableView *tbl_details;

@end
