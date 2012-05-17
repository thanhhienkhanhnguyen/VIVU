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
#pragma mark Load Images
-(void) initArrayProvider:(NSMutableArray *)arrayImages12  controller:(id)controller withMode:(ProvierMode)mode
{
    counter = 0;
    
    self.arrayProvider =[NSMutableArray array];
    self.arrayImages = [NSMutableArray arrayWithArray:arrayImages12];
    for (int i=0; i<[arrayImages count]; i++) {
        NSDictionary *dictImage  = [arrayImages objectAtIndex:i];
        if ([dictImage objectForKey:@"url"]) {
            ImagesProfileProvider *provider =[[ImagesProfileProvider alloc]init];
            provider.ImagesProfileDelegate = controller;
            provider.categoryName = [dictImage objectForKey:@"id"];
            provider.mode = ProviderModeImage;
            //            if ([[dictImage objectForKey:@"isUserMostActive"]boolValue] ==YES) {
            //                provider.mode =ProvierModeUserMostActive;
            //                if ([dictImage objectForKey:@"isUserMostActive"]) {
            ////                [detailViewController reloadAvatarMostActive];               
            //                }
            //            }
            NSString *url = [dictImage objectForKey:@"url"];
            //            if ([[dictImage objectForKey:@"isBigImage"]boolValue]==YES) {
            //            
            //            
            //            }
            [provider configURLByURL:url];
            
            [arrayProvider addObject:provider];
            [provider release];
            
        }
        
    }
    [self loadOneByOneImage];
    
}
-(void) loadImageFromArrayProviderWithCounter:(NSInteger)index 
{
    if (index >=0&&index< [arrayProvider count]) {
        ImagesProfileProvider *provider = [arrayProvider objectAtIndex:index];
        BOOL needDownload = YES;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                                           [VIVUtilities applicationDocumentsDirectory],
                                           provider.categoryName]]) {
            needDownload = NO;
        }
        if (needDownload) {
            if (index>=1) {
                ImagesProfileProvider *preProvider = [arrayProvider objectAtIndex:(index-1)];
                if (preProvider.finishLoad ==YES) {
                    [provider requestData];
                }else {
                    //                        NSLog(@"%@",[preProvider getCurrentURL]);
                }
            }else {
                [provider requestData];
            }
        }else {
            // file exist -finishload = YES
            provider.finishLoad = YES;
            //            counter++;
            //            [self loadOneByOneImage];
        }
    }
    
    
}
-(void) loadOneByOneImage
{
    if (arrayProvider) {
        [self loadImageFromArrayProviderWithCounter:counter];
    }
}
-(void)ImagesProfileProviderDidFinishParsing:(ImagesProfileProvider *)provider
{
    UIImage *image = [UIImage imageWithData:provider.returnData];
    if (!image) {
        //load icon defaul
    }else {
        
        NSString *filePath =[NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                             [VIVUtilities applicationDocumentsDirectory],
                             provider.categoryName];
        NSString *dirPath = [VIVUtilities applicationDocumentsDirectory];
        dirPath = [dirPath stringByAppendingString:@"/favicon/image"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDirectory;
        if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDirectory])
        {
            NSError *error;
            [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        if (![fileManager fileExistsAtPath:filePath]) {
            UIImage *image = [UIImage imageWithData:provider.returnData];
            if (image) {
                if ([provider.returnData writeToFile:filePath atomically:YES]) {
                    NSLog(@"Successful save data:%@", provider.categoryName);
                    //wire to file successful. release cache data
                    //                    [detailViewController reloadImageById:provider.categoryName];
//                    for (int i =0; i<[arrayFullPhotos count]; i++) {
//                        NSDictionary *dict = [arrayFullPhotos objectAtIndex:i];
//                        if ([provider.categoryName isEqual:[dict objectForKey:@"id"]]) {
//                            NSLog(@"index =%d",i);
//                        }
//                    }
//                    [(ViewController*) reloadPhotoById:provider.categoryName];
                    //                        [detailViewController configureView];
                    provider.returnData = [NSData data];
                }
            }                
        }
        
        
    }
    counter ++;
    [self loadOneByOneImage];
    
}
-(void)ImagesProfileProviderDidFinishWithError:(NSError *)error provider:(ImagesProfileProvider *)provider
{
    
}
@end
