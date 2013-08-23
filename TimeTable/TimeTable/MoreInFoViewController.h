//
//  MoreInFoViewController.h
//  TimeTable
//
//  Created by hcui on 13-8-21.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreInFoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationBarDelegate>
{
    UITableView *moreTableView;
    UITextField *course;
    UITextField *time;
    UITextField *classRoom;
    UITextField *teacher;
    UINavigationItem *item;
    BOOL buttonStatus;
    BOOL editStatus;
}
@property (strong,nonatomic) UITextField *course;
@property (strong,nonatomic) UITextField *time;
@property (strong,nonatomic) UITextField *classRoom;
@property (strong,nonatomic) UITextField *teacher;
@property (strong, nonatomic) id courseDetailItem;
@property (strong, nonatomic) id timeDetailItem;
@property (retain,nonatomic) NSString *tableName;
@property (retain,nonatomic) IBOutlet UINavigationItem *item;

@property (retain,nonatomic) IBOutlet UITableView *moreTableView;
-(IBAction)backAction:(id)sender;
-(IBAction)saveAction:(id)sender;
@end
