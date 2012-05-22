//
//  PhotosViewController.m
//  VIVU
//
//  Created by MacPro on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define FLEXIBLE_SPACE               10
#define WIDTH_IMAGE                  60
#define NUMBER_IMAGE_PER_PAGE        28
#define PADDING_TOP                  30;

#import "PhotosViewController.h"
#import "VIVUtilities.h"
#import "CustomeButton.h"
#include <QuartzCore/QuartzCore.h>

@interface PhotosViewController ()
{
    CGFloat maxY;
}

@end

@implementation PhotosViewController
@synthesize arrayPhotos;
@synthesize scrollView;
@synthesize numberPhotos;
@synthesize photosView;
@synthesize delegate;
@synthesize isBelongToPopOver;
@synthesize btnClose;
@synthesize subArrayPhotos;
@synthesize delegatePhotosView;

-(void)dealloc
{
    delegatePhotosView =nil;
    [subArrayPhotos release];
    [btnClose release];
    delegate =nil;
    [arrayPhotos release];
    [scrollView release];
    numberPhotos =0;
    [photosView release];
    [super dealloc];
}


-(IBAction)closeView:(id)sender
{
    if ([VIVUtilities isIpadDevice]) {
        [self.delegatePhotosView closeRequestImageProvider];
        [self.delegate closeMorePhoto];
    }else {
        [self.delegatePhotosView closeRequestImageProvider];
        [self dismissModalViewControllerAnimated:YES];

    }
//        
}
-(void)reloadPhotoById:(NSString *)Id
{
    NSInteger index =0;
    BOOL found = NO;
    for (int i =0; i< [arrayPhotos count]; i++) {
        NSDictionary *dictImage = [arrayPhotos objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            index = i;
            found = YES;
            break;
            
        }
    }
    if (found) {
        NSInteger tag = index +2012;
        UIView *subView = [self.scrollView viewWithTag:tag];
        if ([subView isKindOfClass:[CustomeButton class]]) {
            if ([((CustomeButton*)subView).imageId isEqual:Id]) {
                NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                                      [VIVUtilities applicationDocumentsDirectory],
                                      Id];
                found = YES;
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (image) {
                    [((CustomeButton*)subView) setImage:image forState:UIControlStateNormal];
                }else {
                    image = [UIImage imageNamed:@"default_32.png"];
                    [((CustomeButton*)subView) setImage:image forState:UIControlStateNormal];
                }
                
            }
        }

    }
    
    
  
}
-(void) loadPhotosViewDetail:(id)sender
{
    if (!photosView) {
        if ([VIVUtilities isIpadDevice]) {
            photosView = [[PhotosScrollViewController alloc]initWithNibName:@"PhotosScrollViewControllerIpad" bundle:nil];
            photosView.delegate =self;
        }else {
            photosView = [[PhotosScrollViewController alloc]initWithNibName:@"PhotosScrollViewController" bundle:nil];
            photosView.delegate =self;
        }
       
    }
    photosView.arrayPhotos = arrayPhotos;
    photosView.currentPhotoId = ((CustomeButton*)sender).imageId;
    photosView.modalPresentationStyle = UIModalPresentationFullScreen;
    photosView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    if ([VIVUtilities isIpadDevice]) {
        [self.delegate loadDetailPhotos:photosView];
    }else {
        [self presentModalViewController:photosView animated:YES];
    }
   
    
}
-(void) rePresentPopOver
{
    [self.delegate rePresentPopOverFromPhotosViewController];
}
-(void) createSubPhotosWithIndex:(NSInteger)page
{
//    if (!subArrayPhotos) {
////        self.subArrayPhotos = [NSMutableArray array];
//    }
    
    if ([arrayPhotos count]>=NUMBER_IMAGE_PER_PAGE*page) {
       
        NSRange range;
        range.length =NUMBER_IMAGE_PER_PAGE;
        range.location = (page-1) *NUMBER_IMAGE_PER_PAGE;
        self.subArrayPhotos = (NSMutableArray *)[arrayPhotos subarrayWithRange:range];
    }else {
        NSRange range;
        range.length =([arrayPhotos count]-NUMBER_IMAGE_PER_PAGE*(page-1));
        range.location = (page-1) *NUMBER_IMAGE_PER_PAGE;
        self.subArrayPhotos = (NSMutableArray *)[arrayPhotos subarrayWithRange:range];
//        subArrayPhotos = arrayPhotos;
    }
}
-(void) createBasicViewPhotosForPopOver:(NSInteger)page
{
    
    if ([subArrayPhotos count]>0||([subArrayPhotos count]<=4&& isBelongToPopOver)) {
        //            NSLog(@"subImages :%d",[arrayPhotos count]);
        
        NSInteger row = (int)[subArrayPhotos count]/4+1;
        CGRect frame = CGRectMake(0, 0, 0, 0);
        for (int i=1; i <=row; i++) {
            
            for (int j =1; j<= 4; j++) {
                
                NSInteger index = (i-1)*4+j-1;
                if (index >=[subArrayPhotos count]) {
                    break;
                }
                NSInteger indexInArray = index + (page-1)*NUMBER_IMAGE_PER_PAGE;
                NSInteger tag = indexInArray +2012;
                NSDictionary *dictImage = [arrayPhotos objectAtIndex:indexInArray];
                //                    NSLog(@"aaaaaa%@",[dictImage objectForKey:@"url"]);
                
                NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                                      [VIVUtilities applicationDocumentsDirectory],
                                      [dictImage objectForKey:@"id"]];
                
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (!image) {
                    image = [UIImage imageNamed:@"default_32.png"];
                }
                if (isBelongToPopOver) {
                    frame = CGRectMake(20+(j-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE),maxY + 10+ (i-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), WIDTH_IMAGE, WIDTH_IMAGE);
//                    self.btnClose.hidden = YES;
                    
                }else {
                    if (page==1) {
                       frame = CGRectMake(20+(j-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE),10 + 10+ (i-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), WIDTH_IMAGE, WIDTH_IMAGE); 
                    }else {
                        frame = CGRectMake(20+(j-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE),maxY + 10+ (i-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), WIDTH_IMAGE, WIDTH_IMAGE);
                    }
//                    self.btnClose.hidden = NO;
                    
                }
                
                if (index ==[subArrayPhotos count]-1) {
                    maxY = frame.origin.y;
                }
                CustomeButton *btn = [[CustomeButton alloc]initWithFrame:frame];
                [btn setTag:tag];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(loadPhotosViewDetail:) forControlEvents:UIControlEventTouchUpInside];
                btn.imageId = [dictImage objectForKey:@"id"];
                btn.url = [dictImage objectForKey:@"url"];
                btn.arrayPhotos = arrayPhotos;
                [self.scrollView addSubview:btn];
                [btn release];
            }
            
            
            
            
        }
        if ([arrayPhotos count]>NUMBER_IMAGE_PER_PAGE*page) {
            maxY =maxY +WIDTH_IMAGE+10;
            UIButton *btnShowMorePhoto = [[UIButton alloc]initWithFrame:CGRectMake(20, maxY, 270, 30)];
            [btnShowMorePhoto setTag:page+30000];
//            [btnShowMorePhoto setTitle:@"Show More Photos" forState:UIControlStateNormal];
            UIImage *image = [UIImage imageNamed:@"more_photo_02.png"];
            image = [VIVUtilities scaleImage:image withSize:CGSizeMake(270, 30)];
            [btnShowMorePhoto setBackgroundImage:image forState:UIControlStateNormal];
            
            [btnShowMorePhoto addTarget:self action:@selector(createMorePhotos:) forControlEvents:UIControlEventTouchUpInside];
            [btnShowMorePhoto setTintColor:[UIColor greenColor]];
//            [btnShowMorePhoto.layer setBorderColor:[UIColor greenColor].CGColor];
//            [btnShowMorePhoto.layer setBorderWidth:10.0f];
            [self.scrollView addSubview:btnShowMorePhoto];
            [btnShowMorePhoto release];
//            maxY += WIDTH_IMAGE+100;
            UIButton *btn = (UIButton*)[self.view viewWithTag:page+30000];
            NSLog(@"%f %f %f %f",btn.frame.origin.x,btn.frame.origin.y,btn.frame.size.width,btn.frame.size.height);

            
        }
        [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,frame.origin.y+frame.size.height +100)];
        if (isBelongToPopOver) {
            [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, maxY+ WIDTH_IMAGE +100)];
        }
    }
}
-(void)createMorePhotos:(id)sender
{
    NSInteger tag = ((UIButton*)sender).tag;
    
  
    NSInteger page = tag -30000;
//    UIView *subView =  [self.scrollView viewWithTag:tag];
//    if (subView) {
//        [subView removeFromSuperview];
//    }
    [self createSubPhotosWithIndex:(page +1)];
    [self createBasicViewPhotosForPopOver:(page +1)];
    [self.delegatePhotosView closeRequestImageProvider];
    [self.delegatePhotosView requestMoreProviderWithSubArrayPhotos:subArrayPhotos];
    for (UIView *subView in self.scrollView.subviews) {
        if (subView.tag ==tag) {
            [subView removeFromSuperview];
        }
    }
    
    
}
-(void) clearAllImageInView
{
    for(UIView *subView in self.scrollView.subviews)
    {
        if ([subView isKindOfClass:[CustomeButton class]]) {
            [subView removeFromSuperview];
        }
    }
}
-(void)createBasicViewPhotos
{
    [self clearAllImageInView];
    CGRect frame = CGRectMake(320-50, 0, 50, 50);
    UIButton *btnCloseShowMorePhotos = [[UIButton alloc]initWithFrame:frame];
    [btnCloseShowMorePhotos setTitle:@"Close" forState:UIControlStateNormal];
    [btnCloseShowMorePhotos addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [btnCloseShowMorePhotos setImage:[UIImage imageNamed:@"btnMinus.png"] forState:UIControlStateNormal];
    [self.scrollView addSubview:btnCloseShowMorePhotos];
    [btnCloseShowMorePhotos release];
    
    if ([arrayPhotos count]>4||([arrayPhotos count]<=4&& isBelongToPopOver)) {
        //            NSLog(@"subImages :%d",[arrayPhotos count]);
        NSInteger row = (int)[arrayPhotos count]/4+1;
        CGRect frame = CGRectMake(0, 0, 0, 0);
        for (int i=1; i <=row; i++) {
            
            for (int j =1; j<= 4; j++) {
                
                NSInteger index = (i-1)*4+j-1;
                if (index >=[arrayPhotos count]) {
                    break;
                }
                NSInteger tag = index +2012;
                NSDictionary *dictImage = [arrayPhotos objectAtIndex:index];
                //                    NSLog(@"aaaaaa%@",[dictImage objectForKey:@"url"]);
                
                NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                                      [VIVUtilities applicationDocumentsDirectory],
                                      [dictImage objectForKey:@"id"]];
                
                UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                if (!image) {
                    image = [UIImage imageNamed:@"default_32.png"];
                }
                if (isBelongToPopOver) {
                    frame = CGRectMake(20+(j-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), 10+ (i-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), WIDTH_IMAGE, WIDTH_IMAGE);
                    
                    
                }else {
                    frame = CGRectMake(20+(j-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), 10+ i*(FLEXIBLE_SPACE+WIDTH_IMAGE), WIDTH_IMAGE, WIDTH_IMAGE);
                   
                }
                
                if (i==row-1) {
                    maxY = frame.origin.y;
                }
                CustomeButton *btn = [[CustomeButton alloc]initWithFrame:frame];
                [btn setTag:tag];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(loadPhotosViewDetail:) forControlEvents:UIControlEventTouchUpInside];
                btn.imageId = [dictImage objectForKey:@"id"];
                btn.url = [dictImage objectForKey:@"url"];
                btn.arrayPhotos = arrayPhotos;
                [self.scrollView addSubview:btn];
                [btn release];
            }
            
            
            
            
        }
        [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,frame.origin.y+frame.size.height +100)];
        if (isBelongToPopOver) {
            [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, maxY+ WIDTH_IMAGE +100)];
        }
    }
}






#pragma mark App Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isBelongToPopOver) {
//        CGRect frame = self.view.frame;
//        frame.size = CGSizeMake(330, 330);
//        [self.view setFrame:frame];
        [self setContentSizeForViewInPopover:CGSizeMake(330, 330)];
        if (isBelongToPopOver) {
            self.btnClose.hidden = YES;
        } 
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backToParrentView:)];
    self.navigationItem.leftBarButtonItem = btnBack;
    [btnBack release];
    
}
-(void) backToParrentView:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.delegate backToDetailVenueViewControllerFromPhotosView];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    return YES;
}

@end
