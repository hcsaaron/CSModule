//
//  CSModuleManager.h
//  CSModule
//
//  Created by hcs on 2020/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSModuleManager : NSObject

+ (void)registClass:(Class)class forProtocol:(Protocol *)protocol;

+ (nullable id)instanceForProtocol:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
