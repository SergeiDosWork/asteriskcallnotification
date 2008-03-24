#import "AppNotifyServer.h"
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h> /* exit() */
#include <unistd.h> /* close() */
#include <string.h> /* memset() */
#include <GrowlController.h>

#define LOCAL_SERVER_PORT 40000
#define MAX_MSG 1024


@implementation AppNotifyServer 
	
	int sd, rc, n;
	socklen_t cliLen;
	struct sockaddr_in cliAddr, servAddr;
	char *msg;
	
	- (void)startServer{
			if((sd=socket(AF_INET, SOCK_DGRAM, 0))<0) {
				printf("%s: cannot open socket \n");
			//	exit(1);
			}
			servAddr.sin_family = AF_INET;
			servAddr.sin_addr.s_addr = htonl(INADDR_ANY);
			servAddr.sin_port = htons(LOCAL_SERVER_PORT);
			
			if((rc = bind (sd, (struct sockaddr *) &servAddr,sizeof(servAddr)))<0) {
					printf("%s: cannot  bind to port \n");
					exit(1);
			}
			growlController = [[GrowlController alloc] init];
		//	[growlController showMessage:NSLocalizedStringFromTable(@"GROWL_STARTED", @"InfoPlist", @"Comment") desc:nil image:nil];
			[self performSelectorInBackground:@selector(serverPolling:) withObject:nil];
	}
	-(void)serverPolling:(id) NSObject{
			msg = malloc((size_t)MAX_MSG+1);
			NSLog(@"polling");
			while(1) {
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			cliLen = sizeof(cliAddr);
			if((n = recvfrom(sd, msg, MAX_MSG, 0, (struct sockaddr *)&cliAddr, &cliLen))<0) {
				printf("%s: cannot receive data \n");
			}
			NSString *message;
			message =   [NSString stringWithCString: msg encoding: [NSString defaultCStringEncoding]];
			if(strchr(msg,'|')) {
				//	NSString *cidnum  = [[NSString alloc] initWithUTF8String:strsep(&msg, "|")];
			//	NSString *cidname  = [[NSString alloc] initWithUTF8String:strsep(&msg, "|")];
				message =   [NSString stringWithCString: msg encoding: [NSString defaultCStringEncoding]];
			//	message = [message stringByAppendingString: @"\0"];
				//message = [cidnum stringByAppendingString: @"|"];
				//message = [message stringByAppendingString: cidname];
				//message = [message stringByAppendingString: @"|"];
				//message = [message stringByAppendingString: called];
				//message = [message stringByAppendingString: @"|"];
				NSLog(message);
				NSArray *params = [message componentsSeparatedByString:@"|"];
			//	NSString *callerNumber  = [[NSString alloc] initWithUTF8String:strsep(&msg, "|")];
			//	NSString *cidname  = [[NSString alloc] initWithUTF8String:strsep(&msg, "|")];
			//	NSString *extension  =  [[NSString alloc] initWithUTF8String:strsep(&msg, "\0")];
				NSString *extension = [[params objectAtIndex:2] substringWithRange:NSMakeRange(0, 2)];
				[growlController handleNumber: [params objectAtIndex:0] extension: extension];
			/*
				NSMutableString *binPath=[NSMutableString stringWithFormat:@"%@%@",[[NSBundle mainBundle] executablePath], @"/../growl"];
				growl = [[NSTask alloc] init];
				[growl setLaunchPath:binPath];
				NSMutableArray *arguments = [[NSMutableArray alloc] init];
			//	cidnum = @"0765807091|0|90";
				//[arguments addObject: cidnum];
				[arguments addObject: message];
				[growl setArguments: arguments];
				[growl launch];
				[growl release];
				continue;
				*/
				[pool release];
			}
		}
	}
@end
