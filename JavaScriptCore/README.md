# JavaScriptCore

* iOS 7 引入：封装了JavaScript和Objective-C桥接的Objective-C API
* iOS 7 之前
  * OC 调用 JS：向 UIWebView 发送  `stringByEvaluatingJavaScriptFromString:` 消息执行脚本
  * JS 调用 OC：打开一个自定义的 URL（如：foo://），在 UIWebView 的 delegate 方法 `webView:shouldStartLoadWithRequest:navigationType` 处理
* 可以理解为一个浏览器的运行内核
* 可以使用 native 代码与 js 代码进行相互的调用

### JavaScriptCore 优点

* 不需要依赖 UIWebView
* 使用现代 OC 语法（Blocks 和下标）
* OC 与 JS 无缝传递值或对象
* 创建混合对象（原生对象可以将 JS 值或函数作为一个属性）

### OC 和 JS 结合的好处

* 快速开发和制作原型
* 团队职责划分
* JS 解释型语言
* 多平台

### JavaScriptCore 库文件

* 引入头文件 `#import <JavaScriptCore/JavaScriptCore.h>`
* 头文件引入对象
  * `#import "JSContext.h"`
    * JavaScript 的运行上下文，提供运行环境
    * 所有 JSValue 都是捆绑在一个 JSContext 上的
    * 主要作用：**执行 js 代码**和**注册 native 方法接口**
  * `#import "JSValue.h"`
    * JSContext 执行后的返回结果
    * 任何 js 类型（基本类型、函数类型、对象类型、错误和特殊的 JS 值等）
    * 都有对象的方法转换为 native 对象
  * `#import "JSManagedValue.h"`
    * JSValue 封装
    * 处理内存管理中的一些特殊情形
    * 帮助垃圾回收（js）和引用计数（OC）这两种内存管理机制之间进行正确的转换
    * 解决 js 和原生代码之间循环引用的问题
  * `#import "JSVirtualMachine.h"`
    * 管理 js 运行时
    * 管理 js 暴露的 native 对象的内存
    * 提供底层资源
    * 代表一个对象空间，拥有自己的堆结构和垃圾回收机制
    * 大部分情况不需要直接和它交互（特殊：多线程或内存管理问题）
  * `#import "JSExport.h"`
    * 一个协议
    * 将原生对象导出给 JS，原生对象的属性或方法成为了 JS 的属性或方法

### native 调用 js 代码

* 关键代码：`JSValue *value = [self.jsContext evaluateScript:@"..."]`
* 返回类型`JSValue`
  * 数值类型：`toArray`/`toDictionary`/`toDate`/`toString`/`toNumber`/`toUInt32`/`toObject`等等
  * 函数类型：`jsValue callWithArguments:`方法调用（闭包）
* 三种情况
  * 直接执行代码
  * 执行文件或网络中的 js 代码
  * 注册 js 方法再利用 JSValue 调用

### js 调用 native 代码

* native 注册接口：jsContext[@"方法名"]

  * 后接 Block  

  ```objective-c
  self.jsContext[@"log"] = ^(NSString *msg){
          NSLog(@"js:msg:%@",msg);
      };
  ```

  * 也可使用：`currentArguments`/`currentContext`／`currentCallee`/`currentThis`/`globalObject`
  * Block 内部使用 `currentContext` 避免引用循环

* JSExport 协议

  * 把 objc 复杂对象转换成 JSValue 并暴露给 js 对象

  1. 自定义协议继承自 JSExport，并定义需要暴露给 js 的属性和方法
  2. 新建 native 对象，实现协议
  3. 使用

### 异常处理

```objective-c
//注册js错误处理
- (void)jsExceptionHandler {
    self.jsContext.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        con.exception = exception;
    };
}
```

### JavaScriptCore 和 webView 的结合使用

* UIWebView 获取 JSContext 对象：`JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];`
* WKWebView：<未知>

### JSVirtualMachine

* 创建 JSContext 对象时可传入 JSVirtualMachine 对象，未传入则新建一个

* 作用

  * 支持 js 并发，多个 VM 之间的 js 操作是并发的
  * 使用JSVirtualMachine初始化的多个context，可以共享jsvalue对象
  * 解决循环引用问题


### 内存管理陷阱

*  在 block 内捕获 JSContext：[JSContext currentContext]
*  JSManagedValue
   *  弱引用对象
   *  需要调用JSVirtualMachine的 `addManagedReference:withOwner:`／`removeManagedReference:withOwner:`
*  不要在不同的 JSVirtualMachine 之间进行传递JS对象（垃圾回收）

## 学习资料

* [iOS JavaScriptCore使用](http://liuyanwei.jumppo.com/2016/04/03/iOS-JavaScriptCore.html)
* [JavaScriptCore初探](https://hjgitbook.gitbooks.io/ios/content/04-technical-research/04-javascriptcore-note.html)