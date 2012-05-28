//
//  PhotosScrollViewController.m
//  VIVU
//
//  Created by MacPro on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define FLEXIBLE_SPACE               10
#define WIDTH_IMAGE                  60

#import "PhotosScrollViewController.h"
#import "CustomeButton.h"
#import "VIVUtilities.h"
#import "DetailImageViewController.h"
#import "ViewController.h"

@interface PhotosScrollViewController ()

@end

@implementation PhotosScrollViewController
@synthesize scrollView;
@synthesize arrayPhotos;
@synthesize spiner;
@synthesize numberImage;
@synthesize delegate;
@synthesize currentPhotoId;
@synthesize arrayDetailView;
@synthesize currentIndex;

- (oneway void)release
{
//    NSLog(@"PhotosScrollViewController release:%i",self.retainCount);
    return [super release];
}

- (id)retain
{
//    NSLog(@"PhotosScrollViewController retain:%i",self.retainCount);
    return [super retain];
}
-(void)dealloc
{
//    NSLog(@"PhotosScrollViewController dealloc:%i",scrollView.subviews.count);
    for (UIView *sv in scrollView.subviews) {
        
//        NSLog(@"sv class:%@ ---- sv:%i",NSStringFromClass([sv class]),sv.retainCount);
    }
    [arrayDetailView release];
    delegate = nil;
    [currentPhotoId release];
    [scrollView release];
    [arrayPhotos release];
    [spiner release];
    [super dealloc];
}
-(void)showDetailImage:(id)sender
{
    
}
-(IBAction)closeImagesViewController:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)configureView
{
   
}
- (void)loadView {
    [super loadView];
    self.arrayDetailView =[NSMutableArray array];
    self.view.backgroundColor = [UIColor blackColor];
    //MEMORY LEAK
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    scrollView.delegate =self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat w =0;
    CGFloat h =0;
//    NSLog(@"TEST loadView:%i",scrollView.subviews.count);
    for (int i = 0; i < [arrayPhotos count]; i++) {
//        CGFloat yOrigin = i * self.view.frame.size.width;
        NSDictionary *dictImage= [arrayPhotos objectAtIndex:i];
        NSString *imageID = [dictImage objectForKey:@"id"];
        NSString *url = [dictImage objectForKey:@"url"];
        DetailImageViewController *imageViewDetail  =nil;
        if (![VIVUtilities isIpadDevice]) {
            imageViewDetail = [[DetailImageViewController alloc]initWithNibName:@"DetailImageViewController" bundle:nil];
        }else {
            imageViewDetail = [[DetailImageViewController alloc]initWithNibName:@"DetailImagesViewControllerIpad" bundle:nil];
        }
//        NSLog(@"imageViewDetail.view.retainCount1:%i",imageViewDetail.view.retainCount);
        imageViewDetail.delegate =self;
        [arrayDetailView addObject:imageViewDetail];
//        NSLog(@"imageViewDetail.view.retainCount2:%i",imageViewDetail.view.retainCount);
        CGRect frame = imageViewDetail.view.frame;
//        frame.origin.x = yOrigin;
        frame.origin.x = i*[VIVUtilities getSizeDevice].width;
        frame.size = [VIVUtilities getSizeDevice];
        w += frame.size.width;
        h = frame.size.height;
        [imageViewDetail.view setFrame:frame];
//        NSLog(@"imageViewDetail.view.retainCount3:%i",imageViewDetail.view.retainCount);
        imageViewDetail.currentImageId = imageID;
        imageViewDetail.currentUrl = url;
        NSInteger tag = i +2013;
        [imageViewDetail.view setTag:tag];
//        NSLog(@"scrollView addSubview:imageViewDetail.view1:%i====%i", imageViewDetail.view.retainCount, imageViewDetail.retainCount);
        [scrollView addSubview:imageViewDetail.view];
//        NSLog(@"scrollView addSubview:imageViewDetail.view2:%i====%i", imageViewDetail.view.retainCount, imageViewDetail.retainCount);
        [imageViewDetail release];
//        NSLog(@"scrollView addSubview:imageViewDetail.view3:%i====%i", imageViewDetail.view.retainCount, imageViewDetail.retainCount);
        
    }
//    if ([VIVUtilities isIpadDevice]) {
//         scrollView.contentSize = CGSizeMake([VIVUtilities getSizeIpad].width * [arrayPhotos count], self.view.frame.size.height);
//    }else {
//         scrollView.contentSize = CGSizeMake([VIVUtilities getSizeIphone].width * [arrayPhotos count], self.view.frame.size.height);
//    }
    [scrollView setContentSize:CGSizeMake(w, h)];
   
    [self.view addSubview:scrollView];
    for (int i =0; i< [arrayPhotos count]; i++) {
        NSDictionary *dictImage= [arrayPhotos objectAtIndex:i];
        NSString *imageID = [dictImage objectForKey:@"id"];
        NSString *url = [dictImage objectForKey:@"url"];
        if ([imageID isEqual: self.currentPhotoId]) {
            CGFloat yOrigin = i * [VIVUtilities getSizeDevice].width;
            CGPoint pointSelectedPhoto = CGPointMake(yOrigin, 0);
            [self.scrollView setContentOffset:pointSelectedPhoto animated:YES];
            DetailImageViewController *imageDetailImage = [arrayDetailView objectAtIndex:i];
            [imageDetailImage loadImageFromID:imageID url:url];
            [self loadPreNextImage:imageID];
        }
    }
//    for (UIView *sv in scrollView.subviews) {
//        
//        NSLog(@"sv class:%@ ---- sv:%i",NSStringFromClass([sv class]),sv.retainCount);
//    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView12
{
    CGPoint point = scrollView12.contentOffset;
    NSInteger index = 0;
    //(int)(point.x /[VIVUtilities getSizeIphone].width);
//    if ([VIVUtilities isIpadDevice]) {
//        index = (int)(point.x /[VIVUtilities getSizeIpad].width);
//    }
    index = (int)(point.x/[VIVUtilities getSizeDevice].width);
    NSDictionary *dictImage= [arrayPhotos objectAtIndex:index];
//    NSInteger tag = index +2013;
    NSString *imageID = [dictImage objectForKey:@"id"];
    NSString *url = [dictImage objectForKey:@"url"];
//    UIView *subView = [self.scrollView viewWithTag:tag];
//    NSLog(@"indexscrollView %d",index);
//    if (arrayDetailView) {
//        NSLog(@"%d",[arrayDetailView count]);
//    }
    DetailImageViewController *imageViewController = [arrayDetailView objectAtIndex:(index)];
    if (imageViewController.requestBigImage.loadingData==YES) {
        [imageViewController.requestBigImage cancelDownload];
    }
    [imageViewController loadImageFromID:imageID url:url];
    [self loadPreNextImage:imageID];
//    if (subView) {
//        if ([subView isKindOfClass:[SubView class]]) {
//            NSLog(@"Sadasd");
//        }
//        [((SubView*)subView).delegateSubView callBackToParrentClass:imageID Url:url];
//    }
//   
    

}
-(void) loadPreNextImage:(NSString *)currentImageID
{
    for (int i=0; i< [arrayDetailView count]; i++) {
        DetailImageViewController *imageDetailView = [arrayDetailView objectAtIndex:i];
        if ([imageDetailView.currentImageId isEqual:currentImageID]) {
            DetailImageViewController *preImageDetailView = nil;
            DetailImageViewController *nextImageDetailView = nil;
            if (i>=1) {
                preImageDetailView = [arrayDetailView objectAtIndex:(i-1)];
            }
            if ((i+2)<=([arrayDetailView count])) {
//                NSLog(@"%d---%d",([arrayDetailView count]-2),i);
                nextImageDetailView = [arrayDetailView objectAtIndex:(i+1)];
            }
            if (preImageDetailView) {
                if (preImageDetailView.requestBigImage.loadingData==NO) {
                    [preImageDetailView loadImageFromID:preImageDetailView.currentImageId url:preImageDetailView.currentUrl];
                }
            }
            if (nextImageDetailView) {
                if (nextImageDetailView.requestBigImage.loadingData==NO) {
                    [nextImageDetailView loadImageFromID:nextImageDetailView.currentImageId url:nextImageDetailView.currentUrl];
                }
            }

        }
               
    }
}
#pragma mark DetailImage Delegate
-(void)closeView
{
//    if ([VIVUtilities isIpadDevice]) {
//        [self.delegate  rePresentPopOver];
//    }  
//    NSLog(@"start closeView");
    for (int i =0; i< [arrayDetailView count]; i++) {
        DetailImageViewController *imageViewController = [arrayDetailView objectAtIndex:(i)];
        if (imageViewController.requestBigImage.loadingData==YES) {
            [imageViewController.requestBigImage cancelDownloadProvider];
        }
        if (imageViewController.view.superview == scrollView) {
//            NSLog(@"MI TOM:%i",imageViewController.view.retainCount);
            [imageViewController.view removeFromSuperview];
        }
        
    }

//    NSLog(@"closeView middle");
    if ([VIVUtilities isIpadDevice]) {
//       [self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:^{
            if ([VIVUtilities isIpadDevice]) {
                [self.delegate  rePresentPopOver];
            }  
        } ];
    }else {
        [self dismissModalViewControllerAnimated:YES];
    }
