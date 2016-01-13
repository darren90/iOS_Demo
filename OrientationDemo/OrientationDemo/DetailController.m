//
//  DetailController.m
//  OrientationDemo
//
//  Created by Fengtf on 16/1/8.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "DetailController.h"

@interface DetailController ()

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}
//
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    if (self.interfaceOrientation != UIInterfaceOrientationMaskLandscape) {
//        return UIInterfaceOrientationMaskLandscapeLeft;
//    }
    return UIInterfaceOrientationMaskLandscape ;
}

- (BOOL)shouldAutorotate{
    return YES;
}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
//}



#pragma mark - 自动转屏的逻辑
//- (BOOL)shouldAutorotate{
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//            return  UIInterfaceOrientationMaskLandscapeRight;
//        }else if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
//            return UIInterfaceOrientationMaskLandscapeLeft;
//        }
//        return UIInterfaceOrientationMaskLandscapeLeft;
//}




//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait ;
//}
//
//- (BOOL)shouldAutorotate{
//    return YES;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}




@end
