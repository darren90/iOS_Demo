### iOS面试题-集合版02

----

### ----------------------------------第一部分--------------------------------------


1. 什么是 ARC? (ARC 是为了解决什么问题而诞生的?)

ARC 是 Automatic Reference Counting 的缩写, 即自动引用计数. 这是苹果在 iOS5 中引入的内存管理机制. Objective-C 和 Swift 使用 ARC 追踪和管理应用的内存使用. 这一机制使得开发者无需键入 retain 和 release, 这不仅能够降低程序崩溃和内存泄露的风险, 而且可以减少开发者的工作量, 能够大幅度提升程序的流畅性和可预测性. 但是 ARC 不适用于 Core Foundation 框架中, 仍然需要手动管理内存.


2.  以下 keywords 有什么区别: assign vs weak, __block vs __weak
assign 和 weak 是用于在声明属性时, 为属性指定内存管理的语义.

assign 用于简单的赋值, 不改变属性的引用计数, 用于 Objective-C 中的 NSInteger, CGFloat 以及 C 语言中 int, float, double 等数据类型.
weak 用于对象类型, 由于 weak 同样不改变对象的引用计数且不持有对象实例, 当该对象废弃时, 该弱引用自动失效并且被赋值为 nil, 所以它可以用于避免两个强引用产生的循环引用导致内存无法释放的问题.
__block 和 __weak 之间的却是确实极大的, 不过它们都用于修饰变量.

前者用于指明当前声明的变量在被 block 捕获之后, 可以在 block 中改变变量的值. 因为在 block 声明的同时会截获该 block 所使用的全部自动变量的值, 而这些值只在 block 中只具有"使用权"而不具有"修改权". 而 __block 说明符就为 block 提供了变量的修改权.
后者是所有权修饰符, 什么是所有权修饰符? 这里涉及到另一个问题, 因为在 ARC 有效时, id 类型和对象类型同 C 语言中的其他类型不同, 必须附加所有权修饰符. 所有权修饰符一种有 4 种:

	__strong
	__weak
	__unsafe_unretained
	__autorelease
	
__weak 与 weak 的区别只在于, 前者用于变量的声明, 而后者用于属性的声明.

3.  __block 在 ARC 和非 ARC 下含义一样吗？
 
__block 在 ARC 下捕获的变量会被 block retain, 这样可能导致循环引用, 所以必须要使用弱引用才能解决该问题. 而在非 ARC 下, 可以直接使用 __block 说明符修饰变量, 因为在非 ARC 下, block 不会 retain 捕获的变量.


4. 使用 nonatomic 一定是线程安全的吗？
nonatomic 的内存管理语义是非原子的, 非原子的操作本来就是线程不安全的, 而 atomic 的操作是原子的, 但是并不意味着它是线程安全的, 它会增加正确的几率, 能够更好的避免线程的错误, 但是它仍然是线程不安全的.

当使用 nonatomic 的时候, 属性的 setter 和 getter 操作是非原子的, 所以当多个线程同时对某一属性进行读和写的操作, 属性的最终结果是不能预测的.

当使用 atomic 时, 虽然对属性的读和写是原子的, 但是仍然可能出现线程错误: 当线程 A 进行写操作, 这时其他线程的读或写操作会因为该操作的进行而等待. 当 A 线程的写操作结束后, B 线程进行写操作, 然后当 A 线程进行读操作时, 却获得了在 B 线程中的值, 这就破坏了线程安全, 如果有线程 C 在 A 线程读操作前 release 了该属性, 那么还会导致程序崩溃. 所以仅仅使用 atomic 并不会使得线程安全, 我们还需要为线程添加 lock 来确保线程的安全.

atomic 都不是一定线程安全的, nonatomic 就更不必多说了.


