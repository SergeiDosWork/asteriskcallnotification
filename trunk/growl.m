//
//  growl.m
//  AsteriskNotifyClient
//
//  Created by mike walder on 23.03.08.
//  Copyright 2008 allink GmbH. All rights reserved.
//


#import <AppNotifyServer.h>
#import <Cocoa/Cocoa.h>
#import <GrowlController.h>

int main(int argc, const char *argv[])
{
	char *msg;
	
	[[NSAutoreleasePool alloc] init];
	GrowlController *gc = [[GrowlController alloc] init];
	msg = argv[1];
	NSString *callerNumber  = [[NSString alloc] initWithUTF8String:strsep(&msg, "|")];
	NSString *cidname  = [[NSString alloc] initWithUTF8String:strsep(&msg, "|")];
	NSString *extension  =  [[NSString alloc] initWithUTF8String:strsep(&msg, "\0")];
	[gc handleNumber: callerNumber extension:extension];
	return 1;
}

