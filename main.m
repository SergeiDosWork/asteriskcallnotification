//
//  main.m
//  AsteriskNotifyClient
//
//  Created by mike walder on 23.03.08.
//  Copyright 2008 allink GmbH. All rights reserved.
//


#import <AppNotifyServer.h>
#import <Cocoa/Cocoa.h>
#import <NotificationClientApplication.h>

int main(int argc, const char *argv[])
{
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[NotificationClientApplication sharedApplication];
	[pool release];
	[NSApp run];
	
	return 1;
}
