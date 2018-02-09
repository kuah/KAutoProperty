//
//  KRunTime.m
//
//  Created by 陈世翰 on 16/9/9.
//  Copyright © 2016年 Kuah. All rights reserved.
//

#import "KRunTime.h"

@implementation KRunTime
+(Method *)k_getClassMethodsByClass:(Class)cls outCount:(unsigned int *)outCount{
     Method *methods = class_copyMethodList(object_getClass(cls),outCount);
    return methods;
}
+(Method *)k_getInstanceMethodsByClass:(Class)cls outCount:(unsigned int *)outCount{
    Method *methods = class_copyMethodList(cls,outCount);
    return methods;
}
+(SEL)k_method_getName:(Method)method{
    return method_getName(method);
}
+(NSArray *)k_getClassMethodsNamesByClass:(Class)cls{
    NSMutableArray *resultArray = [NSMutableArray array];
    unsigned int count;
    Method *methods = [[self class] k_getClassMethodsByClass:cls outCount:&count];
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = [[self class] k_method_getName:method];
        NSString *name = NSStringFromSelector(selector);
        [resultArray addObject:name];
    }
    return resultArray;
}
+(NSArray *)k_getInstanceMethodsNamesByClass:(Class)cls{
    NSMutableArray *resultArray = [NSMutableArray array];
    unsigned int count;
    Method *methods = [[self class] k_getInstanceMethodsByClass:cls outCount:&count];
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = [[self class] k_method_getName:method];
        NSString *name = NSStringFromSelector(selector);
        [resultArray addObject:name];
    }
    return resultArray;
}
+(BOOL)k_isMacth_Class:(Class)cls classMethod:(SEL)selector{
    return class_respondsToSelector(cls,selector);
}
+(BOOL)k_isMacth_Class:(Class)cls instanceMethod:(SEL)selector{
    return  class_respondsToSelector(object_getClass(cls),selector);
}
+(NSString *)k_prop_getName:(objc_property_t)prop{
     return [[NSString alloc] initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
}
+(NSString *)k_prop_getTypeName:(objc_property_t)prop{
    // 这一段代码用于从描述属性的字符串中获取到类型，用到了正则和字串处理
    NSString *propAttrs = [[NSString alloc] initWithCString:property_getAttributes(prop) encoding:NSUTF8StringEncoding];
    NSRange range = [propAttrs rangeOfString:@"@\".*\"" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        range.location += 2;
        range.length -= 3;
        return [propAttrs substringWithRange:range];
    }else{
        return nil;
    }
}
+(NSArray *)k_scanWithProtocol:(Protocol *)aProtocol{
    NSMutableArray *result  = [NSMutableArray array];
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL,0);
    if (numClasses >0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            if (class_conformsToProtocol(classes[i],aProtocol)) {//因为这个运行时的方法仅仅只能检查当前类是否实现了协议，和父类无关,只有实体对象方法conformsToProtocol才能获知自身或父类有没有实现该协议
                [result addObject:NSStringFromClass(classes[i])];
                [result  addObjectsFromArray:[self k_getAllSubClass:classes[i]]];//获取所有子类
            }
        }
        free(classes);
    }
    return result;
}
/**
 *  @brief 获取一个类的所有子类
 *  @param parentClass 父类
 *  @return 所有子类
 */
