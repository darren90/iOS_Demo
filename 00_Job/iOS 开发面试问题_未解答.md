# iOS 开发面试问题

受 [Front end Developer Interview Questions](https://github.com/h5bp/Front-end-Developer-Interview-Questions) 启发，制作了这份 iOS 面试问题列表。

面试 iOS 开发时，切入点很重要，不同的切入点会导致不同的结果，没有找到合适的切入点也无法对应聘者有一个全面的了解。所以这份面试问题列表更多的是提供方向，没有固定的答案，而且可以根据应聘者的回应引出更多有意思深层次的讨论。

如果有不错的问题，欢迎 Pull Request :)

## 一般性问题
* 最近这两天你有学到什么知识/技能么？
* 最近有做过比较酷或者比较有挑战的项目么？
* 最近看过的书/文章有哪些？
* 如何向一个只接触过互联网的孩子解释「电视」？
* 为什么要学习编程，编程对你而言的乐趣在哪儿？
* 如果一个函数10次中有7次正确，3次错误，问题可能出现在哪里？
* 自身最大优点是什么，怎么证明？
* 有没有在 GitHub 上发布过开源代码，参与过开源项目？
* 你最近遇到过的一个技术挑战是什么？怎么解决的？
* 开发常用的工具有哪些？
* 熟悉 CocoaPods 么？能大概讲一下工作原理么？
* 最常用的版本控制工具是什么，能大概讲讲原理么？
* 今年你最想掌握的一门技术是什么？为什么？目前已经做到了哪个程度？
* 你一般是怎么用 Instruments 的？
* 你一般是如何调试 Bug 的？
* 你在你的项目中用到了哪些设计模式？
* 如何实现单例，单例会有什么弊端？
* iOS 是如何管理内存的？

## 知识性问题
* 什么是响应链，它是怎么工作的？
* 如何访问并修改一个类的私有属性？
* iOS Extension 是什么？能列举几个常用的 Extension 么？
* 如何把一个包含自定义对象的数组序列化到磁盘？
* Apple Pay 是什么？它的大概工作流程是怎样的？
* iOS 的沙盒目录结构是怎样的？ App Bundle 里面都有什么？
* iOS 的签名机制大概是怎样的？
* iOS 7的多任务添加了哪两个新的 API? 各自的使用场景是什么？
* Objective-C 的 `class` 是如何实现的？`Selector` 是如何被转化为 C 语言的函数调用的？
* `UIScrollView` 大概是如何实现的，它是如何捕捉、响应手势的？
* Objective-C 如何对已有的方法，添加自己的功能代码以实现类似记录日志这样的功能？
* `+load` 和 `+initialize` 的区别是什么？
* 如何让 Category 支持属性？
* `NSOperation` 相比于 GCD 有哪些优势？
* `strong` / `weak` / `unsafe_unretained` 的区别？
* 如何为 Class 定义一个对外只读对内可读写的属性?
* Objective-C 中，meta-class 指的是什么？
* `UIView` 和 `CALayer` 之间的关系？
* `+[UIView animateWithDuration:animations:completion:]` 内部大概是如何实现的？
* 什么时候会发生「隐式动画」？
* 如何处理异步的网络请求？
* `frame` 和 `bounds` 的区别是什么？
* 如何把一张大图缩小为1/4大小的缩略图？
* 一个 App 会处于哪些状态？
* Push Notification 是如何工作的？
* 什么是 Runloop？
* Toll-Free Bridging 是什么？什么情况下会使用？
* 当系统出现内存警告时会发生什么？
* 什么是 `Protocol`，Delegate 一般是怎么用的？
* autorelease 对象在什么情况下会被释放？
* UIWebView 有哪些性能问题？有没有可替代的方案。
* 为什么 NotificationCenter 要 removeObserver? 如何实现自动 remove?
* 当 `TableView` 的 `Cell` 改变时，如何让这些改变以动画的形式呈现？
* 什么是 `Method Swizzle`，什么情况下会使用？

