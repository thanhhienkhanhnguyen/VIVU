//
//  SearchVenueViewController.h
//  VIVU
//
//  Created by MacPro on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailPlaceProvider.h"

@protocol SearchVenueViewControllerDelegate <NSObject>

-(void) pushDetailVenueFromSearchController:(NSDictionary *)dictDetail;

@end

@interface SearchVenueViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property(nonatomic,retain) IBOutlet UISearchBar *searchBarController;
@property (nonatomic,retain) NSMutableArray *dataSourceTableView;
@property (nonatomic,assign) id<SearchVenueViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UITableView *tableViewSearch;
@property (nonatomic,retain) NSMutableArray *resultDatasource;

@end
