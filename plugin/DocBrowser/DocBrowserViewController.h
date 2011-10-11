//
//  DocBrowserViewController.h
//
//  Created by Brian Shumate
//  based on code by Jesse MacFadyen and Giacomo Balli
//

#import <UIKit/UIKit.h>

@protocol DocBrowserDelegate<NSObject>



/*
 *  onChildLocationChanging:newLoc
 *
 *  Discussion:
 *    Invoked when a new page has loaded
 */
-(void) onChildLocationChange:(NSString*)newLoc;
-(void) onOpenInSafari;
-(void) onClose;
@end


@interface DocBrowserViewController : UIViewController < UIWebViewDelegate > {
	IBOutlet UIWebView* webView;
	IBOutlet UIBarButtonItem* closeBtn;
	IBOutlet UIBarButtonItem* refreshBtn;
	IBOutlet UILabel* addressLabel;
	IBOutlet UIBarButtonItem* backBtn;
	IBOutlet UIBarButtonItem* fwdBtn;
	IBOutlet UIBarButtonItem* safariBtn;
	IBOutlet UIActivityIndicatorView* spinner;
	BOOL scaleEnabled;
	BOOL isImage;
	NSString* imageURL;
	NSArray* supportedOrientations;
	id <DocBrowserDelegate> delegate;
}

@property (nonatomic, retain)id <DocBrowserDelegate> delegate;
@property (nonatomic, retain) 	NSArray* supportedOrientations;
@property(retain) NSString* imageURL;
@property(assign) BOOL isImage;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation;
- (DocBrowserViewController*)initWithScale:(BOOL)enabled;
- (IBAction)onDoneButtonPress:(id)sender;
- (IBAction)onSafariButtonPress:(id)sender;
- (void)loadURL:(NSString*)url;
-(void)closeBrowser;

@end