//
//  ShowAllPlaceViewController.h
//  VIVU
//
//  Created by MacPro on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesProfileProvider.h"
#import "VIVUtilities.h"
#import "SlideGroupSource.h"
#import "DetailPlaceProvider.h"
#import "DetailPlaceViewControllerViewController.h"

@protocol ShowAllPlaceDelegate <NSObject>

-(void) disMissTableViewController:(id)sender;
-(void) addDetailPlaceView:(NSDictionary *)dictInfo;


@end

@interface ShowAllPlaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ImagesProfileProviderDelegate,DetailPlaceDelegate,DetailViewControllerDelegate>
{
    DetailPlaceProvider *requestDetaiLocation ;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSourceTableView;
@property (nonatomic, retain) NSMutableArray *dataSourceGroupTableView;
@property (nonatomic, retain) NSMutableArray *arraySourceFavicon;
@property (nonatomic, retain) IBOutlet UIView *cheatView;
@property (nonatomic, assign) id<ShowAllPlaceDelegate> delegate;
@property (nonatomic, retain) DetailPlaceProvider *requestDetaiLocation;
@property (nonatomic, retain) DetailPlaceViewControllerViewController *detailViewController;
@property (nonatomic, retain) NSMutableArray *arrayImages;
@property (nonatomic, retain) NSMutableArray *arrayProvider;
@property (nonatomic, assign) NSInteger counter;



-(void) loadOneByOneIcon;
-(void)configureView;
-(CGSize)sizeInPopoverView;
-(void) convertDataSourceToGroup;
@end