6. + (void)load; 和 + (void)initialize; 有什么用处？
当类对象被引入项目时, runtime 会向每一个类对象发送 load 消息. load 方法还是非常的神奇的, 因为它会在每一个类甚至分类被引入时仅调用一次, 调用的顺序是父类优先于子类, 子类优先于分类. 而且 load 方法不会被类自动继承, 每一个类中的 load 方法都不需要像 viewDidLoad 方法一样调用父类的方法. 由于 load 方法会在类被 import 时调用一次, 而这时往往是改变类的行为的最佳时机. 我在 DKNightVersion 中使用 method swizlling 来修改原有的方法时, 就是在分类 load 中实现的.

initialize 方法和 load 方法有一些不同, 它虽然也会在整个 runtime 过程中调用一次, 但是它是在该类的第一个方法执行之前调用, 也就是说 initialize 的调用是惰性的, 它的实现也与我们在平时使用的惰性初始化属性时基本相同. 我在实际的项目中并没有遇到过必须使用这个方法的情况, 在该方法中主要做静态变量的设置并用于确保在实例初始化前某些条件必须满足.

7. 为什么其他语言里叫函数调用, Objective-C 中是给对象发送消息 (谈下对 runtime 的理解)
我们在其他语言中比如说: C, Python, Java, C++, Haskell ... 中提到函数调用或者方法调用(面向对象). 函数调用是在编译期就已经决定了会调用哪个函数(方法), 编译器在编译期就能检查出函数的执行是否正确.

然而 Objective-C(ObjC) 是一门动态的语言, 整个 ObjC 语言都是尽可能的将所有的工作推迟到运行时才决定. 它基于 runtime 来工作, runtime 就是 ObjC 的灵魂, 其核心就是消息发送objc_msgSend.

What makes Objective-C truly powerful is its runtime.

所有的消息都会在运行时才会确定, [obj message] 在运行时会被转化为 objc_msgSend(id self, SEL cmd, ...) 来执行, 它会在运行时从选择子表中寻找对应的选择子并将选择子与实现进行绑定. 而如果没有找到对应的实现, 就会进入类似黑魔法的消息转发流程. 调用 + (BOOL)resolveInstanceMethod:(SEL)aSelector 方法, 我们可以在这个方法中为类动态地生成方法.

我们几乎可以使用 runtime 魔改 Objective-C 中的一切: class property object ivar method protocol, 而下面就是它的主要应用:

内省
为分类动态的添加属性
使用方法调剂修改原有的方法实现
...
8. 什么是 Method Swizzling?
method swizzling 实际上就是一种在运行时动态修改原有方法实现的技术, 它实际上是基于 ObjC runtime 的特性, 而 method swizzling 的核心方法就是 method_exchangeImplementations(SEL origin, SEL swizzle). 使用这个方法就可以在运行时动态地改变原有的方法实现, 在 DKNigtVersion(为 iOS 应用添加夜间模式) 中能够看到大量 method swizzling 的使用, 方法的调用时机就是在上面提到的 load 方法中, 不在 initialize 方法中改变方法实现的原因是 initialize 可能会被子类所继承并重新执行最终导致无限递归, 而 load 并不会被继承.

9. UIView 和 CALayer 有什么关系?
看到这个问题不禁想到大一在网易面试时的经历, 当时的两位面试官就问了我这么一个问题, UIView和 CALayer 是什么关系, 为什么要这么设计? 我已经忘记了当时是怎么回答的. 隐约记得当时说每一个 UIView 都会对应一个 CALayer 至于为什么这样, 当时的我实在是太弱无法回答出来了.

每一个 UIView 的身后对应一个 Core Animation 框架中的 CALayer. 每一个 CALayer 都是 UIView 的代理.

Many of the methods you call on UIView simply delegate to the layer

在 iOS 上当你处理一个又一个的 UIView 时, 实际上是在操作 CALayer. 尽管有的时候你并不知道 (直接操作 CALayer 并不会对效率有着显著的提升).

UIView 实际上就是对 CALayer 的轻量级的封装. UIView 继承自 UIResponder, 用来处理来自用户的事件; CALayer 继承自 NSObject 主要用于处理图层的渲染和动画. 这么设计有以下几个原因:

你可以通过操作 UIView 在一个更高的层级上处理与用户的交互, 触摸, 点击, 拖拽等事件, 这些都是在 UIKit 这个层级上完成的.
UIView 和 NSView(AppKit) 的实现极其不同, 而使用 Core Animation 可以实现底层代码地重用, 在 Mac 和 iOS 平台上都使用着近乎相同的 Core Animation 代码, 这样我们可以对这个层级进行抽象在两种平台上产生 UIKit 和 AppKit 用于不同平台的框架.
使用 CALayer 的唯一原因大概是便于移植到不同的平台, 如果仅仅使用 Core Animation 层级进行开发, 处理用户的交互时间需要写更多的代码.

10. 如何高性能的给 UIImageView 加个圆角? (不准说 layer.cornerRadius!)
一般情况下给 UIImageView 或者说 UIKit 的控件添加圆角都是改变 clipsToBounds 和 layer.cornerRadius, 这样大约两行代码就可以解决这个问题. 但是, 这样使用这样的方法会强制 Core Animation 提前渲染屏幕的离屏绘制, 而离屏绘制就会为性能带来负面影响.

我们也可以使用另一种比较复杂的方式来为图片添加圆角, 这里就用到了贝塞尔曲线.

UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];  
imageView.center = CGPointMake(200, 300);  
UIImage *anotherImage = [UIImage imageNamed:@"image"];  
UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);  
[[UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                           cornerRadius:50] addClip];
[anotherImage drawInRect:imageView.bounds];
imageView.image = UIGraphicsGetImageFromCurrentImageContext();  
UIGraphicsEndImageContext();  
[self.view addSubview:imageView];
在这里使用了贝塞尔曲线"切割"个这个图片, 给 UIImageView 添加了的圆角.

11. 使用 drawRect: 有什么影响?
这个问题对于我来说确实有些难以回答, 我记得我在我人生的第一个 iOS 项目 SportJoin 中曾经使用这个方法来绘制图形, 但是具体怎么做的, 我已经忘记了.

这个方法的主要作用是根据传入的 rect 来绘制图像 参见文档. 这个方法的默认实现没有做任何事情, 我们可以在这个方法中使用 Core Graphics 和 UIKit 来绘制视图的内容.

这个方法的调用机制也是非常特别. 当你调用 setNeedsDisplay 方法时, UIKit 将会把当前图层标记为 dirty, 但还是会显示原来的内容, 直到下一次的视图渲染周期, 才会为标记为 dirty 的图层重新建立 Core Graphics 上下文, 然后将内存中的数据恢复出来, 再使用 CGContextRef 进行绘制.

12. ASIHttpRequest 或者 SDWebImage 里面给 UIImageView 加载图片的逻辑是什么样的?
我曾经阅读过 SDWebImage 的源代码, 就在这里对如何给 UIImageView 加载图片做一个总结吧, SDWebImage 中为 UIView 提供了一个分类叫做 WebCache, 这个分类中有一个最常用的接口, sd_setImageWithURL:placeholderImage:, 这个分类同时提供了很多类似的方法, 这些方法最终会调用一个同时具有 option progressBlock completionBlock 的方法, 而在这个类最终被调用的方法首先会检查是否传入了 placeholderImage 以及对应的参数, 并设置 placeholderImage.

然后会获取 SDWebImageManager 中的单例调用一个 downloadImageWithURL:... 的方法来获取图片, 而这个 manager 获取图片的过程有大体上分为两部分, 它首先会在 SDWebImageCache 中寻找图片是否有对应的缓存, 它会以 url 作为数据的索引先在内存中寻找是否有对应的缓存, 如果缓存未命中就会在磁盘中利用 MD5 处理过的 key 来继续查询对应的数据, 如果找到了, 就会把磁盘中的缓存备份到内存中.

