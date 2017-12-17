//
//  VDLogger.h
//  VDCommon
//
//  Created by Vladimir on 11/20/15.
//  Copyright (c) 2017 Vlad. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Log macros

//log level
#define VD_LOG_LEVEL_NONE 0
#define VD_LOG_LEVEL_ERRORS 1
#define VD_LOG_LEVEL_WARNINGS 2
#define VD_LOG_LEVEL_INFO 3
#define VD_LOG_LEVEL_ALL 4

#define VD_LOG_LEVEL VD_LOG_LEVEL_ALL

//log style
#define VD_LOG_STYLE_NONE 0
#define VD_LOG_STYLE_XCODE 1
#define VD_LOG_STYLE_XCODE_AND_FUNCTION 2
#define VD_LOG_STYLE_SHORT_TIME 10
#define VD_LOG_STYLE_FULL 12

#define VD_LOG_STYLE VD_LOG_STYLE_FULL

//log tags values
#define XLG_ALL @"ALL"
#define XLG_MDL @"MDL" //general model
#define XLG_NTW @"NTW" //general network
#define XLG_UI	@"UI" //general UI


#define VDXLG(tagStr, fmt, ...)		do {} while (0)
#define VDWRN(fmt, ...)			do {} while (0)
#define VDINF(fmt, ...)			do {} while (0)
#define VDERR(fmt, ...)         do {} while (0)
#define NSLog(fmt, ...)         do {} while (0)

#if VD_LOG_LEVEL >= VD_LOG_LEVEL_ALL
	#undef VDXLG
	#if VD_LOG_STYLE == VD_LOG_STYLE_XCODE_AND_FUNCTION
		#define VDXLG(tag, fmt, ...)      VDNSLog(tag, (@"%s\n✅" fmt@"\n"),  __FUNCTION__, ##__VA_ARGS__)
	#elif VD_LOG_STYLE == VD_LOG_STYLE_SHORT_TIME
		#define VDXLG(tag, fmt, ...)      VDFLog(tag, (@"✅(%@): " fmt), loggerCurrentTime(), ##__VA_ARGS__)
	#elif VD_LOG_STYLE == VD_LOG_STYLE_FULL
		#define VDXLG(tag, fmt, ...)      VDFLog(tag, (@"\t%@ %s\n✅ " fmt@"\n\n"),  loggerCurrentTime(),  __FUNCTION__, ##__VA_ARGS__)
	#else
		#define VDXLG(tag, fmt, ...)      VDNSLog(tag, (fmt), ##__VA_ARGS__)
	#endif
#endif

#define VDLOG(fmt, ...)	VDXLG(nil, fmt, ##__VA_ARGS__)

#if VD_LOG_LEVEL >= VD_LOG_LEVEL_INFO
	#undef VDINF
	#define VDINF(fmt, ...)       VDFLog(nil, (@"🔷 " fmt@"\n"), ##__VA_ARGS__)
#endif

#if VD_LOG_LEVEL >= VD_LOG_LEVEL_WARNINGS
	#undef VDWRN
	#define VDWRN(fmt, ...)       VDFLog(nil, (@"\t%@ %s\n❗ " fmt@"\n"),  loggerCurrentTime(),  __FUNCTION__, ##__VA_ARGS__)
#endif

#if VD_LOG_LEVEL >= VD_LOG_LEVEL_ERRORS
#undef VDERR
#define VDERR(fmt, ...)       VDFLog(nil, (@"\t%@ %s\n⛔ " fmt@"\n"),  loggerCurrentTime(),  __FUNCTION__, ##__VA_ARGS__)
#endif


NSString * loggerCurrentTime();

void VDFLog(NSString * tagStr, NSString *format, ... );
void VDNSLog(NSString * tagStr, NSString *format, ... );

@interface VDLogger : NSObject

+ (void) setTags:(NSDictionary *)tags;

@end
