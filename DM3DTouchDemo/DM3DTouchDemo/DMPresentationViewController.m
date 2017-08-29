//
//  DMPresentationViewController.m
//  DM3DTouchDemo
//
//  Created by Damon on 2017/8/29.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "DMPresentationViewController.h"

@interface DMPresentationViewController ()

@property (nonatomic, strong)UILabel *labInformation;

@end

@implementation DMPresentationViewController

- (UILabel *)labInformation {

    if (!_labInformation) {
        
        _labInformation = [[UILabel alloc] init];
    }
    
    return _labInformation;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configLabel];
}

- (void)configLabel {

    self.labInformation.text = [NSString stringWithFormat:@"通过点击下标为[%@]进来的", self.strInfo];
    self.labInformation.textColor = [UIColor blackColor];
    self.labInformation.textAlignment = NSTextAlignmentCenter;
    self.labInformation.frame = CGRectMake(0, 0, 200, 30);
    [self.labInformation sizeToFit];
    CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    self.labInformation.center = center;
    
    [self.view addSubview:self.labInformation];
}

#pragma mark - 3D Touch 预览Action代理
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    NSMutableArray *arrItem = [NSMutableArray array];
    
    UIPreviewAction *previewAction0 = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"didClickCancel");
    }];
    
    UIPreviewAction *previewAction1 = [UIPreviewAction actionWithTitle:@"替换该元素" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        //把下标为index的元素替换成preview
        [self replaceItem];
        
    }];
    
    [arrItem addObjectsFromArray:@[previewAction0 ,previewAction1]];
    
    return arrItem;
}

- (void)replaceItem {

    if (self.arrData.count<=0) return ;
    [self.arrData replaceObjectAtIndex:self.index withObject:@"replace  item"];
    
    //发送通知更新数据
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_RELOADDATA" object:nil];
}


@end
