//
//  VIVUtilities.h
//  VIVU
//
//  Created by MacPro on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ImagesProfileProvider.h"

@interface VIVUtilities : NSObject<ImagesProfileProviderDelegate>
{
   
}
@property (nonatomic, retain) NSMutableArray *arrayProvider;
@property (nonatomic, retain) NSMutableArray *arrayImages;
@property (nonatomic, assign) NSInteger counter;


+(void)stopArrayProvider:(NSMutableArray*)arrProvider;
+ (NSString *)applicationDocumentsDirectory;
+ (NSDate *)dateFrom:(NSTimeZone *)fTimeZone to:(NSTimeZone *)timeZone forDate:(NSDate *)date;
+(CGSize) getSizeIpad;
+(CGSize) getSizeIphone;
+(BOOL)isIpadDevice;
+(CGSize)getSizeDevice;
@end
