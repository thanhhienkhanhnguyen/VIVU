//
//  tableViewTipsControllerViewController.h
//  VIVU
//
//  Created by MacPro on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosViewController.h"
#import "PhotosScrollViewController.h"

@protocol TableViewTipsDelegate <NSObject>

@optional
-(void)backToDetaiVenueViewController;
-(void) loadDetailPhotosFromTips:(PhotosScrollViewController *)photosScrollView;
-(void) rePresentPopOverFromTips;
-(void) presentPhotosViewFromtips:(PhotosViewController*)photosView;

@end

@interface tableViewTipsControllerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PhotosViewControllerDelegate>


@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arrayTips;

@property (nonatomic, assign) BOOL isBelongToPopOver;
@property (nonatomic, assign) id<TableViewTipsDelegate> delegate;
@property (nonatomic, retain) PhotosViewController *photosViewController;
@end