然而, 假设我们在内存和磁盘缓存中都没有命中, 那么 manager 就会调用它持有的一个 SDWebImageDownloader 对象的方法 downloadImageWithURL:... 来下载图片, 这个方法会在执行的过程中调用另一个方法 addProgressCallback:andCompletedBlock:fotURL:createCallback: 来存储下载过程中和下载完成的回调, 当回调块是第一次添加的时候, 方法会实例化一个 NSMutableURLRequest 和 SDWebImageDownloaderOperation, 并将后者加入 downloader 持有的下载队列开始图片的异步下载.

而在图片下载完成之后, 就会在主线程设置 image, 完成整个图像的异步下载和配置.

13. 设计一个简单的图片内存缓存器 (包含移除策略)
待我阅读完 path 开源的 FastImageCache的源代码就来回答.

14. 讲讲你用Instrument优化动画性能的经历
15. loadView 的作用是什么?
This method loads or creates a view and assigns it to the view property.

loadView 是 UIViewController 的实例方法, 我们永远不要直接调用这个方法 [self loadView]. 这在苹果的官方文档中已经明确的写出了. loadView 会在获取视图控制器的 view 但是却得到 nil 时被调用.

loadView 的具体实现会做下面两件事情中的一件:

如果你的视图控制器关联了一个 storyboard, 那么它就会加载 storyboard 中的视图.

如果试图控制器没有关联的 storyboard, 那么就会创建一个空的视图, 并分配给 view 属性

如果你需要覆写 loadView 方法:

你需要创建一个根视图.
创建并初始化 view 的子视图, 调用 addSubview: 方法将它们添加到父视图上.
如果你使用了自动布局, 提供足够的约束来保证视图的位置.
将根视图分配给 view 属性.
永远不要在这个方法中调用 [super loadView].

16. viewWillLayoutSubviews 的作用是什么?
viewWillLayoutSubviews 方法会在视图的 bounds 改变时, 视图会调整子视图的位置, 我们可以在视图控制器中覆写这个方法在视图放置子视图前做出改变, 当屏幕的方向改变时, 这个方法会被调用.

17. GCD 里面有哪几种 Queue? 背后的线程模型是什么样的?
GCD 中 Queue 的种类还要看我们怎么进行分类, 如果根据同一时间内处理的操作数分类的话, GCD 中的 Queue 分为两类

Serial Dispatch Queue
Concurrent Dispatch Queue
一类是串行派发队列, 它只使用一个线程, 会等待当前执行的操作结束后才会执行下一个操作, 它按照追加的顺序进行处理. 另一类是并行派发队列, 它同时使用多个线程, 如果当前的线程数足够, 那么就不会等待正在执行的操作, 使用多个线程同时执行多个处理.

另外的一种分类方式如下:

Main Dispatch Queue
Global Dispatch Queue
Custom Dispatch Queue
主线程只有一个, 它是一个串行的进程. 所有追加到 Main Dispatch Queue 中的处理都会在 RunLoop 在执行. Global Dispatch Queue 是所有应用程序都能使用的并行派发队列, 它有 4 个执行优先级 High, Default, Low, Background. 当然我们也可以使用 dispatch_queue_create 创建派发队列.

18. Core Data 或者 sqlite 的读写是分线程的吗? 死锁如何解决?
Core Data 和 sqlite 这两个我还真没深入用过, 我只在小的玩具应用上使用过 Core Data, 但是发现这货实在是太难用了, 我就果断放弃了, sqlite 我也用过, 每次输入 SQL 语句的时候我多想吐槽, 写一些简单的还好, 复杂的就直接 Orz 了. 所以我一般会使用 levelDB 对进行数据的持久存储.

数据库读取操作一般都是多线程的, 在对数据进行读取的时候, 我们要确保当前的状态不会被修改, 所以加锁, 防止由于线程竞争而出现的错误. 在 Core Data 中使用并行的最重要的规则是: 每一个 NSManagedObjectContext 必须只从创建它的进程中访问.

19. http 的 POST 和 GET 有什么区别?
根据 HTTP 协议的定义 GET 类型的请求是幂等的, 而 POST 请求是有副作用的, 也就是说 GET 用于获取一些资源, 而 POST 用于改变一些资源, 这可能会创建新的资源或更新已有的资源.

