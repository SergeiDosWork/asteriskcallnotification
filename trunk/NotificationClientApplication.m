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
	@try{
	[globalPool release];
	globalPool = [[NSAutoreleasePool alloc] init];
					}
				@catch (NSException *theErr)
				{
					NSLog (@"ERROR");
					NSLog([theErr name]);

				}
}

- (void)run
{
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
@end
