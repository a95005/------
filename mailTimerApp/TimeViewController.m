//
//  TimeViewController.m
//  changeScreenApp
//
//  Created by atp on 2014/04/19.
//  Copyright (c) 2014年 atp. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

@end

@implementation TimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//ボタン押下時、タイマーを起動
-(IBAction)selector:(id)sender{
    //タイマーの作成（動作開始）
    [NSTimer scheduledTimerWithTimeInterval:4.0//時間間隔（秒）
                                     target:self//呼び出すオブジェクト
                                   selector:@selector(isTimerEnd:)//呼び出すメソッド
                                   userInfo:nil//ユーザー利用の情報オブジェクト
                                    repeats:YES];//繰り返し
    
    
    
    //ラベルに日付を表示
    //・self：実行しているオブジェクト自身を指す(javaでいうthisにあたるのかな？)
    //・stringFromDate：NSDateFormatterでキャスト
    //[オブジェクト名 メソッド名]
    
    
   
}

//１０秒ごとに実行される処理
//現在時刻と指定時刻が一致した場合にラベルを変更する
-(void)isTimerEnd :(NSTimer *)timer{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM:DD:HH:mm"];
    
    NSDate *date1 = [NSDate date];
    NSString *nowDate = [NSString alloc];
    nowDate = [df stringFromDate:date1];
    
    NSDate *date2 = self.myDatePicker.date;
    NSString *myDate = [NSString alloc];
    myDate = [df stringFromDate:date2];
    
    BOOL bl = [nowDate isEqualToString:myDate];
    if(bl){
        [timer invalidate];
        Class mail = (NSClassFromString(@"MFMailComposeViewController"));
        if (mail != nil){
            //メールの設定がされているかどうかチェック
            if ([mail canSendMail]){
                [self showComposerSheet];
            } else {
                [self setAlert:@"メールが起動出来ません！":@"メールの設定をしてからこの機能は使用下さい。"];
            }
        }

    }


}


#pragma mark -
#pragma mark メール画面を開く
-(void) showComposerSheet {
    

    //メーラー
    MFMailComposeViewController *objMail = [[MFMailComposeViewController alloc] init];
    
	//メーラー
    objMail.mailComposeDelegate = self;
    
	[objMail setSubject:@"お前足くさくね？"];
	
	//メールの本文を設定
	NSString *emailBody = @"ここはメールの本文";
    [objMail setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:objMail animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	switch (result){
		case MFMailComposeResultCancelled:
			//キャンセルした場合
			break;
		case MFMailComposeResultSaved:
			//保存した場合
			break;
		case MFMailComposeResultSent:
			//送信した場合
			break;
		case MFMailComposeResultFailed:
			[self setAlert:@"メール送信失敗！":@"メールの送信に失敗しました。ネットワークの設定などを確認して下さい"];
			break;
		default:
			break;
	}
}

#pragma mark -
#pragma mark アラート表示
-(void) setAlert:(NSString *) aTitle :(NSString *) aDescription {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:aTitle message:aDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

#pragma mark -
#pragma mark その他
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






- (IBAction)BackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
