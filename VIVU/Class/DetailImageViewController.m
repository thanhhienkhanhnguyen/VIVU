//
//  DetailImageViewController.m
//  VIVU
//
//  Created by Khanh on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailImageViewController.h"
#import "VIVUtilities.h"
#include <QuartzCore/QuartzCore.h>


@implementation SubView

@synthesize delegateSubView;


@end

@interface DetailImageViewController ()

@end

@implementation DetailImageViewController
@synthesize delegate;
@synthesize imageView;
@synthesize requestBigImage;
@synthesize gestureRight;
@synthesize gestureLeft;
@synthesize currentImageId;
@synthesize spiner;
@synthesize currentUrl;
-(void)dealloc
{
    [currentUrl release];
    [spiner release];
    [currentImageId release];
    [gestureLeft release];
    [gestureRight release];
    [requestBigImage release];
    [delegate release];
    [imageView release];
    [super dealloc];
}
//-(void)loadView
//{
//      self.view = [[[SubView alloc]init]autorelease];
//    ((SubView*)self.view).delegate = self;
//}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.gestureLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextImage:)];
        gestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//        [self.view addGestureRecognizer:gestureLeft];
        self.gestureRight =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(preImage:)];
        gestureRight.direction = UISwipeGestureRecognizerDirectionRight;
//        [self.view addGestureRecognizer:gestureRight];
        self.spiner =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        [spiner setCenter:self.view.center];
        CGRect frame = self.view.frame;
        CGPoint point =CGPointMake(frame.size.width/2, frame.size.height/2);
        [spiner setCenter:point];
        [spiner startAnimating];
        [self.view addSubview:spiner];

        
    
    }
    return self;
}
-(void)viewDidLoad
{   
    [super viewDidLoad];
//    ((SubView*)self.view).delegateSubView = self;
//    [self.view setAutoresizingMask:UIViewAutoresizingNone];
//    [self.view setBackgroundColor:[UIColor blueColor]];
//    CGSize size = [VIVUtilities getSizeDevice];
//    CGRect frame = self.view.frame;
//    frame.size = size;
//    [self.view setFrame:frame];
    
}
-(void)callBackToParrentClass:(NSString *)imageID Url:(NSString *)url
{
    [self loadImageFromID:imageID url:url];
}
-(void) nextImage:(NSString*)currentId
{

    [self.delegate loadNextImage:self.currentImageId];
}
-(void) preImage:(NSString*)currentId
{
    [self.delegate loadPreImage:self.currentImageId];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

//   [super touchesBegan:touches withEvent:event];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [super touchesEnded:touches withEvent:event];
}
-(void)loadImageFromID:(NSString *)imageId url:(NSString *)url
{
    NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/bigimage/%@.jpg",
                          [VIVUtilities applicationDocumentsDirectory],
                          imageId];
    self.currentImageId = imageId;
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (image) {
        self.imageView.image = image;
        [spiner stopAnimating];
    }else  {
        
        if (url) {
            if (requestBigImage) {
                requestBigImage.ImagesProfileDelegate = nil;
                [requestBigImage release];
            }
            requestBigImage = [[ImagesProfileProvider alloc]init];
            
            requestBigImage.ImagesProfileDelegate = self;
            requestBigImage.categoryName = imageId;
            requestBigImage.mode = ProviderModeImage;
            if ([url rangeOfString:@"_100x100.jpg"].length>0) {
                url= [url stringByReplacingOccurrencesOfString:@"_100x100.jpg" withString:@".jpg"];
            }
            
            if ([url rangeOfString:@"derived_pix"].length>0) {
                url =[url stringByReplacingOccurrencesOfString:@"derived_pix" withString:@"pix"];
            } 
            [requestBigImage configURLByURL:url];
            [spiner startAnimating];
            [requestBigImage requestData];
            
        }
        
    }
}
-(IBAction)closeImageView:(id)sender;
{
    [self.delegate closeView];
}

#pragma imageProvider delegate
-(void)ImagesProfileProviderDidFinishParsing:(ImagesProfileProvider *)provider
{
    if (provider.mode ==ProviderModeImage) {
        provider.loadingData = NO;
        
        UIImage *image = [UIImage imageWithData:provider.returnData];
        if (!image) {
            //load icon defaul
        }else {
            
            NSString *filePath =[NSString stringWithFormat:@"%@/favicon/image/bigimage/%@.jpg",
                                 [VIVUtilities applicationDocumentsDirectory],
                                 provider.categoryName];
            NSString *dirPath = [VIVUtilities applicationDocumentsDirectory];
            dirPath = [dirPath stringByAppendingString:@"/favicon/image/bigimage"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            BOOL isDirectory;
            if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDirectory])
            {
                NSError *error;
                [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
            }
            if (![fileManager fileExistsAtPath:filePath]) {
                UIImage *image = [UIImage imageWithData:provider.returnData];
                if (image) {
                    if ([provider.returnData writeToFile:filePath atomically:YES]) {
                        NSLog(@"Successful save data:%@", provider.categoryName);
                        //wire to file successful. release cache data
                        //                        [detailViewController reloadImageById:provider.categoryName];
                        [spiner stopAnimating];
                        self.imageView.image = image;
                    
                        provider.returnData = [NSData data];
                    }
                }                
            }

    }
    }
}
-(void)ImagesProfileProviderDidFinishWithError:(NSError *)error provider:(ImagesProfileProvider *)provider
{
    
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
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    
    
}
@end
