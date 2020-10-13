# CSModule
组件化管理-中间库

## 组件间通信-通过协议通信
组件提供api给其他组件调用，需在CSModule声明protocol及api，并在组件中创建遵循该protocol并实现协议方法，并向CSModuleManager注册实现该protocol的类

## 例子
"商品CSModule_Goods"和"购物车CSModule_Cart"是两个业务组件，商品详情页需要用到购物车的数量，商品详情页有购物车的入口可以直接push出购物车页面，在彼此解耦，互不引用的前提下，如何实现呢？

1) **购物车组件**在**CSModule组件**中声明CSCartProtocol协议，并声明一下两个方法：
```
- (NSUInteger)countForGoodsId:(NSString *)goodsId;  // 获取对应商品加入购物车的数量

- (UIViewController *)createCartViewController; // 创建并返回一个购物车页面的实例
```

2) 同时在**购物车组件**组件创建一个类，遵循CSCartProtocol协议，并实现协议方法，并在+load中向CSModuleManager注册协议实现类：
```
+ (void)load {
    // 内部实现原理是将协议与实现类做一个映射关系保存起来，以便其他组件通过中间件获取另一个组件提供的协议实现者
    [CSModuleManager registClass:self forProtocol:@protocol(CSCartProtocol)];
}
```

3) 在**商品组件**中，需调用**购物车组件**的api时，向CSModuleManager获取对应的协议实现者：
``` 
id<CSCartProtocol> api = [CSModuleManager instanceForProtocol:@protocol(CSCartProtocol)]; // 获取协议实现者

NSUInteger goodsCount = [api countForGoodsId:self.goodsId]; //  获取某商品加入购物车的数量

UIViewController *cartVC = [api createCartViewController];  // 创建并返回一个购物车页面的实例

```
