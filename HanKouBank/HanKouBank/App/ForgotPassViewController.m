//
//  ForgotPassViewController.m
//  HanKouBank
//
//  Created by David on 13-5-10.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "ForgotPassViewController.h"

@interface ForgotPassViewController ()

@end

@implementation ForgotPassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        self.title = @"注册";
    }
    return self;
}

- (void)viewDidLoad
{
    //Nav Bar bgimage
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner_background"] forBarMetrics:UIBarMetricsDefault];
    //定制 Nav Bar logo for rightBarButtonItem
    UIView *logoview = [[UIView alloc]initWithFrame:CGRectMake(310, 10, 35, 30)];
    [logoview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo.png"]]];
    UIBarButtonItem *rightLogo = [[UIBarButtonItem alloc]initWithCustomView:logoview];
    [self.navigationItem setRightBarButtonItem:rightLogo];
    [self.navigationItem setHidesBackButton:YES];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(15, 3, 20, 20)];
    [backButton addTarget:self action:@selector(BackBarPopToSuper) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backBar];

    [super viewDidLoad];
	
    //user name
    UITextField *forgotUserName = [[UITextField alloc]initWithFrame:CGRectMake(20, 25, 280, 40)];
    [forgotUserName setPlaceholder:@"  用户名"];
    [forgotUserName setBackground:[UIImage imageNamed:@"login_top.png"]];
    [forgotUserName setFont:[UIFont systemFontOfSize:FONT_SYS]];
    [forgotUserName setTextAlignment:NSTextAlignmentLeft];
    //内容文字居中
    [forgotUserName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [forgotUserName setTag:305];
    [self.view addSubview:forgotUserName];
    
    //user pass
    UITextField *forgotUserPass = [[UITextField alloc]initWithFrame:CGRectMake(20, 65, 280, 40)];
    [forgotUserPass setPlaceholder:@"  手机号码"];
    [forgotUserPass setBackground:[UIImage imageNamed:@"login_buttom.png"]];
    [forgotUserPass setFont:[UIFont systemFontOfSize:FONT_SYS]];
    [forgotUserPass setTextAlignment:NSTextAlignmentLeft];
    //内容文字居中
    [forgotUserPass setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [forgotUserPass setTag:306];
    [self.view addSubview:forgotUserPass];
    
    

    //find pass button
    UIButton *findPassButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [findPassButton setFrame:CGRectMake(100, 150, 120, 40)];
    [findPassButton setTitle:@"找回密码 " forState:UIControlStateNormal];
    [findPassButton addTarget:self action:@selector(find:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPassButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)find:(UIButton *)sender
{
    ForgotDB *db = [[ForgotDB alloc]init];
    [db readyDatabse];
    [db openDatabase];
    User *user = [[User alloc]init];
    user.username = ((UITextField *)[self.view viewWithTag:305]).text;
    user.email = ((UITextField *)[self.view viewWithTag:306]).text;
    user.password =[NSString stringWithFormat:@"%@",[db FindPassFromDB:user]];
    DLog(@"user.pass:%@",user.password);
    UIAlertView *backPass = [[UIAlertView alloc]initWithTitle:@"找回密码" message:[NSString stringWithFormat:@"您的密码为:%@ 请牢记",user.password] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [backPass show];
    [db closeDatabase];
}

//backBar popToSuper imple
- (void) BackBarPopToSuper
{
    [self.navigationController popViewControllerAnimated:YES];
}

//关闭键盘方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *username = (UITextField *)[self.view viewWithTag:305];
    UITextField *email = (UITextField *)[self.view viewWithTag:306];
    [username resignFirstResponder];
    [email resignFirstResponder];
}
@end