## 经验类问题
* 为什么 `UIScrollView` 的滚动会导致 `NSTimer` 失效？
* 为什么当 Core Animation 完成时，layer 又会恢复到原先的状态？
* 你会如何存储用户的一些敏感信息，如登录的 token。
* 有用过一些开源组件吧，能简单说几个么，大概说说它们的使用场景实现。
* 什么时候会发生 `EXC BAD ACCESS` 异常？
* 什么时候会使用 Core Graphics，有什么注意事项么？
* NSNotification 和 KVO 的使用场景？
* 使用 Block 时需要注意哪些问题？
* `performSelector:withObject:afterDelay:` 内部大概是怎么实现的，有什么注意事项么？
* 如何播放 GIF 图片，有什么优化方案么？
* 使用 `NSUserDefaults` 时，如何处理布尔的默认值？(比如返回 NO，不知道是真的 NO 还是没有设置过)
* 有哪几种方式可以对图片进行缩放，使用 CoreGraphics 缩放时有什么注意事项？
* 哪些途径可以让 ViewController 瘦下来？
* 有哪些常见的 Crash 场景？

## 综合类问题
* 设计一个可以无限滚动并且支持自动滚动的 SlideShow。
* 设计一个进度条。
* 设计一套大文件（如上百M的视频）下载方案。
* 如果让你来实现 `dispatch_once`，你会怎么做？
* 设计一个类似 iOS 主屏可以下拉出现 Spotlight 的系统。(对 UIScrollView 的理解程度)

