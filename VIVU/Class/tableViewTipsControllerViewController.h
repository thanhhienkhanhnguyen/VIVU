//
//  tableViewTipsControllerViewController.h
//  VIVU
//
//  Created by MacPro on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewTipsDelegate <NSObject>

-(void)backToDetaiVenueViewController;

@end

@interface tableViewTipsControllerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arrayTips;

@property (nonatomic, assign) BOOL isBelongToPopOver;
@property (nonatomic, assign) id<TableViewTipsDelegate> delegate;
@end
