
#import <Cocoa/Cocoa.h>
#import <Growl/GrowlApplicationBridge.h>



@interface GrowlController : NSObject {
	NSURLConnection *addresSearchConnection;
}
	-(void) handleNumber:(NSString*)callerNumber extension:(NSString*)extension;
	-(void)showMessage:(NSString*)title desc:(NSString*)desc image:(NSData*)image;
	
@end
