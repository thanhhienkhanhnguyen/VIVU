//
//  DetailPlaceProvider.m
//  VIVU
//
//  Created by MacPro on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailPlaceProvider.h"

@implementation DetailPlaceProvider
@synthesize delegateDetail;
-(void)dealloc
{
    delegateDetail =nil;
    [super dealloc];
}

-(void)configURLByItemId:(NSString *)itemId
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *strDate = [formatter stringFromDate:date];
    URL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@?oauth_token= TWIGXJFDA112OFRJLP0OS2UBJMMGZ5EID2MGQFQLZO4QAKOJ&v=%@",itemId,strDate];
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    self.resultContent =[NSMutableArray array];
    [formatter release];
    NSLog(@"%@",URL);
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
        NSDictionary *dictVenue = [dictResponse objectForKey:@"venue"];
        NSDictionary *mayor = [dictVenue objectForKey:@"mayor"];
        NSMutableArray *arrayTips = [NSMutableArray array];
        NSMutableArray *arrayPhotos = [NSMutableArray array];
        NSDictionary *subTips1 = [dictVenue objectForKey:@"tips"];
        NSArray *arrGroup = [subTips1 objectForKey:@"groups"];
        if ([arrGroup count]>0) {
            NSArray *items = [[arrGroup objectAtIndex:0] objectForKey:@"items"];
            for(NSDictionary *dictItem in items)
            {
                NSString * idTip  = [dictItem objectForKey:@"id"];
                NSString *date = [dictItem objectForKey:@"createdAt"];
                NSString *text = [dictItem objectForKey:@"text"];
                NSDictionary *dictPhotos = [dictItem objectForKey:@"photo"];
                NSString *url = [dictPhotos objectForKey:@"url"];
                NSString *idPhoto = [dictPhotos objectForKey:@"id"];
                if ([url rangeOfString:@"jpg"].length>0) {
                    url= [url stringByReplacingOccurrencesOfString:@".jpg" withString:@"_100x100.jpg"];
                }
                
                if ([url rangeOfString:@"pix"].length>0) {
                    url =[url stringByReplacingOccurrencesOfString:@"pix" withString:@"derived_pix"];
                }  
                NSDictionary *dictUser = [dictItem objectForKey:@"user"];
                NSDictionary *dictTipItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                             dictUser,@"userTip",
                                             idTip,@"idTip",
                                             date, @"date",
                                             text,@"text",
                                             url,@"url", 
                                             idPhoto,@"idPhoto",
                                             nil];
                [arrayTips addObject:dictTipItem];
                
            }

        }
        NSDictionary *subPhoto = [dictVenue objectForKey:@"photos"];
        NSNumber *count =[NSNumber numberWithInt:0];
        arrGroup = [subPhoto objectForKey:@"groups"];
        if ([arrGroup count]>1) {
            NSDictionary *photosDict = [arrGroup objectAtIndex:1];
           
            NSArray *items = [photosDict objectForKey:@"items"];
            count = [photosDict objectForKey:@"count"];
            for(NSDictionary *dictItem in items)
            {
                NSString *url = [dictItem objectForKey:@"url"];
                if ([url rangeOfString:@"jpg"].length>0) {
                    url= [url stringByReplacingOccurrencesOfString:@".jpg" withString:@"_100x100.jpg"];
                }
                
                if ([url rangeOfString:@"pix"].length>0) {
                    url =[url stringByReplacingOccurrencesOfString:@"pix" withString:@"derived_pix"];
                }  
                
                NSDictionary *dictPhotoItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [dictItem objectForKey:@"id"],@"id",
                                               url,@"url",
                                               nil];
//                if ([arrayPhotos count]==4) {
//                    break;
//                }
                [arrayPhotos addObject:dictPhotoItem];
            }
        }
        
       //        NSMutableDictionary *userMostActive = [mayor objectForKey:@"user"];
//        [userMostActive setObject:[mayor objectForKey:@"count"] forKey:@"count"];
       
        NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:  
                                arrayTips,@"tips",
                                arrayPhotos,@"photos",
                                count,@"countPhoto",
                                mayor,@"userMostActive",
                                    nil];

        [self.resultContent addObject:result];
//        [arrayTips release];
//        [arrayPhotos release];
            
            
         
        
    }
    self.receivedData = nil;
    if ([delegateDetail respondsToSelector:@selector(DetailPlaceDidFinishParsing:)]) {
        [delegateDetail DetailPlaceDidFinishParsing:self];
    }

}
@end
