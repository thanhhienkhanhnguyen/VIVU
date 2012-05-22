//
//  SearchPlaceProvider.m
//  VIVU
//
//  Created by MacPro on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define DEFAULT_IMAGE_LINK  @"https://vietnamagilemobile.com.vn/image/default"
#import "SearchPlaceProvider.h"

@implementation SearchPlaceProvider
@synthesize connection;
@synthesize receivedData;
@synthesize resultContent;
@synthesize delegate;
@synthesize loadingData;
@synthesize index;

-(void)dealloc
{
    [connection release];
    [receivedData release];
    [resultContent release];
    delegate = nil;
    [super dealloc];
}
-(id)init
{
    self = [super init];
    if (self) {
        index =0;
    }
    return self;
}
-(void)parserXML
{
    
}
-(void)configURL:(CLLocation *)location
{

    NSDate *date = [NSDate date];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *strDate = [formatter stringFromDate:date];
    
    URL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&oauth_token= TWIGXJFDA112OFRJLP0OS2UBJMMGZ5EID2MGQFQLZO4QAKOJ&radius=1200&limit=50&v=%@",location.coordinate.latitude,location.coordinate.longitude,strDate];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    self.resultContent =[NSMutableArray array];
    NSLog(@"%@",URL);

}
-(void)requestData
{
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
    }

}
-(void)cancelDownload
{
    if (self.loadingData)
	{
		[self.connection cancel];
		self.loadingData = NO;
		
		self.receivedData = nil;
		self.connection = nil;
	}
}
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[self.receivedData appendData:data];
}

- (void) connection:(NSURLConnection *)connection12 didReceiveResponse:(NSURLResponse *)response 
{
    
	[self.receivedData setLength:0];
    if ([response respondsToSelector:@selector(statusCode)])
    {
        //DBLog(@"Header:%@", [[((NSHTTPURLResponse *)response) allHeaderFields] description]);
        int statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400 && statusCode != 404)
        {
            [connection12 cancel];  // stop connecting; no more delegate messages
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat: NSLocalizedString(@"Server returned status code %d",@""), statusCode]
                                                                  forKey:NSLocalizedDescriptionKey];
            NSError *statusError = [NSError errorWithDomain:NSUnderlyingErrorKey code:statusCode userInfo:errorInfo];
            [self connection:connection12 didFailWithError:statusError];
        }
    }

}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	self.loadingData = NO;
	self.receivedData = nil;
	self.connection = nil;
    NSLog(@"error code%d",[error code]);
    self.resultContent = nil;
    //    if ([_delegate respondsToSelector:@selector(sbuTweetsActiclesTextOnlyContentProviderDidFinishParsing:)]) {
    //        [_delegate sbuTweetsActiclesTextOnlyContentProviderDidFinishParsing:self];
    //    }
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection 
{
	self.loadingData = NO;
	self.connection = nil;
    NSString *csv = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    //    csv =[csv stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"];
    SBJsonParser *jParser = [[SBJsonParser alloc] init];
	id jResult = [jParser objectWithString:csv];
    [csv release];
    [jParser release];
    if ([jResult isKindOfClass:[NSDictionary class]]) {
//        NSMutableArray *array =[jResult objectForKey:@"results"];
        NSDictionary *dictResponse = [jResult objectForKey:@"response"];
        NSMutableArray *array = [dictResponse objectForKey:@"venues"];
        for (int i =0; i<[array count]; i++) {
            NSDictionary *temp = [array  objectAtIndex:i];
            NSString *name = [temp objectForKey:@"name"];
//            NSString *Address = [temp objectForKey:@"vicinity"];
            NSMutableDictionary *location = [temp objectForKey:@"location"];
            NSString *itemIdentifier = [temp objectForKey:@"id"];
            
            //write images to file /favicon/%name.favicon
            NSArray *dictCategory = [temp objectForKey:@"categories"];
            NSDictionary *tempdict = nil;
            NSString *imageslink = nil;
            NSString *nameCategory =nil;
            NSString *parentCategory= nil;
            if (dictCategory) {
                if ([dictCategory count]>=1) {
                    tempdict = [dictCategory objectAtIndex:0];

                }
            }
            if (tempdict) {
                NSDictionary *icon = [tempdict objectForKey:@"icon"];
                imageslink = [NSString stringWithFormat:@"%@32.png",[icon objectForKey:@"prefix"]];
                //get super Category
                NSArray *array =  [imageslink componentsSeparatedByString:@"/"];
                parentCategory = [array objectAtIndex:[array count]-2];
                nameCategory = [tempdict objectForKey:@"name"];
                nameCategory =[nameCategory stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            if (!nameCategory) {
                nameCategory = @"Others";
                parentCategory =@"Others";
                imageslink =DEFAULT_IMAGE_LINK;
               
            }
            NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                    name,@"name",
                                    location, @"location",
                                    itemIdentifier,@"id",
                                    imageslink,@"imagelink",
                                    nameCategory,@"type",
                                    parentCategory,@"parentCategory",
                                    nil];
//            if ([[result objectForKey:@"name"]hasPrefix:@"Huy"]) {
//                NSLog(@"%@",[result objectForKey:@"parentCategory"]);
//            }
            [self.resultContent addObject:result];
            
            
        }    
        
    }
    self.receivedData = nil;
    if ([delegate respondsToSelector:@selector(SearchPlaceDidFinishParsing:)]) {
        [delegate SearchPlaceDidFinishParsing:self];
    }
   	
}

@end
