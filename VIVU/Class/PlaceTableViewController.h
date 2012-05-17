//
//  PlaceTableViewController.h
//  VIVU
//
//  Created by MacPro on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesProfileProvider.h"
#import "VIVUtilities.h"

@protocol PlaceTableViewDelagate <NSObject>

-(void)pushDetailFromPlaceTableView:(NSDictionary *)dictInfo;

@end

@interface PlaceTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ImagesProfileProviderDelegate>
{
    NSInteger counter;
    
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSourceTableView;
@property (nonatomic, retain) NSMutableArray *arraySourceFavicon;
@property (nonatomic,retain) IBOutlet UIView *resizeView;
@property (nonatomic, retain) id<PlaceTableViewDelagate>delegate;
-(void) loadOneByOneIcon;
-(void)loadOneByOneImage;
-(void)configureView;
-(CGSize)sizeInPopoverView;
@end
