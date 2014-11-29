//
//  JUUserDefaults.m
//  JiangnanUniversity
//
//  Created by chen wei on 13-4-17.
//  Copyright (c) 2013年 chen wei. All rights reserved.
//

#import "JUUserDefaults.h"
#import "Toolkit.h"
#import "UIColor-Expanded.h"
static JUUserDefaults *userDefaultsInstance = nil;

@interface JUUserDefaults()
@property(nonatomic, assign)NSUserDefaults *defaults;
@property(nonatomic, retain)NSDictionary *constantSetting;
@property(nonatomic, retain)NSDictionary *skinColors;
@end


@implementation JUUserDefaults
@synthesize defaults, constantSetting, skinColors;

+ (JUUserDefaults *)instance {
	@synchronized(self) {
		if (userDefaultsInstance == nil) {
			userDefaultsInstance = [[self alloc] init];
		}
	}
	return userDefaultsInstance;
}


- (id)init {
	if (self = [super init]) {
        // Custom initialization
		defaults = [NSUserDefaults standardUserDefaults];
		
		self.constantSetting = [NSDictionary dictionaryWithContentsOfFile:ResourcePath(@"constantSetting.plist")];
		NSFileManager *manager = [NSFileManager defaultManager];
		if (nil != self.skinBundle &&
			[manager fileExistsAtPath:ResourcePath([self.skinBundle stringByAppendingString:@"/ColorSetting.plist"])]) {
			
			self.skinColors = [NSDictionary dictionaryWithContentsOfFile:
                               ResourcePath([self.skinBundle stringByAppendingString:@"/ColorSetting.plist"])];
		} else {
			self.skinColors = [NSDictionary dictionaryWithContentsOfFile:
                               ResourcePath([NSString stringWithFormat:@"wowtrip.bundle/ColorSetting.plist"])];
		}
    }
    return self;
}

- (void)dealloc {
	self.skinColors = nil;
	self.constantSetting = nil;
	[super dealloc];
}

//应用的中文名称
- (NSString*) appName {
	NSDictionary* plistInfo = [NSDictionary dictionaryWithContentsOfFile:ResourcePath(@"Info.plist")];
	
	return [plistInfo objectForKey:@"CFBundleDisplayName"];
}

//应用的版本号
- (NSString*) appVersion {
	NSDictionary* plistInfo = [NSDictionary dictionaryWithContentsOfFile:ResourcePath(@"Info.plist")];
	
	return [plistInfo objectForKey:@"CFBundleVersion"];
}

- (NSString*) skinBundle {
	NSString* skinName = [defaults stringForKey:@"skinBundle"];
	if (nil != skinName) {
		return skinName;
	} if (nil != constantSetting) {
		if ([[constantSetting objectForKey:@"Skins"] count] > 0) {
			return [[constantSetting objectForKey:@"Skins"] objectAtIndex:0];
		}
	}
	return nil;
}

- (void) setSkinBundle:(NSString*)skinBundle {
	[defaults setObject:skinBundle forKey:@"skinBundle"];
	[defaults synchronize];
	
	[skinColors release];skinColors=nil;
	skinColors = [NSDictionary dictionaryWithContentsOfFile:
				  ResourcePath([skinBundle stringByAppendingString:@"/ColorSetting.plist"])];
}

- (UIColor*) tintColor {
	return [self getColorByColorKey:@"tint_color"];
}

- (UIColor*) getColorByColorKey:(NSString*) colorKey {
	if (nil == [skinColors objectForKey:colorKey]) {
		NSRange range = [colorKey rangeOfString:@"_0x"];
		if (range.length > 0) {
			return [UIColor colorWithHexString:[colorKey substringFromIndex:range.location+1]];
		}
	}
	return [UIColor colorWithRGBHex:[[self.skinColors objectForKey:colorKey] intValue]];
}
@end
