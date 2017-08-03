//
//  AppDelegate.m
//  高德地理定位
//
//  Created by shiwei on 17/8/3.
//  Copyright © 2017年 ThinkDifferent. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


// 5745e587a5216c41c3173d100cbd8dc4
// 这是我的Key, 你自己去高德平台申请一个 OK?
// 还有, 请用真机测试,

// plist  别忘了添加权限

///  位置
///  NSLocationUsageDescription
///  App需要您的同意,才能访问位置

///  在使用期间访问位置
///  NSLocationWhenInUseUsageDescription
///  App需要您的同意,才能在使用期间访问位置

///  始终访问位置
///  NSLocationAlwaysUsageDescription
///  App需要您的同意,才能始终访问位置

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AMapServices sharedServices].apiKey = @"5745e587a5216c41c3173d100cbd8dc4";
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
