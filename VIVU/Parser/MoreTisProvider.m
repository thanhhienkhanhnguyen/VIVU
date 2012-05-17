//
//  MoreTisProvider.m
//  VIVU
//
//  Created by MacPro on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoreTisProvider.h"

@implementation MoreTisProvider

@synthesize delegateMoreTips;

-(void)dealloc
{
    delegateMoreTips = nil;
    [super dealloc];
}

-(void) configURLByVenueID:(NSString *)venueID
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter =[[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSString *strDate = [formatter stringFromDate:date];
    

    
    URL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/tips?sort=recent&limit=90&oauth_token=TWIGXJFDA112OFRJLP0OS2UBJMMGZ5EID2MGQFQLZO4QAKOJ&v=%@",venueID,strDate];
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
        NSDictionary *dictTips = [dictResponse objectForKey:@"tips"];
        NSArray *items = [dictTips objectForKey:@"items"];
        for(NSDictionary *dictTip in items)
        {
            NSString * idTip  = [dictTip objectForKey:@"id"];
            NSString *date = [dictTip objectForKey:@"createdAt"];
            NSString *text = [dictTip objectForKey:@"text"];
            NSString *url = [dictTip objectForKey:@"photourl"];
            NSDictionary *dictUser = [dictTip objectForKey:@"user"];
            NSDictionary *dictTipItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                         dictUser,@"userTip",
                                         idTip,@"idTip",
                                         date, @"date",
                                         text,@"text",
                                         url,@"url",         
                                         nil];
            [self.resultContent addObject:dictTipItem];
        }
        
        
        
        
        
    }
    self.receivedData = nil;
    if ([delegateMoreTips respondsToSelector:@selector(MoreTipsDidFinishParsing:)]) {
        [delegateMoreTips MoreTipsDidFinishParsing:self];
    }
    
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	self.loadingData = NO;
	self.receivedData = nil;
	self.connection = nil;
    //    NSLog([error description]);
    self.resultContent = nil;
    if ([delegateMoreTips respondsToSelector:@selector(MoreTipsdidFinishParsingWithError:error:)]) {
        [delegateMoreTips MoreTipsdidFinishParsingWithError:self error:error];
    }
}

@end