POST 请求比 GET 请求更加的安全, 因为你不会把信息添加到 URL 上的查询字符串上. 所以使用 GET 来收集密码或者一些敏感信息并不是什么好主意.

最后, POST 请求比 GET 请求也可以传输更多的信息.

20. 什么是 Binary search tree, 它的时间复杂度是多少?
二叉搜索树是一棵以二叉树来组织的, 它搜索的时间复杂度 [Math Processing Error]O(h) 与树的高度成正比, 最坏的运行时间是 [Math Processing Error]Θ(lg⁡n).

### ----------------------------------第二部分--------------------------------------


1.UIWindow和UIView和 CALayer 的联系和区别?

答：UIView是视图的基类，UIViewController是视图控制器的基类，UIResponder是表示一个可以在屏幕上响应触摸事件的对象；

UIwindow是UIView的子类，UIWindow的主要作用：一是提供一个区域来显示UIView，二是将事件（event）的分发给UIView，一个应用基本上只有一个UIWindow.

万物归根，UIView和CALayer都是的老祖都是NSObjet。可见 UIResponder是用来响应事件的，也就是UIView可以响应用户事件。

CALayer 和 UIView 的区别：
1.1 UIView的继承结构为: UIResponder : NSObject。
CALayer的继承结构为： NSObject。可见 UIResponder是用来响应事件的，也就是UIView可以响应用户事件，CALayer直接从 NSObject继承，因为缺少了UIResponder类，不能响应任何用户事件
1.2 所属框架,UIView是在 /System/Library/Frameworks/UIKit.framework中定义的,UIKit主要是用来构建用户界面，并且是可以响应事件的。CALayer是在/System/Library/Frameworks/QuartzCore.framework定义的。而且CALayer作为一个低级的，可以承载绘制内容的底层对象出现在该框架中。

1.3 UIView相比CALayer最大区别是UIView可以响应用户事件，而CALayer不可以。UIView侧重于对显示内容的管理，CALayer侧重于对内容的绘制。UIView是基于CALayer的高层封装。

1.4 相似支持1：相似的树形结构2：显示内容绘制方式3: 布局约束
总结一下就是：UIView是用来显示内容的，可以处理用户事件.CALayer是用来绘制内容的，对内容进行动画处理依赖与UIView来进行显示，不能处理用户事件
为啥有两套体系 并不是两套体系？UIView和CALayer是相互依赖的关系。UIView依赖与calayer提供的内容，CALayer依赖uivew提供的容器来显示绘制的内容。归根到底CALayer是这一切的基础，如果没有CALayer，UIView自身也不会存在，UIView是一个特殊的CALayer实现，添加了响应事件的能力。UIView本身，更像是一个CALayer的管理器，访问它的跟绘图和跟坐标有关的属性，例如frame，bounds等等，实际上内部都是在访问它所包含的CALayer的相关属性。

UIView的layer树形在系统内部，被系统维护着三份copy（这段理解有点吃不准）。
第一份，逻辑树，就是代码里可以操纵的，例如更改layer的属性等等就在这一份。
第二份，动画树，这是一个中间层，系统正在这一层上更改属性，进行各种渲染操作。
第三份，显示树，这棵树的内容是当前正被显示在屏幕上的内容。
这三棵树的逻辑结构都是一样的，区别只有各自的属性。
UIView的主layer以外，对它的subLayer，也就是子layer的属性进行更改，系统将自动进行动画生成。
CALayer的坐标系系统和UIView有点不一样，它多了一个叫anchorPoint的属性，它使用CGPoint结构，但是值域是0~1，也就是按照比例来设置。这个点是各种图形变换的坐标原点，同时会更改layer的position的位置，它的缺省值是{0.5, 0.5}，也就是在layer的中央。

哈哈，这下够说一壶的了把，虽然说完感觉其实没什么卵用，但是记住一定要说的绘声绘色。

