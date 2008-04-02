//
//  NotificationClientApplication.h
//  AsteriskNotifyClient
//
//  Created by mike walder on 23.03.08.
//  Copyright 2008 allink GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppNotifyServer.h>

@interface NotificationClientApplication : NSApplication {
	AppNotifyServer *server;
}

@end
