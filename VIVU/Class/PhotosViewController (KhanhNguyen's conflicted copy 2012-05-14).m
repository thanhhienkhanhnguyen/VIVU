//
//  PhotosViewController.m
//  VIVU
//
//  Created by MacPro on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define FLEXIBLE_SPACE               10
#define WIDTH_IMAGE                  60

#import "PhotosViewController.h"
#import "VIVUtilities.h"
#import "CustomeButton.h"

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

-(void)dealloc
{
    delegate =nil;
    [arrayPhotos release];
    [scrollView release];
    numberPhotos =0;
    [photosView release];
    [super dealloc];
}


-(IBAction)closeView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
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
        self.photosView = [[PhotosScrollViewController alloc]initWithNibName:@"PhotosScrollViewControllerIpad" bundle:nil];
    }
    photosView.arrayPhotos = arrayPhotos;
    photosView.currentPhotoId = ((CustomeButton*)sender).imageId;
    photosView.modalPresentationStyle = UIModalPresentationFullScreen;
    photosView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
   
    [self.delegate loadDetailPhotos:photosView];
}
-(void)createBasicViewPhotos
{
    if ([arrayPhotos count]>4) {
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
                frame = CGRectMake(20+(j-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), 10+ i*(FLEXIBLE_SPACE+WIDTH_IMAGE), WIDTH_IMAGE, WIDTH_IMAGE);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
}

@end
