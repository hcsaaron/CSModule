//
//  CSModuleManager.m
//  CSModule
//
//  Created by hcs on 2020/10/12.
//

#import "CSModuleManager.h"

@interface CSModuleManager ()
@property (nonatomic, strong) NSMutableDictionary *protocols;
@end

@implementation CSModuleManager

+ (instancetype)defaultManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)registClass:(Class)class forProtocol:(Protocol *)protocol {
    [[CSModuleManager defaultManager] registClass:class forProtocol:protocol];
}

+ (nullable id)instanceForProtocol:(Protocol *)protocol {
    return [[CSModuleManager defaultManager] instanceForProtocol:protocol];
}

#pragma mark - private
- (NSMutableDictionary *)protocols {
    @synchronized (self) {
        if (!_protocols) {
            _protocols = [[NSMutableDictionary alloc] init];
        }
        return _protocols;
    }
}

- (void)registClass:(Class)class forProtocol:(Protocol *)protocol {
    if (!class || !protocol) {
        return;
    }
    self.protocols[NSStringFromProtocol(protocol)] = class;
}

- (nullable id)instanceForProtocol:(Protocol *)protocol {
    if (!protocol) {
        return nil;
    }
    Class class = self.protocols[NSStringFromProtocol(protocol)];
    id instance = [[class alloc] init];
    if (![instance conformsToProtocol:protocol]) {
        return nil;
    }
    return instance;
}

@end
