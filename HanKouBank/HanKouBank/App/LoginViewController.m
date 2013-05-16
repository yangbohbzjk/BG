//
//  LoginViewController.m
//  HanKouBank
//
//  Created by David on 13-4-23.
//  Copyright (c) 2013年 David. All rights reserved.
//

#import "LoginViewController.h"
#import "MainPageViewController.h"
#import "RegisterViewController.h"
#import "ForgotPassViewController.h"
#import "LoginDB.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //nav Bar backgroundImage
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner_background.png"] forBarMetrics:UIBarMetricsDefault];
    //nav Bar titleView
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(100, 2,197,30 )];
    [titleview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_banner_text"]]];
    [self.navigationItem setTitleView:titleview];
    //right Bar from logo
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(310, 10, 35, 30)];
    [rightView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"logo"]]];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //view backgroundColor
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
    //user name
    UITextField *UserName_textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 25, 280, 40)];
    [UserName_textField setPlaceholder:@"  用户名"];
    [UserName_textField setBackground:[UIImage imageNamed:@"login_top.png"]];
    [UserName_textField setFont:[UIFont systemFontOfSize:24]];
    [UserName_textField setTextAlignment:NSTextAlignmentLeft];
    //内容文字居中
    [UserName_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [UserName_textField setTag:100];
    [self.view addSubview:UserName_textField];
    
    //user pass
    UITextField *UserPass_textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 65, 280, 40)];
    [UserPass_textField setPlaceholder:@"  密码"];
    [UserPass_textField setBackground:[UIImage imageNamed:@"login_buttom.png"]];
    [UserPass_textField setFont:[UIFont systemFontOfSize:24]];
    [UserPass_textField setTextAlignment:NSTextAlignmentLeft];
    //内容文字居中
    [UserPass_textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [UserPass_textField setTag:101];
    [self.view addSubview:UserPass_textField];
    
    
    //forgot pass button
    UIButton *ForgotPass = [UIButton buttonWithType:UIButtonTypeCustom];
    [ForgotPass setFrame:CGRectMake(25, 140, 90,  30)];
    [ForgotPass setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [ForgotPass setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [ForgotPass setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [ForgotPass addTarget:self action:@selector(Forgot:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ForgotPass];
    
    //resgister button
    UIButton *resgisterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [resgisterButton setFrame:CGRectMake(20, 180, 112, 40)];
    [resgisterButton setBackgroundImage:[UIImage imageNamed:@"subscribe_submit_bg.png"] forState:UIControlStateNormal];
    [resgisterButton setBackgroundImage:[UIImage imageNamed:@"subscribe_submit_bg_press.png"] forState:UIControlStateHighlighted];
    [resgisterButton setTitle:@"注册" forState:UIControlStateNormal];
    [resgisterButton addTarget:self action:@selector(Resgister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resgisterButton];

    //login button
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(180, 180, 112, 40)];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"subscribe_submit_bg.png"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"subscribe_submit_bg_press.png"] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)Forgot:(UIButton *)sender
{
    ForgotPassViewController *forgotPassView = [[ ForgotPassViewController alloc]init];
    [self.navigationController pushViewController:forgotPassView animated:YES];
}

- (void)Resgister:(UIButton *)sender
{
    RegisterViewController *registerView = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerView animated:YES];
}

#pragma mark ------ 登陆事件 ------
- (void)Login:(UIButton *)sender
{
    UITextField *name = (UITextField *)[self.view viewWithTag:100];
    UITextField *pass = (UITextField *)[self.view viewWithTag:101];
    User *user = [[User alloc]init];
    user.username = name.text;
    user.password = pass.text;
    LoginDB *db = [LoginDB sharedDB];
   
        //查询数据库中的账号密码进行匹配
        if ([db selectUserAndPassFromDB:user]) {
            //如果为真，账号密码正确
            DLog(@"登陆成功");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"欢迎回来" message:[NSString stringWithFormat:@"登陆成功!欢迎你%@",user.username] delegate:self cancelButtonTitle:@"进入主页" otherButtonTitles:nil];
            [alert setTag:183];
            [alert show];
        }else{
            DLog(@"登陆失败");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"账号或密码错误，请重新登陆" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
            [alert show];
        }
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *name = (UITextField *)[self.view viewWithTag:100];
    UITextField *pass = (UITextField *)[self.view viewWithTag:101];
    [name resignFirstResponder];
    [pass resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //查询数据库进入
    if (alertView.tag == 182) {
        if (buttonIndex == 0) {
            MainPageViewController *mainPageView = [[MainPageViewController alloc]init];
            [self.navigationController pushViewController:mainPageView animated:YES];
        }
    }else if (alertView.tag == 183){
        //测试账号进入
        if (buttonIndex == 0) {
            MainPageViewController *mainPageView = [[MainPageViewController alloc]init];
            [self.navigationController pushViewController:mainPageView animated:YES];
        }
    }
}


@end
