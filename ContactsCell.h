//
//  ContactsCell.h
//  Looks Guru
//
//  Created by Techno Softwares on 14/02/17.
//  Copyright © 2017 Techno Softwares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img_contact;
@property (strong, nonatomic) IBOutlet UILabel *lbl_contactName;
@property (strong, nonatomic) IBOutlet UIButton *btn_sendSMS;

@end