参考链接如下：

http://o0o0o0o.iteye.com/blog/1728599
http://www.cnblogs.com/pengyingh/articles/2381673.html

2. property 都有哪些常见的字段

strong，weak，retain，assign，copy nomatic,readonly

3. strong，weak，retain，assign，copy nomatic 等的区别。

assign： 简单赋值，不更改索引计数（Reference Counting）对基础数据类

copy： 建立一个索引计数为1的对象，然后释放旧对象。对NSString

retain：释放旧的对象，将旧对象的值赋予输入对象，再提高输入对象的索引计数为1 ,对其他NSObject和其子类
weak 和strong的区别：weak和strong不同的是 当一个对象不再有strong类型的指针指向它的时候 它会被释放 ，即使还有weak型指针指向它。一旦最后一个strong型指针离去 ，这个对象将被释放，所有剩余的weak型指针都将被清除。

copy与retain：

copy其实是建立了一个相同的对象，而retain不是.
copy是内容拷贝，retain是指针拷贝。
copy是内容的拷贝 ,对于像NSString,的确是这样，如果拷贝的是 NSArray这时只是copy了指向array中相对应元素的指针.这便是所谓的"浅复制"。
atomic是Objc使用的一种线程保护技术，基本上来讲，是防止在写未完成的时候被另外一个线程读取，造成数据错误。而这种机制是耗费系统资源的，所以在iPhone这种小型设备上，如果没有使用多线程间的通讯编程，那么nonatomic是一个非常好的选择。

对于 NSString 为什么使用 copy 参考这篇链接
http://southpeak.github.io/blog/2015/05/10/ioszhi-shi-xiao-ji-di-%5B%3F%5D-qi-2015-dot-05-dot-10/

4.block和weak修饰符的区别：
__block不管是ARC还是MRC模式下都可以使用，可以修饰对象，还可以修饰基本数据类型。
__weak只能在ARC模式下使用，也只能修饰对象（NSString），不能修饰基本数据类型（int）。
__block对象可以在block中被重新赋值，__weak不可以。

5.常见的 Http 状态码有哪些？

http状态吗 ：302 是请求重定向。500以上是服务器错误。400以上是请求链接错误或者找不到服务器。200以上是正确。100以上是请求接受成功。

2-3问题参考链接http://zhangmingwei.iteye.com/blog/1748431

6.单例的写法。在单例中使用数组要注意什么？

static PGSingleton *sharedSingleton;

+ (instancetype)sharedSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[PGSingleton alloc] init];
    });
    return sharedSingleton;
}
其实上面的还不是标准的单例方法，标准的单例方法需要重写 copyWithZone,allocWithZone,init,确保以任何方式创建出来的对象只有一个，这里就不详细写了。

单例使用 NSMutableArray 的时候，防止多个地方对它同时遍历和修改的话，需要加原子属性。并且property用strong，并且写一个遍历和修改的方法。加上锁. Lock,UnLock.（PS:考虑性能问题尽量避免使用锁，在苹果的文档张看到的不要问我为什么，我也忘了自己查去。。)

关于单例的参考，和不要滥用单例的参考

http://www.jianshu.com/p/7486ebfcd93b
http://blog.codingcoder.com/singletons/

7.static 关键字的作用

1.函数体内 static 变量的作用范围为该函数体，不同于 auto 变量，该变量的内存只被分配一次，
因此其值在下次调用时仍维持上次的值；
2.在模块内的 static 全局变量可以被模块内所用函数访问，但不能被模块外其它函数访问；
3.在模块内的 static 函数只可被这一模块内的其它函数调用，这个函数的使用范围被限制在声明 它的模块内；
4.在类中的 static 成员变量属于整个类所拥有，对类的所有对象只有一份拷贝；
5.在类中的 static 成员函数属于整个类所拥有，这个函数不接收 this 指针，因而只能访问类的static 成员变量。

8.iOS 中的事件的传递:响应链

