//
//  SearchViewController.h
//  VIVU
//
//  Created by MacPro on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#include <QuartzCore/QuartzCore.h>
#import "DetailPlaceViewControllerViewController.h"
#import "DetailPlaceProvider.h"

@class SearchViewController;
@protocol SearchViewControllerDelegate <NSObject>


-(void) pushDetailViewControllerFromSearchView:(NSDictionary *)dictDetail;


@end
@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    DetailPlaceViewControllerViewController *dvController;
    BOOL checkEdit;
}

@property(nonatomic,retain) IBOutlet UISearchBar *searchBarController;
@property (nonatomic,retain) NSMutableArray *dataSourceTableView;
@property (nonatomic,retain) DetailPlaceProvider *requestLocation;
@property (nonatomic,assign) id<SearchViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UITableView *tableViewSearch;
@property (nonatomic,retain) NSMutableArray *resultDatasource;
@end
