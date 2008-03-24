#import <Foundation/Foundation.h>
#import <AppNotifyServer.h>

int main (int argc, const char * argv[]) {
	printf("call");
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	AppNotifyServer * server = [[AppNotifyServer alloc] init];
	[server startServer];
    //[pool drain];
   // return 0;
}