简要说一下:
事件沿着一个指定的路径传递直到它遇见可以处理它的对象。 首先一个UIApplication 对象从队列顶部获取一个事件并分发(dispatches)它以便处理。 通常，它把事件传递给应用程序的关键窗口对象，该对象把事件传递给一个初始对象来处理。 初始对象取决于事件的类型。

触摸事件。 对于触摸事件，窗口对象首先尝试把事件传递给触摸发生的视图。那个视图被称为hit-test(点击测试)视图。 寻找hit-test视图的过程被称为hit-testing, 参见 “Hit-Testing Returns the View Where a Touch Occurred.”
运动和远程控制事件。 对于这些事件，窗口对象把shaking-motion(摇晃运动)或远程控制事件传递给第一响应者来处理。第一响应者请参见 “The Responder Chain Is Made Up of Responder Objects.”
iOS 使用hit-testing来找到事件发生的视图。 Hit-testing包括检查触摸事件是否发生在任何相关视图对象的范围内， 如果是，则递归地检查所有视图的子视图。在视图层次中的最底层视图，如果它包含了触摸点，那么它就是hit-test视图。等 iOS决定了hit-test视图之后，它把触摸事件传递给该视图以便处理。
参考链接：http://yishuiliunian.gitbooks.io/implementate-tableview-to-understand-ios/content/uikit/132event-chains.html

9堆和栈的区别

管理方式：对于栈来讲，是由编译器自动管理，无需我们手工控制；对于堆来说，释放工作由程序员控制，容易产生memory leak。

申请大小：
栈：在Windows下,栈是向低地址扩展的数据结构，是一块连续的内存的区域。这句话的意思是栈顶的地址和栈的最大容量是系统预先规定好的，在 WINDOWS下，栈的大小是2M（也有的说是1M，总之是一个编译时就确定的常数），如果申请的空间超过栈的剩余空间时，将提示overflow。因此，能从栈获得的空间较小。

堆：堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的，自然是不连续的，而链表的遍历方向是由低地址向高地址。堆的大小受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。

碎片问题：对于堆来讲，频繁的new/delete势必会造成内存空间的不连续，从而造成大量的碎片，使程序效率降低。对于栈来讲，则不会存在这个问题，因为栈是先进后出的队列，他们是如此的一一对应，以至于永远都不可能有一个内存块从栈中间弹出
分配方式：堆都是动态分配的，没有静态分配的堆。栈有2种分配方式：静态分配和动态分配。静态分配是编译器完成的，比如局部变量的分配。动态分配由alloca函数进行分配，但是栈的动态分配和堆是不同的，他的动态分配是由编译器进行释放，无需我们手工实现。
分配效率：栈是机器系统提供的数据结构，计算机会在底层对栈提供支持：分配专门的寄存器存放栈的地址，压栈出栈都有专门的指令执行，这就决定了栈的效率比较高。堆则是C/C++函数库提供的，它的机制是很复杂的。



### ----------------------------------第三部分--------------------------------------


1. Object-C有多继承吗？没有的话用什么代替？

cocoa 中所有的类都是NSObject 的子类

多继承在这里是用protocol 委托代理 来实现的 你不用去考虑繁琐的多继承 ,虚基类的概念. ood的多态特性 在 obj-c 中通过委托来实现.

2. Object-C有私有方法吗？私有变量呢？

objective-c – 类里面的方法只有两种, 静态方法和实例方法. 这似乎就不是完整的面向对象了,按照OO的原则就是一个对象只暴露有用的东西. 如果没有了私有方法的话, 对于一些小范围的代码重用就不那么顺手了.

在类里面声名一个私有方法

@interface Controller : NSObject { NSString *something; } 
+ (void)thisIsAStaticMethod; – (void)thisIsAnInstanceMethod;
 @end

@interface Controller (private) 
- (void)thisIsAPrivateMethod; 
- @end
@private可以用来修饰私有变量

在Objective‐C中，所有实例变量默认都是私有的，所有实例方法默认都是公有的

