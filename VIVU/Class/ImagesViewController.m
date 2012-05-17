//
//  ImagesViewController.m
//  VIVU
//
//  Created by Khanh on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImagesViewController.h"
#import "CustomeButton.h"
#import "VIVUtilities.h"
#import "DetailImageViewController.h"

@interface ImagesViewController ()

@end

@implementation ImagesViewController
@synthesize delegate;
@synthesize arrayPhotos;
@synthesize spiner;

-(void)dealloc
{
    [spiner release];
    delegate = nil;
    [arrayPhotos release];
    [super dealloc];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        arrayPhotos = nil;
        
        spiner =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [spiner setCenter:self.view.center];
        [spiner stopAnimating];
    }
    return self;
}

-(void) configureView
{
    if (arrayPhotos) {
        if ([arrayPhotos count]>0) {
//            NSLog(@"subImages :%d",[arrayPhotos count]);
            NSInteger row = (int)[arrayPhotos count]/4+1;

            for (int i=1; i <=row; i++) {

                for (int j =1; j<= 4; j++) {
                    
                    NSInteger index = (i-1)*4+j-1;
                    if (index >=[arrayPhotos count]) {
                        break;
                    }
                    NSDictionary *dictImage = [arrayPhotos objectAtIndex:index];
//                    NSLog(@"aaaaaa%@",[dictImage objectForKey:@"url"]);
                    
                    NSString *filePath = [NSString stringWithFormat:@"%@/favicon/image/%@.jpg",
                                          [VIVUtilities applicationDocumentsDirectory],
                                          [dictImage objectForKey:@"id"]];
                    
                    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
                    
                    CGRect frame = CGRectMake(10+(j-1)*(FLEXIBLE_SPACE+WIDTH_IMAGE), 10+ i*(FLEXIBLE_SPACE+WIDTH_IMAGE), WIDTH_IMAGE, WIDTH_IMAGE);
                    CustomeButton *btn = [[CustomeButton alloc]initWithFrame:frame];
                    [btn setImage:image forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(showDetailImage:) forControlEvents:UIControlEventTouchUpInside];
                    btn.imageId = [dictImage objectForKey:@"id"];
                    btn.url = [dictImage objectForKey:@"url"];
                    [self.view addSubview:btn];
                    [btn release];
                }
                
                              

                
            }
        }
    }
}
-(void)showDetailImage:(id)sender
{
    
    NSString *imageId = ((CustomeButton *)sender).imageId;
    NSString *url = ((CustomeButton *)sender).url;
    DetailImageViewController *imageViewController = [[DetailImageViewController alloc]initWithNibName:@"DetailImageViewController" bundle:nil];
    imageViewController.delegate = self;
    imageViewController.currentImageId = imageId;
    [imageViewController.view setTag:TAG_DETAIL_VIEW_IMAGE];
    [self.view addSubview:imageViewController.view];
    [self.view bringSubviewToFront:imageViewController.view];
    [imageViewController loadImageFromID:imageId url:url];
    CGRect frame = self.view.frame;
    frame.origin.y =500;
    imageViewController.view.frame = frame;
    [UIView beginAnimations:@"Show Detail Image" context:nil];
    frame.origin.y =0;
    imageViewController.view.frame = frame;
    [UIView commitAnimations];

}
-(IBAction)closeImagesViewController:(id)sender
{
    [self.delegate closeImagesView];
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
#pragma mark DetailImagesView Delegate
-(void)closeView
{
    for (UIView *subView in self.view.subviews)
    {
        UIView *subview = [self.view viewWithTag:TAG_DETAIL_VIEW_IMAGE];
        
        if (subView) {
            [subview removeFromSuperview];
        }
    }
}
-(void)loadPreImage:(NSString *)Id
{
    for (int i=0; i< [arrayPhotos count]; i++) {
        NSDictionary *dictImage = [arrayPhotos objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            if (i>0&&i<([arrayPhotos count]-1)) {
                UIView *subview = [self.view viewWithTag:TAG_DETAIL_VIEW_IMAGE];
                if (subview) {
                    [subview removeFromSuperview];
                }
                break;
            }
        }
    }

    for (int i=1; i< [arrayPhotos count]; i++) {
        NSDictionary *dictImage = [arrayPhotos objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            DetailImageViewController *imageViewController = [[DetailImageViewController alloc]initWithNibName:@"DetailImageViewController" bundle:nil];
            imageViewController.delegate =self;
            [imageViewController.view setTag:TAG_DETAIL_VIEW_IMAGE];
            imageViewController.currentImageId = [dictImage objectForKey:@"id"];
            [self.view addSubview:imageViewController.view];
            [self.view bringSubviewToFront:imageViewController.view];
            NSDictionary *preDictImage = [arrayPhotos objectAtIndex:(i-1)];
            [imageViewController loadImageFromID:[preDictImage objectForKey:@"id"] url:[preDictImage objectForKey:@"url"]];
            CGRect frame = self.view.frame;
            frame.origin.x =-500;
            imageViewController.view.frame = frame;
            [UIView beginAnimations:@"Show Detail Image" context:nil];
            frame.origin.x =0;
            imageViewController.view.frame = frame;
            [UIView commitAnimations];
        }
    }

}
-(void)loadNextImage:(NSString *)Id
{
    for (int i=0; i< [arrayPhotos count]; i++) {
        NSDictionary *dictImage = [arrayPhotos objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            if (i>0&&i<([arrayPhotos count]-1)) {
                UIView *subview = [self.view viewWithTag:TAG_DETAIL_VIEW_IMAGE];
                if (subview) {
                    [subview removeFromSuperview];
                }
                break;
            }
        }
    }

    for (int i=0; i< [arrayPhotos count]-1; i++) {
        NSDictionary *dictImage = [arrayPhotos objectAtIndex:i];
        if ([[dictImage objectForKey:@"id"] isEqual:Id]) {
            DetailImageViewController *imageViewController = [[DetailImageViewController alloc]initWithNibName:@"DetailImageViewController" bundle:nil];
            imageViewController.delegate =self;
            [imageViewController.view setTag:TAG_DETAIL_VIEW_IMAGE];
            imageViewController.currentImageId = [dictImage objectForKey:@"id"];
            [self.view addSubview:imageViewController.view];
            [self.view bringSubviewToFront:imageViewController.view];
            NSDictionary *preDictImage = [arrayPhotos objectAtIndex:(i+1)];
            [imageViewController loadImageFromID:[preDictImage objectForKey:@"id"] url:[preDictImage objectForKey:@"url"]];
            CGRect frame = self.view.frame;
            frame.origin.x =500;
            imageViewController.view.frame = frame;
            [UIView beginAnimations:@"Show Detail Image" context:nil];
            frame.origin.x =0;
            imageViewController.view.frame = frame;
            [UIView commitAnimations];
        }
    }

}
@end
