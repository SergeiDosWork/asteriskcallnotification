//
//  GrowlController.m
//  AsteriskNotifyClient
//
//  Created by mike walder on 23.03.08.
//  Copyright 2008 allink GmbH. All rights reserved.
//

#import "GrowlController.h"
#import <PubSub/PSClient.h>
#import <PubSub/PSEntry.h>
#import <PubSub/PSFeed.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBook/ABSearchElement.h>
#import <AddressBook/ABPerson.h>
#import <AddressBook/ABImageLoading.h>

@implementation GrowlController

-(void) handleNumber:(NSString*)callerNumber extension:(NSString*)extension;{
	NSString *prefix;
	if([callerNumber length] > 1){
		prefix  = [callerNumber substringWithRange:NSMakeRange(0, 1)];
	}
	else{
		callerNumber = @"";
	}
	NSString *number;
	if([prefix isEqualToString: @"0"]){
		number = [callerNumber substringWithRange:NSMakeRange(1, [callerNumber length]-1)];
	}
	else{
		number = callerNumber;
	}
	ABAddressBook *adressBook = [ABAddressBook sharedAddressBook];
	NSArray *contacts = [adressBook people];
	unsigned i;
	int count = [contacts count];
	ABPerson *displayContact = nil;
	NSString *label = nil;
	for(i = 0; i < count; i++){
		ABPerson *person = [contacts objectAtIndex: i];
		ABMultiValue *phoneNumbers = [person valueForProperty:kABPhoneProperty];
		unsigned j;
		for(j = 0; j < [phoneNumbers count]; j++){
			NSString *phoneNumber = [phoneNumbers valueAtIndex:j];
			NSString *searchNumber = [[NSString alloc] initWithString:phoneNumber];
			//remove whitespaces from string
			while([searchNumber rangeOfString:@" "].location != NSNotFound){
				searchNumber = [searchNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
			}
			if([searchNumber rangeOfString: number].location != NSNotFound){
					label = ABCopyLocalizedPropertyOrLabel([phoneNumbers labelAtIndex:j]);
					NSLog([person valueForProperty:kABFirstNameProperty]);
					displayContact = person;
			}
		}
		if(displayContact != nil){
			break;
		}
	}
	//ABSearchElement *search = [ABPerson searchElementForProperty: kABPhoneProperty label:nil key:nil value:number comparison:kABContainsSubStringCaseInsensitive];
	//NSArray *entries = [adressBook recordsMatchingSearchElement: search];
	NSString *title;
	NSData *image = [NSData data];
	//NSArray *entries = [[NSArray alloc] init];
	if(displayContact){
		NSLog(@"Addressbook");
		image = [displayContact imageData];
		title = [displayContact valueForProperty:kABOrganizationProperty];
		if(!title){
			NSString *firstName = [displayContact valueForProperty:kABFirstNameProperty];
			NSString *lastName = [displayContact valueForProperty:kABLastNameProperty];
			title = [firstName stringByAppendingString: @" "];
			if(lastName){
				title = [title stringByAppendingString: lastName];
			}
		}
		else{
				title = [title stringByAppendingString: @" ("];
				title = [title stringByAppendingString: label];
				title = [title stringByAppendingString: @")"];
		}
	}
	else{
		NSLog(@"web Search");
		//conduct web search via tel.search.ch
		NSString *baseURLTemplate = @"http://tel.search.ch/api/?maxnum=1&was=";
		NSString *urlString = [baseURLTemplate stringByAppendingString: callerNumber];
		NSURL *urlObj = [NSURL URLWithString: urlString];
		NSURLRequest *theRequest= [NSURLRequest requestWithURL: urlObj
					cachePolicy:NSURLRequestUseProtocolCachePolicy
                    timeoutInterval:5.0];
		NSData *receivedData;	
		receivedData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
		if(receivedData){
			PSFeed   *feed   = [[PSFeed alloc] initWithData: receivedData URL: urlObj];
			NSEnumerator *entries = [feed entryEnumeratorSortedBy: nil];
			PSEntry *entry;
			entry = [entries nextObject];
			title = entry.title;
		}
		else{
			title = callerNumber;
		}
		if(!title){
			title = callerNumber;
		}
		if([title isEqualToString: @""]){
			title = NSLocalizedStringFromTable(@"ANONYMOUS", @"InfoPlist", @"Comment");
		}
	}
	NSString *extBase = NSLocalizedStringFromTable(@"CALL_FOR", @"InfoPlist", @"Comment");
	extBase = [extBase stringByAppendingString: @" "];
	extBase = [extBase stringByAppendingString: extension];
	[self showMessage:title desc:extBase image:image];
	}
-(void)showMessage:(NSString*)title desc:(NSString*)desc image:(NSData*)image{

	[GrowlApplicationBridge setGrowlDelegate:@""];
		[GrowlApplicationBridge
	notifyWithTitle:title
	description:desc
	notificationName:@"CallNotify"
	iconData:image
	priority:1
	isSticky:false
	clickContext:nil];
	}
	
	- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
		NSLog(@"error");
	}
	- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
		NSLog(@"response");
	}
	
	- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
		NSLog(@"call");
	}
	- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
		NSLog(@"data");
	}
@end
