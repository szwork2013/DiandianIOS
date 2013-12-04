//
//  DABillViewController.m
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DABillViewController.h"
#import "DABillDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAPreferentialViewController.h"

#define kMaxNumber                       100000

@interface DABillViewController ()
{
    NSMutableArray *btnList;
    DABill *billData;
    NSInteger *payType;
}
@end

@implementation DABillViewController
{
    NSMutableArray *finishList;
    NSMutableArray *cancelList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    finishList = [[NSMutableArray alloc] init];
    cancelList = [[NSMutableArray alloc] init];
    payType = 0;
    self.textOff.text = @"1";
    self.textReduce.text = @"0";
    
    

    [self initTopmenu];
    self.keyboardView = [[ZenKeyboard alloc] initWithFrame:self.viewKeyboard.frame];
    [self.view addSubview:self.keyboardView];
    self.keyboardView.textField = self.textPay;
    
    self.textPay.inputView=[[UIView alloc]initWithFrame:CGRectZero];
    self.textOff.inputView=[[UIView alloc]initWithFrame:CGRectZero];
    self.textReduce.inputView=[[UIView alloc]initWithFrame:CGRectZero];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reload];
    NSLog(@" sever : %@  deskId : %@ 结账",self.curService._id ,@"");
//    [self.textPay becomeFirstResponder];
}


- (void) initTopmenu
{
    self.viewTopmenuLabel.layer.cornerRadius = 15.0;
    self.viewTopmenuLabel.layer.masksToBounds = YES;
    
    
    self.viewTopmenu.layer.shadowColor = UIColor.blackColor.CGColor;
    self.viewTopmenu.layer.shadowRadius = 2;
    self.viewTopmenu.layer.shadowOpacity = 0.6;
    self.viewTopmenu.layer.shadowOffset = CGSizeMake(0, 1);
    
    btnList =  [[NSMutableArray alloc] init];
    [btnList addObject:[self.view viewWithTag:100]];
    
    [btnList addObject:[self.view viewWithTag:203]];
    
    for (UIButton *btn in btnList) {
        btn.layer.shadowColor = UIColor.blackColor.CGColor;
        btn.layer.shadowRadius = 2;
        btn.layer.shadowOpacity = 0.6;
        btn.layer.shadowOffset = CGSizeMake(0, 1);
    }
    
}

-(void)reload
{
    [[DAServiceModule alloc]getBillByServiceId:self.curService._id callback:^(NSError *err, DABill *bill) {
        billData = bill;
        self.lblTotal.text = [NSString stringWithFormat:@"%.02f元",[bill.amount floatValue]];
        //判断是否是  外卖
        if ([self.curService.type integerValue] == 3) {
            self.lblDeskName.text = [NSString stringWithFormat:@"外卖"];
        } else {
            self.lblDeskName.text = [NSString stringWithFormat:@"桌号：%@",bill.desk.name];
        }

        float off = [billData.amount floatValue] * [self.textOff.text floatValue] - [self.textReduce.text floatValue];
        self.lblPay.text = [NSString stringWithFormat:@"%.02f元 ",off];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDetailTaped:(id)sender {
    DABillDetailViewController *c = [[DABillDetailViewController alloc] initWithNibName:nil bundle:nil];
    c.curService = self.curService;
    
    c.chanelBlock = ^() {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };

    [self presentPopupViewController:c animationType:MJPopupViewAnimationFade dismissed:^{
        [self reload];
    }];
}
- (IBAction)onPreferentialTouched:(id)sender {

    DAPreferentialViewController *c = [[DAPreferentialViewController alloc] initWithNibName:@"DAPreferentialViewController" bundle:nil];
    c.chanelBlock = ^() {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    
    [self presentPopupViewController:c animationType:MJPopupViewAnimationFade dismissed:^{
        [self reload];
    }];
}

- (IBAction)onBeginEditing:(id)sender {
    UITextField *text = (UITextField *)sender;
    self.keyboardView.num = [[NSMutableString alloc] init];
    self.keyboardView.textField  = text;
}
- (IBAction)onStopBillTouched:(id)sender {
    [[DAServiceModule alloc]stopService:self.curService._id amount:[billData.amount stringValue] profit:self.textPay.text agio:self.textOff.text  preferential:self.textReduce.text payType:[NSString stringWithFormat:@"%d" ,(int)payType] callback:^(NSError *err, DAService *service)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)onChangeOff:(id)sender {

    float off = [billData.amount floatValue] * [self.textOff.text floatValue] - [self.textReduce.text floatValue];    
    self.lblPay.text = [NSString stringWithFormat:@"%.02f元 ",off];
    
}

- (IBAction)onPayTypeTouched:(UISegmentedControl *)sender {
    NSInteger *Index = (NSInteger *)sender.selectedSegmentIndex;
    payType = Index;
    
}

- (IBAction)onBackTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
