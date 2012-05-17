//
//  MoreTisProvider.h
//  VIVU
//
//  Created by MacPro on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchPlaceProvider.h"

@class MoreTisProvider;
@protocol MoreTisProviderDelegate <NSObject>

-(void) MoreTipsDidFinishParsing:(MoreTisProvider *)provider;
-(void) MoreTipsdidFinishParsingWithError:(MoreTisProvider *) provider error:(NSError *)error;

@end


@interface MoreTisProvider : SearchPlaceProvider
@property (nonatomic, assign ) id<MoreTisProviderDelegate>delegateMoreTips;

-(void) configURLByVenueID:(NSString *)venueID;
@end
