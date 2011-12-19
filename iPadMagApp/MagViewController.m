//
//  MagViewController.m
//  iPadMagApp
//
//  Created by preet dhillon on 18/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "MagViewController.h"

@implementation MagViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


/*
 NSURL* pdfFileUrl = [NSURL fileURLWithPath:finalPath];
 CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfFileUrl);
 CGPDFPageRef page;
 
 CGRect aRect = CGRectMake(0, 0, 70, 100); // thumbnail size
 UIGraphicsBeginImageContext(aRect.size);
 CGContextRef context = UIGraphicsGetCurrentContext();
 UIImage* thumbnailImage;
 
 
 NSUInteger totalNum = CGPDFDocumentGetNumberOfPages(pdf);
 
 for(int i = 0; i < totalNum; i++ ) {
 
 
 CGContextSaveGState(context);
 CGContextTranslateCTM(context, 0.0, aRect.size.height);
 CGContextScaleCTM(context, 1.0, -1.0);
 
 CGContextSetGrayFillColor(context, 1.0, 1.0);
 CGContextFillRect(context, aRect);
 
 
 // Grab the first PDF page
 page = CGPDFDocumentGetPage(pdf, i + 1);
 CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, aRect, 0, true);
 // And apply the transform.
 CGContextConcatCTM(context, pdfTransform);
 
 CGContextDrawPDFPage(context, page);
 
 // Create the new UIImage from the context
 thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
 
 //Use thumbnailImage (e.g. drawing, saving it to a file, etc)
 
 CGContextRestoreGState(context);
 
 }
 
 
 UIGraphicsEndImageContext();    
 CGPDFDocumentRelease(pdf);
 */



-(UIImage *)thumbNailImageFromPdfWithName:(NSString *)stringName
{
    NSURL* pdfFileUrl = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.pdf",stringName] withExtension:nil];
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfFileUrl);
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(pdf, 1);
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);
    
    UIGraphicsBeginImageContext(pageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, CGRectGetMinX(pageRect),CGRectGetMaxY(pageRect));
    CGContextScaleCTM(context, 1, -1);  
    CGContextTranslateCTM(context, -(pageRect.origin.x), -(pageRect.origin.y));
    CGContextDrawPDFPage(context, pageRef);
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
    
//    CGPDFPageRef page;
//    
//    CGRect aRect = CGRectMake(0, 0, 200, 368); // thumbnail size
//    UIGraphicsBeginImageContext(aRect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIImage* thumbnailImage;
//    
//    
//    NSUInteger totalNum = CGPDFDocumentGetNumberOfPages(pdf);
//    
//    for(int i = 0; i < totalNum; i++ ) {
//        
//        
//        CGContextSaveGState(context);
//        CGContextTranslateCTM(context, 0.0, aRect.size.height);
//        CGContextScaleCTM(context, 1.0, -1.0);
//        
//        CGContextSetGrayFillColor(context, 1.0, 1.0);
//        CGContextFillRect(context, aRect);
//        
//        
//        // Grab the first PDF page
//        page = CGPDFDocumentGetPage(pdf, i + 1);
//        CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, aRect, 0, true);
//        // And apply the transform.
//        CGContextConcatCTM(context, pdfTransform);
//        
//        CGContextDrawPDFPage(context, page);
//        
//        // Create the new UIImage from the context
//        thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
//        
//        //Use thumbnailImage (e.g. drawing, saving it to a file, etc)
//        
//        CGContextRestoreGState(context);
//        
//    }
//    
//    
//    UIGraphicsEndImageContext();    
//    CGPDFDocumentRelease(pdf);
    
    //return thumbnailImage;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [scrllViewMag setContentSize:CGSizeMake(320+6*200, 748)];
    
    scrllViewMag.pagingEnabled = YES;
    int incX = 320;
    for(int i=0;i<6;i++)
    {
        UIImageView *imageViewPdf = [[UIImageView alloc] initWithFrame:CGRectMake(incX, 200, 100, 368)];
        imageViewPdf.image = [self thumbNailImageFromPdfWithName:@"testJacob-3"];
        [scrllViewMag addSubview:imageViewPdf];
        incX += 200;
//        PDFScrollView *sv = [[PDFScrollView alloc] initWithFrame:CGRectMake(incX, 0, 1024, 768) withName:@"testJacob-3"];
//        [scrllViewMag addSubview:sv];
//        incX += 1024;
    }
	
    //[[self view] addSubview:sv];
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
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
