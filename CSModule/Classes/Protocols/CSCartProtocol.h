//
//  CSCartProtocol.h
//  Pods
//
//  Created by hcs on 2020/10/12.
//

@class UIViewController;
@protocol CSCartProtocol <NSObject>

- (NSUInteger)countForGoodsId:(NSString *)goodsId;

- (UIViewController *)createCartViewController;

@end
