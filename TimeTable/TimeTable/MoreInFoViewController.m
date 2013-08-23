//
//  MoreInFoViewController.m
//  TimeTable
//
//  Created by hcui on 13-8-21.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "MoreInFoViewController.h"
#import "MoreCell.h"
#import "DataBaseBean.h"
#import "TimeBean.h"
#import "HelpDataBase.h"

@interface MoreInFoViewController ()

@end

@implementation MoreInFoViewController
@synthesize moreTableView;
@synthesize course,time,classRoom,teacher;
@synthesize tableName;
@synthesize item;

#pragma mark - Managing the detail item

- (void)setCourseDetailItem:(id)newDetailItem
{
    if (_courseDetailItem != newDetailItem) {
        [_courseDetailItem release];
        _courseDetailItem = [newDetailItem retain];
    }
}
- (void)setTimeDetailItem:(id)newDetailItem
{
    if (_timeDetailItem != newDetailItem) {
        [_timeDetailItem release];
        _timeDetailItem = [newDetailItem retain];
    }
}
-(void)dealloc
{
    [super dealloc];
    [item release];
    [moreTableView release];
    [course release];
    [time release];
    [classRoom release];
    [teacher release];
    [tableName release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"MoreInFoViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    buttonStatus=YES;
    [super viewDidLoad];
    [self textFieldAlloc];
    [self textFieldText];
    if (buttonStatus==YES) {
        self.item.rightBarButtonItem=self.editButtonItem;
        editStatus=NO;
        [self textColor];
    }

    self.moreTableView.scrollEnabled=NO;
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    UIBarButtonItem *rightbutton2=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)] autorelease];
    if (editing) {
        self.item.rightBarButtonItem =rightbutton2;
        editStatus=YES;
        [self textColor];
    }
}
-(void)textFieldText
{
    DataBaseBean *databasebean;
    TimeBean *timebean;
    if (self.courseDetailItem) {
        databasebean=self.courseDetailItem;
        self.course.text=databasebean.courseName;
        self.teacher.text=databasebean.teacherName;
        self.classRoom.text=databasebean.className;
    }
    if (self.timeDetailItem) {
        timebean=self.timeDetailItem;
    }
    self.time.text=timebean.time;
}
-(void)textColor
{
    if (!editStatus) {
        self.course.textColor=[UIColor grayColor];
        self.course.enabled=NO;
        self.time.textColor=[UIColor grayColor];
        self.time.enabled=NO;
        self.classRoom.textColor=[UIColor grayColor];
        self.classRoom.enabled=NO;
        self.teacher.textColor=[UIColor grayColor];
        self.teacher.enabled=NO;
    }else
    {
        self.course.textColor=[UIColor blackColor];
        self.course.enabled=YES;
        self.time.textColor=[UIColor blackColor];
        self.time.enabled=YES;
        self.classRoom.textColor=[UIColor blackColor];
        self.classRoom.enabled=YES;
        self.teacher.textColor=[UIColor blackColor];
        self.teacher.enabled=YES;
    }
    
}
-(void)textFieldAlloc
{
    course = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    course.textAlignment=NSTextAlignmentCenter;
    course.delegate=self;
    
    
    time = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    time.textAlignment=NSTextAlignmentCenter;
    time.delegate=self;
    
    classRoom = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    classRoom.textAlignment=NSTextAlignmentCenter;
    classRoom.delegate=self;
    
    teacher = [[UITextField alloc] initWithFrame:CGRectMake(90, 13, 200, 40)];
    teacher.textAlignment=NSTextAlignmentCenter;
    teacher.delegate=self;

}

-(IBAction)saveAction:(id)sender
{
    DataBaseBean *databasebean;
    HelpDataBase *help=[[HelpDataBase alloc]init];
    TimeBean *timebean;
    if (self.courseDetailItem) {
        databasebean=self.courseDetailItem;
        if (self.timeDetailItem) {
            timebean=self.timeDetailItem;
        }
        if ([self.time.text isEqualToString:@""]) {
            [self messageTitle:@"上课时间不能为空！"];
        }else
        {
        timebean.time=self.time.text;
        databasebean.courseName=self.course.text;
        databasebean.teacherName=self.teacher.text;
        databasebean.className=self.classRoom.text;
        [help updateTotable:databasebean TableName:tableName];
        [help updateToTimeTable:timebean];
        [self dismissModalViewControllerAnimated:YES];
        }
    }
    [help release];
}
-(void)messageTitle:(NSString *)message
{
    UIAlertView *alerview=[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alerview show];
    [alerview release];
}
#pragma make - TextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.textAlignment=NSTextAlignmentCenter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    MoreCell *cell=(MoreCell *)[tableView
                                    dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MoreCell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[MoreCell class]])
                cell = (MoreCell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (0 == indexPath.row) {
        [cell addSubview:course];
    }
    if (1 == indexPath.row) {
        [cell addSubview:time];
    }
    if (2 == indexPath.row) {
        [cell addSubview:classRoom];
    }
    if (3 == indexPath.row) {
        [cell addSubview:teacher];
    }

    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"课名:",@"时间:",@"地点:",@"老师:", nil];
    cell.name.text=[array objectAtIndex:indexPath.row];
    [array release];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
} 
@end