//    
    
    
}
-(void) loadPreImage:(NSString *)Id
{
    
}
-(void) loadNextImage:(NSString *)Id
{
    
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
//     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rotatePhotosScrollView) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
//    [self.scrollView setBackgroundColor:[UIColor yellowColor]];
//    [self.view setAutoresizingMask:UIViewAutoresizingNone];
    self.scrollView.pagingEnabled = YES;
//    self addObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rotatePhotosScrollView) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}
-(void) rotatePhotosScrollView
{
    CGPoint point = scrollView.contentOffset;
    NSInteger index = (int)(point.x /[VIVUtilities getSizeDevice].width);
    currentIndex = index;
    CGFloat w =0;
    CGFloat h =0;
    for (int i =0; i< [arrayDetailView count]; i++) {
        DetailImageViewController *imageViewController = [arrayDetailView objectAtIndex:(i)];
        
        
        CGRect frame = imageViewController.view.frame;
        frame.size =[VIVUtilities getSizeDevice];
        w += frame.size.width;
        h  =frame.size.height;
        frame.origin.x = i*frame.size.width;
        [imageViewController.view setFrame:frame];
        CGRect frameSpin = imageViewController.spiner.frame;
        frameSpin.origin.x = imageViewController.view.frame.size.width/2-frameSpin.size.width/2;
        frameSpin.origin.y  = imageViewController.view.frame.size.height/2-frameSpin.size.height/2;
        //        NSLog(@"imageViewController %@",NSStringFromCGRect(imageViewController.view.frame));
        //        NSLog(@"imageViewController.spiner %@",NSStringFromCGRect(imageViewController.spiner.frame));
        [imageViewController.spiner setFrame:frameSpin];
        
        
    }
    
    [scrollView setContentSize:CGSizeMake(w, h)];
    CGPoint point12 = CGPointMake(((currentIndex)*[VIVUtilities getSizeDevice].width), 0);
    [scrollView setContentOffset:point12];
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGPoint point = scrollView.contentOffset;
    NSInteger index = (int)(point.x /[VIVUtilities getSizeDevice].width);
    currentIndex = index;
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
//    CGPoint point = scrollView.contentOffset;
//    NSInteger index = (int)(point.x /[VIVUtilities getSizeDevice].width);
//    NSLog(@"%d",index);
//    if ([VIVUtilities isIpadDevice]) {
//        index = (int)(point.x /[VIVUtilities getSizeIpad].width);
//    }
 
   
    CGFloat w =0;
    CGFloat h =0;
    for (int i =0; i< [arrayDetailView count]; i++) {
        DetailImageViewController *imageViewController = [arrayDetailView objectAtIndex:(i)];
        

        CGRect frame = imageViewController.view.frame;
        frame.size =[VIVUtilities getSizeDevice];
        w += frame.size.width;
        h  =frame.size.height;
        frame.origin.x = i*frame.size.width;
        [imageViewController.view setFrame:frame];
        CGRect frameSpin = imageViewController.spiner.frame;
        frameSpin.origin.x = imageViewController.view.frame.size.width/2-frameSpin.size.width/2;
        frameSpin.origin.y  = imageViewController.view.frame.size.height/2-frameSpin.size.height/2;
//        NSLog(@"imageViewController %@",NSStringFromCGRect(imageViewController.view.frame));
//        NSLog(@"imageViewController.spiner %@",NSStringFromCGRect(imageViewController.spiner.frame));
        [imageViewController.spiner setFrame:frameSpin];
        

    }

    [scrollView setContentSize:CGSizeMake(w, h)];
    CGPoint point = CGPointMake(((currentIndex)*[VIVUtilities getSizeDevice].width), 0);
    [scrollView setContentOffset:point];
    


    
    
}
@end
