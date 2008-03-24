//
//  NotificationClientApplication.h
//  AsteriskNotifyClient
//
//  Created by mike on 23.03.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppNotifyServer.h>

@interface NotificationClientApplication : NSApplication {
	AppNotifyServer *server;
}

@end
