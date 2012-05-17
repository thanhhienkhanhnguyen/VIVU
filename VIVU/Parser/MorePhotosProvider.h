//
//  MorePhotosProvider.h
//  VIVU
//
//  Created by MacPro on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchPlaceProvider.h"


@class MorePhotosProvider;

@protocol MorePhotosDelegate <NSObject>

-(void) MorePhotosDidFinishParsing:(MorePhotosProvider *)provider;
-(void) MorePhotosdidFinishParsingWithError:(MorePhotosProvider *) provider error:(NSError *)error;

@end

@interface MorePhotosProvider : SearchPlaceProvider
@property (nonatomic, assign ) id<MorePhotosDelegate>delegateMorePhotos;

-(void) configURLByVenueID:(NSString *)venueID;
@end