+(NSArray *)k_getAllSubClass:(Class)parentClass{
    
    int numClasses = objc_getClassList(NULL, 0);
    
    Class *classes = NULL;
    
    NSMutableArray *result = [NSMutableArray array];
    if (numClasses>0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (NSInteger i = 0; i < numClasses; i++) {
            
            Class superClass = classes[i];
            
            do{
                
                superClass = class_getSuperclass(superClass);
                
            } while(superClass && superClass != parentClass);
            
            if (superClass == nil) {
                
                continue;
                
            }
            
            [result addObject:NSStringFromClass(classes[i])];
            
        }
    }
    free(classes);
    return result;
}

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
                  rawType:(NSString **)rawType {
    unsigned int count;
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &count);
    
    *computed = true;
    for (size_t i = 0; i < count; ++i) {
        switch (*attrs[i].name) {
            case 'T':
                *rawType = @(attrs[i].value);
                break;
            case 'R':
                *readOnly = true;
                break;
            case 'N':
                // nonatomic
                break;
            case 'D':
                // dynamic
                break;
            case 'G':
                *getterName = @(attrs[i].value);
                break;
            case 'S':
                *setterName = @(attrs[i].value);
                break;
            case 'V': // backing ivar name
                *computed = false;
                break;
            default:
                break;
        }
    }
    free(attrs);
}

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
                    rawType:(NSString **)rawType {
    *propName = [KRunTime k_prop_getName:property];
    NSString *rawTypeString;
    NSString *getter;
    NSString *setter;
    bool isReadOnly = false;
    bool isComputed = false;
    KPropertyOption op;
    [KRunTime k_parseObjcProperty:property readOnly:&isReadOnly computed:&isComputed getterName:&getter setterName:&setter rawType:&rawTypeString];
    if ([rawTypeString containsString:@"@\""]) {
        //继承了NSObject的属性的rawType会的格式会是 @"NSArray" ,或是 @"UIView<kap>"
        op = KPropertyOptionInheritedNSObject;
        
        //获取delegate
        if ([rawTypeString containsString:@"<"] && [rawTypeString containsString:@">"]) {
            NSString * handleString = [rawTypeString substringToIndex:rawTypeString.length-2];//减去末尾的 "
            NSArray * array = [handleString componentsSeparatedByString:@">"];
            NSMutableArray * adelegates = [NSMutableArray array];
            for (NSString * str in array) {
                if (str.length==0) continue;
                NSString * delegate = [str substringFromIndex:[str rangeOfString:@"<"].location+1];
                [adelegates addObject:delegate];
            }
            *delegates = adelegates;
            NSString * withoutPre = [rawTypeString substringFromIndex:2];
            NSString * withoutDelegate=[withoutPre substringToIndex:[withoutPre rangeOfString:@"<"].location];
            *clsName = withoutDelegate;
            if (withoutDelegate.length == 0) {
                //id 类型
                op = KPropertyOptionID;
            }else if(adelegates.count>0) {
                //NSObject
                op = KPropertyOptionInheritedNSObject;
            }
        }else{
            //没有delegate
            if ([rawTypeString isEqualToString:@"@\"\""]) {//id类型 为 @""
                op = KPropertyOptionID;
            }else{
                op = KPropertyOptionInheritedNSObject;
            }
            *clsName = [[rawTypeString stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"@" withString:@""];
        }
    }else{
        //非NSObject类型
        op = KPropertyOptionNotObject;
    }
    
    NSLog(@"%@",rawTypeString);
    ////判断常用类型
    const char *code = rawTypeString.UTF8String;
    switch (*code) {
        case 's':  op=op|KPropertyOptionShort; break;
        case 'i':  op=op|KPropertyOptionInt; break; // int
        case 'l':  op=op|KPropertyOptionLong;break; // long
        case 'q':  op=op|KPropertyOptionLongLong;break; // long long
        case 'f':
            op=op|KPropertyOptionFloat;break;
        case 'd':
            op=op|KPropertyOptionDouble;break;
        case 'c':   // BOOL is stored as char - since rlm has no char type this is ok
        case 'B':
            op=op|KPropertyOptionBOOL;break;
        case '@':op = KPropertyOptionID;break;
            break;
        default: ;
    }
    if (strcmp(code, "@\"NSString\"") == 0) {
        op = op|KPropertyOptionNSString;
    }
    if (strcmp(code, "^q") == 0) {
        op = op|KPropertyOptionNSInteger;
    }
    if (strcmp(code, "^Q") == 0) {
        op = op|KPropertyOptionNSUInteger;
    }
    *rawType = rawTypeString;
    *getterName = getter;
    *setterName = setter;
    *readOnly = isReadOnly;
    *computed = isComputed;
    *propOption = op;
}

@end
