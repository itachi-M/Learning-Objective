//
//  ViewController.m
//  ZGRunLoop
//
//  Created by 刘铸耿 on 2021/3/2.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak) IBOutlet NSButton *buttonFst;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
   
}

- (void)test {
    NSLog(@"来了");
    
}

- (IBAction)buttonFirstAction:(id)sender {
    NSLog(@"test");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            NSLog(@"1");
        }
    });
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
