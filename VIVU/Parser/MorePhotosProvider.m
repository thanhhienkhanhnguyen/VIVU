//
//  MorePhotosProvider.m
//  VIVU
//
//  Created by MacPro on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MorePhotosProvider.h"

@implementation MorePhotosProvider

@synthesize delegateMorePhotos;

-(void)dealloc
{
    delegateMorePhotos = nil;
    [super dealloc];
}

-(void) configURLByVenueID:(NSString *)venueID
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *strDate = [formatter stringFromDate:date];
    
    URL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/photos?group=venue&limit=90&oauth_token=TWIGXJFDA112OFRJLP0OS2UBJMMGZ5EID2MGQFQLZO4QAKOJ&v=%@",venueID,strDate];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    self.resultContent =[NSMutableArray array];
    NSLog(@"%@",URL);
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection 
{
    self.loadingData = NO;
	self.connection = nil;
    NSString *csv = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    SBJsonParser *jParser = [[SBJsonParser alloc] init];
	id jResult = [jParser objectWithString:csv];
    [csv release];
    [jParser release];
    if ([jResult isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictResponse = [jResult objectForKey:@"response"];
        NSDictionary *dictPhotos = [dictResponse objectForKey:@"photos"];
        NSArray *items = [dictPhotos objectForKey:@"items"];
        NSLog(@"%d",[items count]);
        for(NSDictionary *dictImage in items)
        {
            NSString *url = [dictImage objectForKey:@"url"];
            NSString *photoId = [dictImage objectForKey:@"id"];
            NSDictionary *size = [dictImage objectForKey:@"sizes"];
            NSArray *sizePhotos = [size objectForKey:@"items"];
            NSString *minUrl = [[sizePhotos objectAtIndex:2]objectForKey:@"url"];
            NSNumber *width = [[sizePhotos objectAtIndex:0]objectForKey:@"width"];
            NSNumber *height = [[sizePhotos objectAtIndex:0]objectForKey:@"height"];
            NSDictionary *dictResult = [NSDictionary dictionaryWithObjectsAndKeys:
                                        photoId,@"id",
                                        url,@"url",
                                        minUrl,@"minUrl",
                                        width,@"width",
                                        height,@"height",
                                        nil];
            [self.resultContent addObject:dictResult];
        }
        
        
        
        
        
    }
    self.receivedData = nil;
    if ([delegateMorePhotos respondsToSelector:@selector(MorePhotosDidFinishParsing:)]) {
        [delegateMorePhotos MorePhotosDidFinishParsing:self];
    }

}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	self.loadingData = NO;
	self.receivedData = nil;
	self.connection = nil;
    //    NSLog([error description]);
    self.resultContent = nil;
    if ([delegateMorePhotos respondsToSelector:@selector(MorePhotosdidFinishParsingWithError:error:)]) {
        [delegateMorePhotos MorePhotosdidFinishParsingWithError:self error:error];
    }
}

@end
