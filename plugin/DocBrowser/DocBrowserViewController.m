//
//  DocViewController.m
//
//  Created by Brian Shumate
//  based on code by Jesse MacFadyen and Giacomo Balli
//

#import "DocBrowserViewController.h"


@implementation DocBrowserViewController

@synthesize imageURL;
@synthesize supportedOrientations;
@synthesize isImage;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */


- (DocBrowserViewController*)initWithScale:(BOOL)enabled
{
    self = [super init];


	scaleEnabled = enabled;

	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	webView.delegate = self;
	webView.scalesPageToFit = TRUE;
	webView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {

	webView.delegate = nil;

	[webView release];
	[closeBtn release];
	[refreshBtn release];
	[addressLabel release];
	[backBtn release];
	[fwdBtn release];
	[safariBtn release];
	[spinner release];
	[ supportedOrientations release];
	[super dealloc];
}

-(IBAction) onDoneButtonPress:(id)sender
{
	[ [super parentViewController] dismissModalViewControllerAnimated:YES];
}


-(IBAction) onSafariButtonPress:(id)sender
{
	if(isImage)
	{
		NSURL* pURL = [ [NSURL alloc] initWithString:imageURL ];
		[ [ UIApplication sharedApplication ] openURL:pURL  ];
	}
	else
	{
		NSURLRequest *request = webView.request;
		[[UIApplication sharedApplication] openURL:request.URL];
	}

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation
{
	BOOL iPad = NO;
#ifdef UI_USER_INTERFACE_IDIOM
	iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
	if (iPad) {
		return NO;
	} else {
		return YES;	}
}




- (void)loadURL:(NSString*)url
{
	NSLog(@"Opening Url : %@",url);

	if( [url hasSuffix:@".png" ]  ||
	   [url hasSuffix:@".jpg" ]  ||
	   [url hasSuffix:@".jpeg" ] ||
	   [url hasSuffix:@".bmp" ]  ||
	   [url hasSuffix:@".gif" ]  )
	{
		[ imageURL release ];
		imageURL = [url copy];
		isImage = YES;
		NSString* htmlText = @"<html><body style='background-color:#333;margin:0px;padding:0px;'><img style='min-height:200px;margin:0px;padding:0px;width:100%;height:auto;' alt='' src='IMGSRC'/></body></html>";
		htmlText = [ htmlText stringByReplacingOccurrencesOfString:@"IMGSRC" withString:url ];

		[webView loadHTMLString:htmlText baseURL:[NSURL URLWithString:@""]];

	}
	else
	{
		imageURL = @"";
		isImage = NO;
		//NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
		//[webView loadRequest:request];
		NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"pdf"];
		NSURL *targetURL = [NSURL fileURLWithPath:path];
		NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
		[webView loadRequest:request];
	}
	webView.hidden = NO;
}


- (void)webViewDidStartLoad:(UIWebView *)sender {
	addressLabel.text = @"";
	backBtn.enabled = webView.canGoBack;
	fwdBtn.enabled = webView.canGoForward;

	[ spinner startAnimating ];
}

- (void)webViewDidFinishLoad:(UIWebView *)sender {
	//NSURLRequest *request = webView.request;
	//addressLabel.text = request.URL.absoluteString;
	backBtn.enabled = webView.canGoBack;
	fwdBtn.enabled = webView.canGoForward;
	[ spinner stopAnimating ];


}


@end