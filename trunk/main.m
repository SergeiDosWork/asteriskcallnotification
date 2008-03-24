
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
