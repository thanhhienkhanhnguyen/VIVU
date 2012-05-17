//
//  ShowAllPlaceViewController_Ipad.m
//  VIVU
//
//  Created by MacPro on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowAllPlaceViewController_Ipad.h"
#import "SlideGroupSource.h"

@interface ShowAllPlaceViewController_Ipad ()

@end

@implementation ShowAllPlaceViewController_Ipad
@synthesize tableView;
@synthesize dataSourceGroupTableView;
@synthesize delegate;
@synthesize dataSourceTableView;
@synthesize arraySourceFavicon;
@synthesize cheatView;
@synthesize requestDetaiLocation;
@synthesize detailViewController;
@synthesize arrayImages;
@synthesize arrayProvider;
@synthesize counter;

-(void)dealloc{
    
    
    [arrayProvider release];
    [arrayImages release];
    [detailViewController release];
    delegate =nil;
    [requestDetaiLocation release];
    [cheatView release];
    [dataSourceGroupTableView release];
    [arraySourceFavicon release];
    [tableView release];
    [dataSourceTableView release];
    [super dealloc];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate closeTableView];
}
-(CGSize)sizeInPopoverView
{
   
    int count = [self.dataSourceTableView count];
    CGFloat h = count * 44;
    //    h += 44; //for navigation bar
    if (h>44*10) {
        h=44*10;
    }
    return CGSizeMake(320-20, h);
}
#pragma table Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!dataSourceTableView) {
        return 0;
    }else {
        return [dataSourceTableView count];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView12 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Place Cell";
    
    UITableViewCell *cell = [tableView12 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        //        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, (cell.frame.size.width - 40) - 5, 20)];
        //        [label setTag:NameTag];
        //        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        //        label.textColor = [UIColor colorWithRed:66.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1]; 
        //        [cell.contentView addSubview:label];
        //        [label release];
        //        label = [[UILabel alloc]initWithFrame:CGRectMake(40, 25,  (cell.frame.size.width - 40) - 5, 20)];
        //        [label setTag:SubDetail];
        //        label.textColor = [UIColor colorWithRed:66.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1]; 
        //        label.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        //        [cell.contentView addSubview:label];
        //        [label release];
        
    }
    
    NSDictionary *dictDetail = nil;
    id item = [dataSourceTableView objectAtIndex:indexPath.section];
    if ([item isKindOfClass:[SlideGroupSource class]]) {
        dictDetail = [((SlideGroupSource *)item).childs objectAtIndex:indexPath.row];
    }else{
        dictDetail = [dataSourceTableView objectAtIndex:indexPath.row];
    }
    
    
    if ([dictDetail isKindOfClass:[NSDictionary class]]) {
        cell.textLabel.text = [dictDetail objectForKey:@"name"];
        //    UILabel *distanceLabel = (UILabel *)[cell.contentView viewWithTag:SubDetail];
        NSDictionary *location = [dictDetail objectForKey:@"location"];
        NSString *distance = [location objectForKey:@"distance"];
        NSString *temp = [NSString stringWithFormat:@"%@ m",distance];
        //    distanceLabel.text = temp;
        
        cell.detailTextLabel.text = temp;
        
        NSString *filePath = [NSString stringWithFormat:@"%@/favicon/%@.favicon.ico",
                              [VIVUtilities applicationDocumentsDirectory],
                              [dictDetail objectForKey:@"type"]];
        
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            //Image default
            cell.imageView.image = [UIImage imageNamed:@"default_32.png"];
            
        }else {
            cell.imageView.image = image;
        }
        
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictInfo = [dataSourceTableView objectAtIndex:indexPath.row];
    if (dictInfo) {
        [self.delegate showDetailPlaceWithDictInfo:dictInfo];
    }
    
}
-(void) DetailPlaceDidFinishParsing:(DetailPlaceProvider *)provider
{
    
}
#pragma mark App Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSourceTableView = nil;
        [self.view setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewContentModeBottomLeft|UIViewContentModeBottomRight|UIViewAutoresizingFlexibleTopMargin];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end