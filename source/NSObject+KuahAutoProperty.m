//
//  NSObject+KuahAutoProperty.m
//  KAuto
//
//  Created by 陈世翰 on 2018/2/9.
//  Copyright © 2018年 Kuah. All rights reserved.
//

#import "NSObject+KuahAutoProperty.h"
#import <KRunTime/KRunTime.h>

#if __has_include(<YYModel/YYModel.h>) && !__has_include(<YYKit/YYModel.h>)
#import <YYModel/YYModel.h>
#endif
#if !__has_include(<YYModel/YYModel.h>) && __has_include(<YYKit/NSObject+YYModel.h>)
#import <YYKit/NSObject+YYModel.h>
#endif
#if !__has_include("<YYModel/YYModel.h>") && !__has_include(<YYKit/NSObject+YYModel.h>)
#import "NSObject+YYModel.h"
#endif

@implementation NSObject (KuahAutoProperty)
-(void)kap{
    unsigned int propertyCount;
    objc_property_t *props = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t prop = props[i];
        NSString *rawType;
        NSString *getter;
        NSString *setter;
        bool isReadOnly = false;
        bool isComputed = false;
        NSString *clsName;
        NSArray *delegates;
        NSString *propName;
        KPropertyOption op;
        [KRunTime k_parseObjcProperty:prop readOnly:&isReadOnly computed:&isComputed getterName:&getter setterName:&setter clsName:&clsName delegates:&delegates propName:&propName propOption:&op rawType:&rawType];
        Class cls = NSClassFromString(clsName);
        if ([delegates containsObject:@"kap"] && cls) {
            @try{
                
                id object = [[cls alloc] init];
                if (object) {
                    [self modelSetWithJSON:@{propName:object}];
                }
            }@catch (NSException *exception) {
                
            }
        }
    }
}
@end
