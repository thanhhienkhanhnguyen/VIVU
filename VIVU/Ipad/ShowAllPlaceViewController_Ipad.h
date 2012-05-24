//
//  ShowAllPlaceViewController_Ipad.h
//  VIVU
//
//  Created by MacPro on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailPlaceProvider.h"
#import "DetailPlaceViewControllerViewController.h"
#import "DetailVenueViewControllerIpad.h"

@protocol ShowPlaceTableDelegateIpad <NSObject>

-(void) closeTableView;
-(void)showDetailPlaceWithDictInfo:(NSDictionary *)dictInfo;
-(void) loadDetailPhotosFromGroupPlace:(PhotosScrollViewController*)photoScrollView;
-(void) rePresentPopOverFromTableView;

@end

@interface ShowAllPlaceViewController_Ipad : UIViewController<DetailPlaceDelegate,UITableViewDelegate,UITableViewDataSource,DetailVenueViewControllerDelegate>


@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSourceTableView;
@property (nonatomic, retain) NSMutableArray *dataSourceGroupTableView;
@property (nonatomic, retain) NSMutableArray *arraySourceFavicon;
@property (nonatomic, retain) IBOutlet UIView *cheatView;
@property (nonatomic, assign) id<ShowPlaceTableDelegateIpad> delegate;
@property (nonatomic, retain) DetailPlaceProvider *requestDetaiLocation;
@property (nonatomic, retain) DetailPlaceViewControllerViewController *detailViewController;
@property (nonatomic, retain) NSMutableArray *arrayImages;
@property (nonatomic, retain) NSMutableArray *arrayProvider;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, retain) DetailVenueViewControllerIpad *detailVenueViewController;


-(CGSize)sizeInPopoverView;
@end
