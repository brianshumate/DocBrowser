//
//  PhoneGap ! DocBrowserCommand
//
//
//  Created by Brian Shumate
//  based on code by Jesse MacFadyen and Giacomo Balli
//

#import <Foundation/Foundation.h>
#ifdef PHONEGAP_FRAMEWORK
	#import <PhoneGap/PGPlugin.h>
#else
	#import "PGPlugin.h"
#endif
#import "DocBrowserViewController.h"



@interface DocBrowserCommand : PhoneGapCommand<DocBrowserDelegate>  {

	DocBrowserViewController* DocBrowser;
}

@property (nonatomic, retain) DocBrowserViewController *DocBrowser;


- (void) showWebPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
-(void) onChildLocationChange:(NSString*)newLoc;

@end