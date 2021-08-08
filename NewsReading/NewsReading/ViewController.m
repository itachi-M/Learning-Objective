//
//  ViewController.m
//  NewsReading
//
//  Created by 刘铸耿 on 2021/3/16.
//

#import "ViewController.h"
#import "ShowAPIRequest.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowAPIRequest *request = [[ShowAPIRequest alloc] initWithAppid:@"566354" andSign:@"75dbf0897821429d8f7c08937b4fb480"];
    [request post:@"http://route.showapi.com/109-35"//注意您需要先订购该接口套餐才能测试
      timeout:20000//超时设置为20秒
      params:[[NSDictionary alloc] initWithObjectsAndKeys:@"",@"channelId",@"",@"channelName",@"足球",@"title",@"1",@"page",@"0",@"needContent",@"0",@"needHtml",@"0",@"needAllList",@"20",@"maxResult",@"",@"id", nil]//传入参数
      withCompletion:^(NSDictionary *result) {
        //打印返回结果
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
        // NSData转为NSString
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"返回结果为：%@",jsonStr);
    }];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
