//
//  GrowlController.h
//  AsteriskNotifyClient
//
//  Created by mike walder on 23.03.08.
//  Copyright 2008 allink GmbH. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import <Growl/GrowlApplicationBridge.h>



@interface GrowlController : NSObject {
	NSURLConnection *addresSearchConnection;
}
	-(void) handleNumber:(NSString*)callerNumber extension:(NSString*)extension;
	-(void)showMessage:(NSString*)title desc:(NSString*)desc image:(NSData*)image;
	
@end
