//
//  SearchPlaceProvider.h
//  VIVU
//
//  Created by MacPro on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import <MapKit/MapKit.h>



@class SearchPlaceProvider;
@protocol SearchPlaceDelegate <NSObject>

-(void) SearchPlaceDidFinishParsing:(SearchPlaceProvider*)provider;
-(void)SearchPlaceDidFailWithError:(SearchPlaceProvider *)provider error:(NSError *)error;

@end

@interface SearchPlaceProvider : NSObject<NSXMLParserDelegate>
{
    
    NSString *URL;
    id<SearchPlaceDelegate> delegate;
    BOOL loadingData;
    
}
@property (nonatomic, assign) BOOL loadingData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic,assign) id<SearchPlaceDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *resultContent;
@property (nonatomic, assign) NSInteger index;



-(void)configURL:(CLLocation*)location;
- (void)requestData;
- (void) cancelDownload;
-(void) parserXML;

@end
