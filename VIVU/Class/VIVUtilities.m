//
//  VIVUtilities.m
//  VIVU
//
//  Created by MacPro on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIVUtilities.h"
#import "ImagesProfileProvider.h"
#import "ViewController.h"
#import "AppDelegate.h"



@implementation VIVUtilities
@synthesize arrayImages;
@synthesize arrayProvider;
@synthesize counter;

-(void)dealloc
{
    [arrayProvider release];
    [arrayImages release];
    [super dealloc];

}

+(UIViewController *)getRootViewController
{
    return  ((AppDelegate*)[UIApplication sharedApplication].delegate).viewController;
}
+(void)stopArrayProvider:(NSMutableArray*)arrProvider
{
//    for(ImagesProfileProvider *imageProvider in arrProvider)
//    {
//        if (imageProvider.loadingData==YES) {
//            imageProvider.delegate = nil;
//            [imageProvider cancelDownload];
//        }
//    }
    [arrProvider removeAllObjects];
}
+ (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
+ (NSDate *)dateFrom:(NSTimeZone *)fTimeZone to:(NSTimeZone *)timeZone forDate:(NSDate *)date
{
	NSInteger currentGMT = [fTimeZone secondsFromGMT];
	NSInteger changedGMT = [timeZone secondsFromGMT];
	NSInteger timeInterval = currentGMT + changedGMT;
	date = [date dateByAddingTimeInterval:-timeInterval];
	return date;
}

+(CGSize) getSizeIpad{
    UIInterfaceOrientation orien = [UIApplication sharedApplication].statusBarOrientation;
    CGSize size = CGSizeZero;
    if (UIInterfaceOrientationIsLandscape(orien)) {
        size = CGSizeMake(1024, 748);
    }else {
        size = CGSizeMake(768, 1004);
    }
    return size;
}
+(CGSize) getSizeIphone
{
    UIInterfaceOrientation orien = [UIApplication sharedApplication].statusBarOrientation;
    CGSize size = CGSizeZero;
    if (UIInterfaceOrientationIsLandscape(orien)) {
        size = CGSizeMake(480, 300);
    }else {
        size = CGSizeMake(320, 460);
    }
    return size;
}
+(CGSize)getSizeDevice
{
    if ([self isIpadDevice]) {
        return [self getSizeIpad];
    }else {
        return [self getSizeIphone];
    }
}
+(BOOL)isIpadDevice
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    }else {
        return YES;
    }
}
+(void) closeRequestImageProviderWithArrayProvider:(NSMutableArray *)arrayProvider
{
    {
        for (ImagesProfileProvider *provider in arrayProvider) {
            if (provider.loadingData ==YES) {
                [provider cancelDownloadProvider];
            }
        }
    }
}
+(UIImage *)scaleImage:(UIImage *)image withSize:(CGSize)size
{
	//UIGraphicsBeginImageContext(size);
	UIGraphicsBeginImageContextWithOptions(size, NO, 2.0); //only apply for iOS 4 or upper
    [image drawInRect:CGRectMake(0.0, 0.0, size.width, size.height)];
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	return imageCopy;
}

@end
