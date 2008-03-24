
#import <AppKit/AppKit.h>
#include <sys/socket.h>
#import <Growl/GrowlApplicationBridge.h>
#import <GrowlController.h>

@interface AppNotifyServer : NSObject  {
	GrowlController *growlController;
}
- (void)startServer;
-(void)serverPolling:(id) NSObject;
@end