## 编程实现
* 简述[「Snakes and Ladders」](http://en.wikipedia.org/wiki/Snakes_and_Ladders)的实现思路(这道题比较容易阐述清楚，且难度适中)

## 参考

* http://way2ios.com/development/ios-development-2/iphone-interview-question-answers/
* https://blackpixel.com/writing/2013/04/interview-questions-for-ios-and-mac-developers-1.html
* https://github.com/CameronBanga/iOS-Developer-and-Designer-Interview-Questions



### ----------------------------------第二部分--------------------------------------


收集了一些iOS技术面试题，试试你能通过吗？   


1.Difference between shallow copy and deep copy? 

2.What is advantage of categories? What is difference between implementing a category and inheritance? 

3.Difference between categories and extensions? 

4.Difference between protocol in objective c and interfaces in java? 

5.What are KVO and KVC? 

6.What is purpose of delegates? 

7.What are mutable and immutable types in Objective C? 

8.When we call objective c is runtime language what does it mean? 

9.what is difference between NSNotification and protocol? 

10.What is push notification? 

11.Polymorphism? 

12.Singleton? 

13.What is responder chain? 

14.Difference between frame and bounds? 

15.Difference between method and selector? 

16.Is there any garbage collection mechanism in Objective C.? 

17.NSOperation queue? 

18.What is lazy loading? 

19.Can we use two tableview controllers on one viewcontroller? 

20.Can we use one tableview with two different datasources? How you will achieve this? 

21.What is advantage of using RESTful webservices? 

22.When to use NSMutableArray and when to use NSArray? 

23.What is the difference between REST and SOAP? 

24.Give us example of what are delegate methods and what are data source methods of uitableview. 

25.How many autorelease you can create in your application? Is there any limit? 

26.If we don’t create any autorelease pool in our application then is there any autorelease pool already provided to us? 

27.When you will create an autorelease pool in your application? 

28.When retain count increase? 

29.Difference between copy and assign in objective c? 

30.What are commonly used NSObject class methods? 

31.What is convenience constructor? 

32.How to design universal application in Xcode? 

33.What is keyword atomic in Objective C? 

34.What are UIView animations? 

35.How can you store data in iPhone applications? 

36.What is coredata? 

37.What is NSManagedObject model? 

38.What is NSManagedobjectContext? 

39.What is predicate? 

40.What kind of persistence store we can use with coredata? 

转自http://blog.csdn.net/favormm/article/details/7049022， 我先去整理答案，过两天上来对答案。多谢各位的解答，让我们共同进步~ 


### ----------------------------------第三部分--------------------------------------



1、 app的崩溃率是多少？线上app出现问题如何解决？
2、 Runloop是什么？如何用？在什么场景下会用到？
3、 数据列表需要展示大量数据，如何优化？至少三个方面？
4、 SQLite和CoreData区别？优缺点？FBDataBase使用？coreData结构构成？
5、 上千条数据需要插入数据表，如何优化提高效率？
6、 同时对同一张表进行操作？
7、 数据库什么时候打开？什么时候关闭？
8、 WebView突然弹出广告或者垃圾信息？是什么原因造成的？如何解决？
9、 ASI和AFNetWorking区别？核心实现上有什么不同？
10、 项目中遇到过什么重大问题？如何解决的？
11、 在做项目中使用过哪些自己认为比较好的技术？
12、 app版本升级中需要对数据表等做更新，此时如何数据库升级？
13、 category类目的作用？类目是否可以添加属性？类目中得方法名和系统的重名会怎样？
14、 封装类库给别人用，需要注意哪些问题？
15、 多线程里面主要由哪几种？它们的优缺点？
16、 实现类似网易新闻的滑动标签选项，需要写哪几个类？
17、 比如一个第三方分享，每次调用都比较耗时，而且好多页面都用到了，那如何监控次耗时操作在所有页面的耗时时间？
18、 [__NSString close] unrecogonized selector 
[__NSDictionary close]  unrecoginized selector 为什么出现这种问题？由什么造成的？

19、 平时看些什么书籍？
20、 自己得优缺点？
21、 常见得字符编码？它们的区别？
22、 ARC下如何处理内存问题？ARC和MRC之间的区别？如何处理内存警告？



### ----------------------------------第五部分--------------------------------------


1. UIView的生命周期是什么样的，执行顺序是怎么样的？
init —— loadView ——  viewDidLoad —— viewWillAppear —— viewWillDisappear —— viewDidUnload —— dealloc.

2. UIViewController在什么时候会加载UIView，换句话说，技术上在哪个时间点会执行loadView。
这个问题我没有答上来，原来写程序只知道是在addSubview或pushViewController的时候，程序就会执行loadView。于是觉得，loadView是在UIView要被显示出来之前执行的。后来了解到，这种说法其实有点本末倒至了。是因为执行了loadView，所以UIView才会被显示出来。正确的答案是，在view对象第一次被访问的时候，会执行loadView。

3. UITableView的执行流程是怎么样的？
省去UIView相关的不说，就UITableView来说，每个UITableView都会有一个delegate，delegate指向的对象会接受UITableView的委托从而实现一系列的方法。其主要的几个方法执行顺序如下：
numberOfSectionsInTableView——numberOfRowsInSection——titleForHeaderInSection——cellForRowAtIndexPath

4. UITableView是怎样实现Cell的重用的?
UITableView中有一个数组，visibleCells，保存可视的cell。假设一屏可以显示10个cell。当向上滑动tableView时，第1个cell移出可视范围，同时第11个cell显示出来。如果cell是通过dequeueReusableCellWithIdentifier方法得到的，其本质上，是将第一个cell放到第11个的位置，然后内容按照indexPath的要求重绘出来，但并不会清除cell中的subView。这也是为什么在cell中添加了UILabel后，上下拉动时，会有重影（多个UILabel重叠）。要避免此情况，Apple推荐自定义UITableViewCell。如果不自定义cell的话，可以为不同indexPath的cell定义不同的cellIdentifier。或是每次都通过遍历subview删除所有子视图，再重新addSubView，等等。

5. 如何设计一个可变高度（根据内容自适应高度）的UITableViewCell？
这个真是让人蛋疼，我原来确实没有遇到过这样的需求，做法都是定高，然后文字内容多了，直接省略，引导用户点击进入下一层观看。当时间歇性脑残的说了句不知道，后来想想，真的很简单：
我们在configureCell的时候，通过sizeWithFont方法获取UILabel的CGSize，从而得出自定义cell的高度，然后在heightForRowAtIndexPath里进行对应的赋值就可以了。-_-!!!

6. 谈谈内存管理机制。
这个大家基本都了解，Objective-C是通过retainCount来决定是否回收内存。每个NSObject都有一个计数器retainCount，当alloc时，retainCount的值为1，并且每次retain都会加1，release会减1，当retainCount为0的时候，内存会被释放。由此引发了另一个问题，NSString通过stringWithString创建的对象，他的作用域是什么呢？什么时候会被释放？我觉得，通过上述静态方法创建的对象约等于，[[[NSString alloc] initWithString:@""] autorelease]; 也就是说，他是一个autorelease的对象，被放入NSAutoreleasePool中。系统会为每个RunLoop建立一个NSAutoreleasePool，当RunLoop结束时，autoreleasePool里的内存将被释放。
注：答题时我混淆了闭包和RunLoop的概念，把RunLoop说成了闭包。后面讲Block会谈到。

7. 谈谈对block的了解。
block才是闭包。闭包是一个函数或指向函数的指针，再加上其外部变量（也叫自由变量）。block有三种，NSConcreteGlobal, NSConcreteStack, NSConcreteMalloc。block是可以访问block外部的变量的。
NSConcreteGlobal: 就像一个全局函数一样，从头到尾待在那，始终是可用的。当Block中没有引用外部变量时，block为global类型的。
NSConcreteStack: 保存在栈中的block，block执行完后内存会被释放掉。当block引用了外部变量时，block为stack类型的。
NSConcreteMallock: 保存在堆中的block，block为引用记数为0时，内存会被释放掉。当block执行copy时，block会从栈中复制到堆中。
以上都针对非ARC环境而言，如果在ARC环境下，引用外部变量的block会自动保存在堆中，无需copy。

目前整理的就这么多，KVO，Delegate等设计模式今天没谈到。还有7个公司的面试等着哥呢，海量投简历的孩纸伤不起啊。我会持续更新。

原文：http://www.neegou.com/2014/ios-interview/



### ----------------------------------第六部分--------------------------------------


QQ音乐面试题总结
1.描述notification，delegate，block常用场景，三者是同步还是异步。
2，arc下，weak和assign的区别，weak的原理。
3.说说 GB2312 uinicode，utf-8 utf-16编码的区别。NSString默认编码格式是哪个？为什么用这种编码。
4.NSSet和std：map的区别，其中的key的原理。IOS为啥没有定义NSStack，NSQueue这些数据类型。
5.IPV4的主机和IPv6的主机能通过IP协议互通吗？
6.列举HTTP常见状态码。
7.HTTP域名被劫持了咋办。
8.编译器对block是干了什么才能使block外的值能够在block内被访问，说说__block的原理。
9.算法题：
小明住在136层楼，他有两个钢球，硬度为m，两个球硬度一样。
        硬度为M的定义为，从第M楼一个球摔下去不破碎，第M+1楼摔下去就破碎了。而且球破碎了就碎掉了。。。
        问在最坏情况下，提供方案，最少次数内让小明用两个球测出球的硬度。
10.实现一个MAXStack的类，复杂度为O（1）,主要实现三个函数
    1.在对象中赋值 push:(int)n
     2.返回已经输入的最大值。(int)max
     3.返回上次的输入。（int)pop
