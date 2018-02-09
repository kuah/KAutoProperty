//
//  KRunTime.h
//
//  Created by 陈世翰 on 16/9/9.
//  Copyright © 2016年 Kuah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

typedef NS_OPTIONS(NSUInteger,KPropertyOption) {
    KPropertyOptionUnknown = 1<<0,
    KPropertyOptionID = 1<<1,//id 类型
    KPropertyOptionInheritedNSObject = 1 << 2,
    KPropertyOptionNotObject = 1<<3,
    
    KPropertyOptionInt = 1<<11 | KPropertyOptionNotObject,
    KPropertyOptionShort = 1<<12 | KPropertyOptionNotObject,
    KPropertyOptionLong = 1<<13 | KPropertyOptionNotObject,
    KPropertyOptionLongLong = 1<<14 | KPropertyOptionNotObject,
    KPropertyOptionFloat = 1<<15 | KPropertyOptionNotObject,
    KPropertyOptionDouble = 1<<16 | KPropertyOptionNotObject,
    KPropertyOptionBOOL = 1<<17 | KPropertyOptionNotObject,
    
    KPropertyOptionNSInteger = 1<<28 | KPropertyOptionNotObject,
    KPropertyOptionNSUInteger = 1<<29 | KPropertyOptionNotObject,
    
    KPropertyOptionCGFloat = KPropertyOptionDouble,

    KPropertyOptionNSString = 1<<58 | KPropertyOptionInheritedNSObject,
    KPropertyOptionNSNumber = 1<<59| KPropertyOptionInheritedNSObject,
    KPropertyOptionNSDate = 1<<60 | KPropertyOptionInheritedNSObject,
    KPropertyOptionNSDictionary = 1<<61 | KPropertyOptionInheritedNSObject,
    KPropertyOptionNSMutableDictionary = 1<<62 | KPropertyOptionInheritedNSObject,
    KPropertyOptionNSArray = 1<<63 | KPropertyOptionInheritedNSObject,
    KPropertyOptionNSMutableArray = 1<<64 | KPropertyOptionInheritedNSObject,
};

@interface KRunTime : NSObject
/**
 *  @brief 获取一个类的所有类方法
 *  @param cls ~>类
 *  @param outCount ~> 一个method里面包含着多个method，所以输出数目，可以用于遍历一个method的里面的method
 *  @return 一组方法 （可能里面有多个）
 */
+(Method *)k_getClassMethodsByClass:(Class)cls outCount:(unsigned int *)outCount;
/**
 *  @brief 获取一个类的所有对象方法
 *  @param cls ~> 类
 *  @param outCount ~> 一个method里面包含着多个method，所以输出数目，可以用于遍历一个method的里面的method
 *  @return 一组方法 （可能里面有多个）
 */
+(Method *)k_getInstanceMethodsByClass:(Class)cls outCount:(unsigned int *)outCount;
/**
 *  @brief 获取一个类的所有类方法的名称
 *  @param cls ~> 类
 *  @return 一组字符串 ~>名称
 */
+(NSArray *)k_getClassMethodsNamesByClass:(Class)cls;
/**
 *  @brief 获取一个类的所有对象方法的名称
 *  @param cls ~> 类
 *  @return 一组字符串 ~>名称
 */
+(NSArray *)k_getInstanceMethodsNamesByClass:(Class)cls;
/**
 *  @brief 将method 转成SEL（SEL相当于一个名字，有了target才能确切是什么东西）
 *  @param method 方法
 *  @return 方法名
 */
+(SEL)k_method_getName:(Method)method;
/**
 *  @brief 判断selector是不是cls的类方法
 *  @param cls ~>  类
 *  @param selector ~> SEL类型的方法名
 *  @return YES/NO
 */
+(BOOL)k_isMacth_Class:(Class)cls classMethod:(SEL)selector;
/**
 *  @brief 判断selector是不是cls的对象方法
 *  @param cls ~>  类
 *  @param selector ~> SEL类型的方法名
 *  @return YES/NO
 */
+(BOOL)k_isMacth_Class:(Class)cls instanceMethod:(SEL)selector;
/**
 *  @brief 获取一个运行时属性的类名
 *  @param prop 属性
 *  @return 类型名
 */
+(NSString *)k_prop_getTypeName:(objc_property_t)prop;
/**
 *  @brief 获取一个运行时属性的属性名
 *  @param prop 属性
 *  @return 属性名
 */
+(NSString *)k_prop_getName:(objc_property_t)prop;
/**
 *  @brief 扫描实现了该protocol的类的类名列表
 *  @param aProtocol 代理
 *  @return 类名列表
 */
+(NSArray *)k_scanWithProtocol:(Protocol *)aProtocol;
/**
 *  @brief 获取一个类的所有子类
 *  @param superClass 父类
 *  @return 所有子类
 */
+(NSArray *)k_getAllSubClass:(Class)superClass;

/**
 *  @brief 解析属性
 *  @param property 属性
 *  @param readOnly 只读属性 *
 *  @param computed computed
 *  @param getterName getter方法名
 *  @param setterName setter方法名
 *  @param rawType rawType 类型，代理描述
 */
+ (void)k_parseObjcProperty:(objc_property_t)property
                 readOnly:(bool *)readOnly
                 computed:(bool *)computed
               getterName:(NSString **)getterName
               setterName:(NSString **)setterName
                  rawType:(NSString **)rawType;

/**
 *  @brief 解析属性
 *  @param property 属性
 *  @param readOnly 只读属性 *
 *  @param computed computed
 *  @param getterName getter方法名
 *  @param setterName setter方法名
 *  @param clsName 类名
 *  @param delegates 代理
 *  @param propName 属性名
 *  @param propOption 属性类型的归属
 *  @param rawType rawType 类型，代理描述
 */
+ (void)k_parseObjcProperty:(objc_property_t)property
                   readOnly:(bool *)readOnly
                   computed:(bool *)computed
                 getterName:(NSString **)getterName
                 setterName:(NSString **)setterName
                    clsName:(NSString **)clsName
                  delegates:(NSArray **)delegates
                   propName:(NSString **)propName
                 propOption:(KPropertyOption *)propOption
                    rawType:(NSString **)rawType;

@end
