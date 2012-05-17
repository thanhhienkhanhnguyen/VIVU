//
//  ImagesProfileProvider.m
//  VIVU
//
//  Created by MacPro on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImagesProfileProvider.h"

@implementation ImagesProfileProvider
@synthesize ImagesProfileDelegate;
@synthesize categoryName;
@synthesize returnData;
@synthesize mode;
@synthesize finishLoad;
-(void)dealloc
{
    finishLoad = NO;
    [categoryName release];
    ImagesProfileDelegate = nil;
    [super dealloc];
}

-(void)configURLByURL:(NSString *)link
{
    URL = link;
}
-(NSString *)getCurrentURL
{
    return URL;
}
-(void)requestData
{
    self.finishLoad = NO;
    NSString * urlString = URL;
    if ([urlString length] > 0) {
        self.loadingData = YES;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        self.connection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
        if (self.connection) {
            self.receivedData = [NSMutableData data];
        } else {
            self.loadingData = NO;
        }
    }else {
        finishLoad = YES;
        if ([ImagesProfileDelegate respondsToSelector:@selector(ImagesProfileProviderDidFinishParsing:)]) {
            [ImagesProfileDelegate ImagesProfileProviderDidFinishParsing:self];
            
        }
    }
    
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection 
{
	self.loadingData = NO;
	self.connection = nil;
	if ([self.receivedData isKindOfClass:[NSData class]]) {
        self.returnData = [NSData dataWithData:self.receivedData];
        self.receivedData = nil;
        UIImage *image = [UIImage imageWithData:returnData];
        if (image) {
            finishLoad = YES;
            if ([ImagesProfileDelegate respondsToSelector:@selector(ImagesProfileProviderDidFinishParsing:)]) {
                [ImagesProfileDelegate ImagesProfileProviderDidFinishParsing:self];
                
            }
        }else {
            //Access Deny
            finishLoad = YES;
            [self cancelDownload];
            if ([ImagesProfileDelegate respondsToSelector:@selector(ImagesProfileProviderDidFinishWithError:provider:)]) {
                [ImagesProfileDelegate ImagesProfileProviderDidFinishWithError:nil provider:self];
                
            }
        }
       
      
    }else {
        finishLoad = NO;

    }
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    finishLoad = NO;
    [self cancelDownload];
    
    if ([ImagesProfileDelegate respondsToSelector:@selector(ImagesProfileProviderDidFinishWithError:provider:)]) {
        [ImagesProfileDelegate ImagesProfileProviderDidFinishWithError:error provider:self];
        
    }
}
@end
