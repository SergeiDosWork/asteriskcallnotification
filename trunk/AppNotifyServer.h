//
//  AppNotifyServer.h
//  AsteriskNotifyClient
//
//  Created by mike walder on 23.03.08.
//  Copyright 2008 allink GmbH. All rights reserved.
//


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
