# ARC 相关

## @property

* 指令目的：自动生成 `accessor` 方法

* 默认参数 `atomic`/`readwrite`/`assign`

* MRC 参数说明

  * `atomic`：原子操作，用于多线程

    * 缺点：耗费系统资源，没有多线程通讯时不建议使用，且也只是线程安全的一个方面
    * `getter` 和 `setter` 方法要么不定义，要么一起定义

  * `nonatomic`：非原子操作

  * `readonly`／`readwrite`：不会／会生成 `setter` 方法，前者可以通过实例变量在内部修改

  * `assign`：调用 `getter` 返回属性；调用 `setter` 简单赋值，不更改 `retain count`（基础数据类型）

    * 用于 OC 对象时，与 `weak` 类似，但指向对象被销毁后，不会将属性清空

  * `retain`： 调用 `getter` 返回属性；调用 `setter` 指向同一块内存， `retain count` +1（用于 `NSObject` 类型）

  * `copy`：调用 `getter` 返回属性；调用 `setter` 重新分配一块内存将相同的内容复制给属性

    * 用于 `NSObject` 类型，实践中常用于 `NSString` ，需要遵从 `NSCopying` 协议的对象
    * `copy` 后，原值无论如何改变，与新值无关

  * `getter=` 、 `setter=` 

    * 惯例：Boolean 类型的属性 `getter` 方法通常会有 `is` 作为前缀

  * ```objective-c
    - (void)setPerson:(Person *)person {
    	if (_person != person) {
    		[_person release];
    		_person = [person retain];
    	}
    } // retain：指针拷贝
    - (void)setPerson:(Person *)person {
    	if (_person != person) {
    		[_person release];
    		_person = [person copy];
    	}
    } // copy：内容拷贝
    - (void)setPerson:(Person *)person {
    	if (_person != person) {
    		_person = person;
    	}
    } // assign：简单赋值
    ```

* ARC 新增／变更的参数说明

  * `strong`：强引用。拥有关系
  * `weak`：弱引用。非拥有关系
    * 普遍使用场景在父子结构的数据结构中，父持有子的强引用，子持有父的弱引用
  * `unsafe_unretained`：和使用 `weak` 类似，但引用对象销毁时不会自动将 `property` 设置为 `nil` 。使用在不支持 `weak` 属性的环境中。

* 使用 property 的好处：

  * 内存管理：根据参数采用正确的内存管理方法
  * 语法糖
  * 方便生成 `setter`、`getter`
  * 自定义 `setter`、`getter`
  * 方便使用 `KVO`：采用了属性的方式对成员赋值，就会触发 `KVO` ，而无需调用 `willChangeValueForKey` 和 `didChangeValueForKey`

* 注意：64-bit 平台，只需要声明 `@property`

## 内存管理

* 对象拥有关系

### 内存泄漏

* retain cycle：两者相互拥有

## 笔记资料

* [白话Objective-C之Property](http://helloitworks.com/136.html)
* [OC @property 知多少 // Pandara's Zone](http://pandara.xyz/2015/10/09/objc_property/index.html)