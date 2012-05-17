//
//  ImagesProfileProvider.h
//  VIVU
//
//  Created by MacPro on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//load Detail of One photo , return NSData

typedef enum
{
    ProviderModeIcon = 0,
    ProviderModeImage,
    ProvierModeUserMostActive,
}ProvierMode;

#import "Foundation/Foundation.h"
#import "SearchPlaceProvider.h"


@class ImagesProfileProvider;
@protocol ImagesProfileProviderDelegate <NSObject>

-(void)ImagesProfileProviderDidFinishParsing:(ImagesProfileProvider *)provider;
-(void) ImagesProfileProviderDidFinishWithError:(NSError *)error  provider:(ImagesProfileProvider*)provider;

@end



@interface ImagesProfileProvider:SearchPlaceProvider
{
    
}
@property (nonatomic, assign) id<ImagesProfileProviderDelegate> ImagesProfileDelegate;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSData *returnData;
@property (nonatomic, assign) ProvierMode mode;
@property (nonatomic, assign) BOOL finishLoad;
-(void)configURLByURL:(NSString *)link;
-(NSString*) getCurrentURL;

@end
