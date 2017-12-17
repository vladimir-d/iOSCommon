//
//  VDLogger.m
//  VDCommon
//
//  Created by Vladimir on 11/20/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import "VDLogger.h"
#import "NSDateFormatter+VDCommon.h"


static NSString * const kLogTimeFormat = @"hh:mm:ss.SSS";

static NSDictionary * logTags;

void VDNSLog(NSString * tagStr, NSString *format, ... ){
	if (tagStr ? [logTags[tagStr] boolValue] : TRUE){
		va_list args;
		va_start(args, format);
		NSLogv(format, args);
		va_end(args);
	}
}

void VDFLog (NSString * tagStr, NSString *format, ...) {
	if (tagStr ? [logTags[tagStr] boolValue] : TRUE){
		va_list args;
		va_start(args, format);
		fputs([[[NSString alloc] initWithFormat:format arguments:args] UTF8String], stdout);
		va_end(args);
	}
}


static NSDateFormatter * timeFormatter(){
	static dispatch_once_t predicate;
	static NSDateFormatter * formatter = nil;
	dispatch_once(&predicate, ^{
		formatter = [NSDateFormatter dateFormatterWithFormat:kLogTimeFormat];
	});
	
	return formatter;
}

NSString * loggerCurrentTime(){
	return [timeFormatter() stringFromDate:[NSDate date]];
}

@implementation VDLogger

+ (void) setTags:(NSDictionary *)tags{
	if (tags == nil){
		tags = @{XLG_ALL:@(1)};
	}
	logTags = tags;
}



@end
