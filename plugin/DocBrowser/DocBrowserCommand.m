//
//  PhoneGap ! DocBrowserCommand
//
//
//  Created by Brian Shumate
//  based on code by Jesse MacFadyen and Giacomo Balli
//


#import "DocBrowserCommand.h"

#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PhoneGapViewController.h>

#else
	#import "PhoneGapViewController.h"
#endif

@implementation DocBrowserCommand

@synthesize DocBrowser;

- (void) showDocPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{
	if(DocBrowser == NULL)
	{
		DocBrowser = [[ DocBrowserViewController alloc ] initWithScale:FALSE ];
		DocBrowser.delegate = self;
	}

	/* // TODO: Work in progress
	 NSString* strOrientations = [ options objectForKey:@"supportedOrientations"];
	 NSArray* supportedOrientations = [strOrientations componentsSeparatedByString:@","];
	 */

	PhoneGapViewController* cont = (PhoneGapViewController*)[ super appViewController ];
	DocBrowser.supportedOrientations = cont.supportedOrientations;
	[ cont presentModalViewController:DocBrowser animated:YES ];

	NSString *url = (NSString*) [arguments objectAtIndex:0];


	[DocBrowser loadURL:url  ];

}

-(void) close:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{
	[ DocBrowser closeBrowser];

}

-(void) onClose
{
	NSString* jsCallback = [NSString stringWithFormat:@"DocBrowser._onClose();",@""];
	[ webView stringByEvaluatingJavaScriptFromString:jsCallback];
}

-(void) onOpenInSafari
{
	NSString* jsCallback = [NSString stringWithFormat:@"DocBrowser._onOpenExternal();",@""];
	[ webView stringByEvaluatingJavaScriptFromString:jsCallback];
}


-(void) onChildLocationChange:(NSString*)newLoc
{

	NSString* tempLoc = [NSString stringWithFormat:@"%@",newLoc];
	NSString* encUrl = [tempLoc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSString* jsCallback = [NSString stringWithFormat:@"DocBrowser._onLocationChange('%@');",encUrl];
	[ webView stringByEvaluatingJavaScriptFromString:jsCallback];

}




@end