3.   #import和#include的区别，@class代表什么？

@class一般用于头文件中需要声明该类的某个实例变量的时候用到，在m文件中还是需要使用#import‘

而#import比起#include的好处就是不会引起重复包含

4. 线程和进程的区别？

进程和线程都是由操作系统所体会的程序运行的基本单元，系统利用该基本单元实现系统对应用的并发性。

进程和线程的主要差别在于它们是不同的操作系统资源管理方式。进程有独立的地址空间，一个进程崩溃后，在保护模式下不会对其它进程产生影响，而线程只是一个进程中的不同执行路径。线程有自己的堆栈和局部变量，但线程之间没有单独的地址空间，一个线程死掉就等于整个进程死掉，所以多进程的程序要比多线程的程序健壮，但在进程切换时，耗费资源较大，效率要差一些。但对于一些要求同时进行并且又要共享某些变量的并发操作，只能用线程，不能用进程。

5. 堆和栈的区别？

管理方式：对于栈来讲，是由编译器自动管理，无需我们手工控制；对于堆来说，释放工作由程序员控制，容易产生memory leak。 申请大小：

栈：在Windows下,栈是向低地址扩展的数据结构，是一块连续的内存的区域。这句话的意思是栈顶的地址和栈的最大容量是系统预先规定好的，在WINDOWS下，栈的大小是2M（也有的说是1M，总之是一个编译时就确定的常数），如果申请的空间超过栈的剩余空间时，将提示overflow。因此，能从栈获得的空间较小。

堆：堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的，自然是不连续的，而链表的遍历方向是由低地址向高地址。堆的大小受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。

碎片问题：对于堆来讲，频繁的new/delete势必会造成内存空间的不连续，从而造成大量的碎片，使程序效率降低。对于栈来讲，则不会存在这个问题，因为栈是先进后出的队列，他们是如此的一一对应，以至于永远都不可能有一个内存块从栈中间弹出

分配方式：堆都是动态分配的，没有静态分配的堆。栈有2种分配方式：静态分配和动态分配。静态分配是编译器完成的，比如局部变量的分配。动态分配由alloca函数进行分配，但是栈的动态分配和堆是不同的，他的动态分配是由编译器进行释放，无需我们手工实现。 分配效率：栈是机器系统提供的数据结构，计算机会在底层对栈提供支持：分配专门的寄存器存放栈的地址，压栈出栈都有专门的指令执行，这就决定了栈的效率比较高。堆则是C/C++函数库提供的，它的机制是很复杂的。

6. Object-C的内存管理？

1.当你使用new,alloc和copy方法创建一个对象时,该对象的保留计数器值为1.当你不再使用该对象时,你要负责向该对象发送一条release或autorelease消息.这样,该对象将在使用寿命结束时被销毁.

2.当你通过任何其他方法获得一个对象时,则假设该对象的保留计数器值为1,而且已经被设置为自动释放,你不需要执行任何操作来确保该对象被清理.如果你打算在一段时间内拥有该对象,则需要保留它并确保在操作完成时释放它.

3.如果你保留了某个对象,你需要(最终)释放或自动释放该对象.必须保持retain方法和release方法的使用次数相等.

7 浅复制和深复制的区别？

答案：浅层复制：只复制指向对象的指针，而不复制引用对象本身。

深层复制：复制引用对象本身。

意思就是说我有个A对象，复制一份后得到A_copy对象后，对于浅复制来说，A和A_copy指向的是同一个内存资源，复制的只不过是是一个指针，对象本身资源 还是只有一份，那如果我们对A_copy执行了修改操作,那么发现A引用的对象同样被修改，这其实违背了我们复制拷贝的一个思想。深复制就好理解了,内存中存在了 两份独立对象本身。

用网上一哥们通俗的话将就是：

浅复制好比你和你的影子，你完蛋，你的影子也完蛋

深复制好比你和你的克隆人，你完蛋，你的克隆人还活着。

### ----------------------------------第四部分--------------------------------------









































