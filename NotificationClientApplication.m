//
//  NotificationClientApplication.m
//  AsteriskNotifyClient
//
//  Created by mike walder on 23.03.08.
//  Copyright 2008 allink GmbH. All rights reserved.
//

#import "NotificationClientApplication.h"
#import "AppNotifyServer.h"

@implementation NotificationClientApplication
static NSAutoreleasePool *globalPool = nil;
- (void)resetAutoreleasePool:(NSTimer *)timer
{
	#pragma unused (timer)
	[globalPool release];
	globalPool = [[NSAutoreleasePool alloc] init];
}

- (void)run
{
	@try{
		globalPool = [[NSAutoreleasePool alloc] init];
		
		NSStatusBar *bar = [NSStatusBar systemStatusBar];
		NSStatusItem *theItem = [bar statusItemWithLength:NSVariableStatusItemLength];
		[theItem retain];
		[theItem setTitle: @"a"];
		[theItem setHighlightMode:YES];
		NSMenu *theMenu = [[NSMenu alloc] initWithTitle: @"Stoppen"];
		[theItem setMenu:theMenu];
		NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle: NSLocalizedStringFromTable(@"QUIT_APPLICATION", @"InfoPlist", @"Comment") action:@selector(terminate:) keyEquivalent: @""];
		[menuItem setTarget:self];
		[theMenu addItem:menuItem];
		[menuItem setEnabled:YES];
		
		[[NSTimer scheduledTimerWithTimeInterval:30
										  target:self
										selector:@selector(resetAutoreleasePool:)
										userInfo:nil
										 repeats:YES] retain];
		
		server = [[AppNotifyServer alloc] init];
		[server startServer];
		[super run];
		[globalPool release]; globalPool = nil;
	}
	//TODO: find out why app sometimes crashes after wakeup of OS X, then remove the try catch blocks
	@catch (NSException *theErr)
	{
		NSLog (@"Catching Error");
		NSLog([theErr name]);
		[self run];
	}
}
@end