11.C语言实现字符串比较函数strcmp（char *a，char *b）。


欢迎大家回帖。。。



### ----------------------------------第七部分--------------------------------------


如何面试 iOS 工程师上面的答案都比较“抽象”，下面是我面试iOS程序员的问题列表（私人珍藏），能准确答对一半以上的人非常少（其实这些问题真的不难）。。有兴趣的可以试试。。



1. 什么是arc？（arc是为了解决什么问题诞生的？）
2. 请解释以下keywords的区别： assign vs weak,   __block vs __weak
3.  __block在arc和非arc下含义一样吗？
4. 使用atomic一定是线程安全的吗？
5. 描述一个你遇到过的retain cycle例子。(别撒谎，你肯定遇到过)
6.  +(void)load;   +(void)initialize；有什么用处？
7. 为什么其他语言里叫函数调用， objective c里则是给对象发消息（或者谈下对runtime的理解）
8. 什么是method swizzling?
9. UIView和CALayer是啥关系？
10. 如何高性能的给UIImageView加个圆角？（不准说layer.cornerRadius!）
11. 使用drawRect有什么影响？（这个可深可浅，你至少得用过。。）
12. ASIHttpRequest或者SDWebImage里面给UIImageView加载图片的逻辑是什么样的？（把UIImageView放到UITableViewCell里面问更赞）
13. 麻烦你设计个简单的图片内存缓存器（移除策略是一定要说的）
14. 讲讲你用Instrument优化动画性能的经历吧（别问我什么是Instrument）
15. loadView是干嘛用的？
16. viewWillLayoutSubView你总是知道的。。
17. GCD里面有哪几种Queue？你自己建立过串行queue吗？背后的线程模型是什么样的？
18. 用过coredata或者sqlite吗？读写是分线程的吗？遇到过死锁没？咋解决的？
19. http的post和get啥区别？（区别挺多的，麻烦多说点）
本文来自：http://www.zhihu.com/question/19604641

