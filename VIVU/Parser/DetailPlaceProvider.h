//
//  DetailPlaceProvider.h
//  VIVU
//
//  Created by MacPro on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchPlaceProvider.h"
@class  DetailPlaceProvider;
@protocol DetailPlaceDelegate <NSObject>

-(void) DetailPlaceDidFinishParsing:(DetailPlaceProvider *)provider;

@end

@interface DetailPlaceProvider : SearchPlaceProvider

@property (nonatomic, assign) id<DetailPlaceDelegate> delegateDetail;
-(void) configURLByItemId:(NSString *)itemId;

@end
