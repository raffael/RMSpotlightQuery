//
//  RMSpotlightQuery.m
//  AppSales
//
//  Created by Raffael Hannemann on 16.01.13.
//  Copyright (c) 2013 raffael.me. All rights reserved.
//

#import "RMSpotlightQuery.h"

@implementation RMSpotlightQuery

+ (instancetype) query {
	return [[RMSpotlightQuery alloc] init];
}

+ (instancetype) queryWithDelegate:(id<RMSpotlightQueryDelegate>)delegate {
	RMSpotlightQuery *instance = [[RMSpotlightQuery alloc] init];
	[instance setDelegate:delegate];
	return instance;
}

- (void) query:(NSString *)needle {
	_needle	= needle;
	[self start];
}

- (void) query:(NSString *)needle withOptions:(NSArray *)options {
	_needle = needle;
	_options = options;
	[self start];
}

- (void) queryExactFilename:(NSString *)filename {
	_needle = @"";
	NSMutableArray *tmp = [NSMutableArray arrayWithArray:(_options) ? _options : @[]];
	[tmp addObject:@"name"];
	[tmp addObject:filename];
	_options = tmp;
	[self start];
}

- (void) main {

	/**
	 * Docs for the mdfind tool can be find on
	 * https://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man1/mdfind.1.html
	 */
	
	NSTask *myTask = [[NSTask alloc] init];
    NSData *inData = nil;
    NSPipe *myPipe = [NSPipe pipe];
    NSFileHandle *myHandle = [myPipe fileHandleForReading];

    NSString *output;

	// app to launch
    [myTask setStandardOutput: myPipe];
    [myTask setLaunchPath:@"/usr/bin/mdfind"];

	// app arguments
	NSMutableArray *args = [NSMutableArray array];
	if (_options) [args addObjectsFromArray: _options];
	if (_needle && ![_needle isEqualToString:@""]) [args addObject:_needle];
	[myTask setArguments: args];

	// fire
    [myTask launch];

	// handle output
    inData = [myHandle readDataToEndOfFile];
    output = [[NSString alloc] initWithData: [inData subdataWithRange:NSMakeRange(0, [inData length])]
								   encoding: NSASCIIStringEncoding];

	// remove last results which is an empty line
	NSMutableArray *array = [NSMutableArray arrayWithArray:[output componentsSeparatedByString:@"\n"]];
	if ([array.lastObject isEqualToString:@""])
		[array removeObjectAtIndex:array.count-1];

	// delegate result(s)
	if ([self.delegate respondsToSelector:@selector(spotlightQuery:didFinishWithResult:)])
		[self.delegate spotlightQuery:self didFinishWithResult:array];
}
@end
