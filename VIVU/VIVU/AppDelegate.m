//
//  AppDelegate.m
//  VIVU
//
//  Created by MacPro on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FlurryAnalytics.h"
#import "ViewController.h"
#if TARGET_IPHONE_SIMULATOR
@interface CLLocationManager (Simulator)
@end

@implementation CLLocationManager (Simulator)

-(void)startUpdatingLocation {
    CLLocation *powellsTech = [[[CLLocation alloc] initWithLatitude:10.784944 longitude:106.695142] autorelease];
    //10.783757 &&106.696516
    //    CLLocation *powellsTech = [[[CLLocation alloc] initWithLatitude:10.865001 longitude:106.695142
    //                                ] autorelease];
    //10.784944  106.695142
    [self.delegate locationManager:self didUpdateToLocation:powellsTech fromLocation:powellsTech];
    
    
}
@end
#endif
@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize naviController =_naviController;

- (void)dealloc
{
    [_naviController release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FlurryAnalytics startSession:@"M1Z9MSKMCSGNG2NYZRPT"];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
        _naviController =[[UINavigationController alloc]initWithRootViewController:self.viewController];
    } else {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    }
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        locationManager.delegate = self;
        
    }
    
    [locationManager startUpdatingLocation];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         self.window.rootViewController = _naviController;
    }
    else {
        self.window.rootViewController = self.viewController;
    }
    
    [self.window makeKeyAndVisible];

    
    return YES;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    Log(@"Update mylocation with newlocation.latitude: %f && newlocation.longlatitude : %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    self.viewController.coorCurent = newLocation;
    
    [self.viewController setRegion:newLocation];
    float oldRad =  -manager.heading.magneticHeading * M_PI / 180.0f;
    self.viewController.oldRadian = oldRad;

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
