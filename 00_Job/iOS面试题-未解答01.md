### iOS面试题-未解答01


### ----------------------------------第一部分--------------------------------------
 
 1)如何处理异步网络事件 
2)用过多线程的Core Data吗，使用的哪种方法
3)用过Core Animation哪种动画 
4)用过Core Graphics吗？（如果是Mac 开发者，答案应该是响亮的YES）
5)你曾经给Apple的framework提过issue么
6)NSNotification和KVO的用法和区别，它们的使用场景
7)如何使用NSOperationQueue
8)讲讲自己使用CoreText的经验
9)后台线程如何使用NSURLConnection
10)使用block应该注意的地方
11)曾经创建过framework或者library么



### ----------------------------------第二部分--------------------------------------

##### Model层：

数据持久化存储方案有哪些？沙盒的目录结构是怎样的？各自一般用于什么场合？
SQL语句问题：inner join、left join、right join的区别是什么？
sqlite的优化网络通信用过哪些方式（100%的人说了AFNetworking…）如何处理多个网络请求并发的情况
在网络请求中如何提高性能在网络请求中如何保证安全性 语言与基础知识：
内存中的栈和堆的区别是什么？那些数据在栈上，哪些在堆上？
·#define和const定义的变量，有什么区别什么情况下会出现内存的循环引用block中的weak self，是任何时候都需要加的么？
GCD的queue，main queue中执行的代码，一定是在main thread么？
NSOperationQueue有哪些使用方式
NSThread中的Runloop的作用，如何使用？
.h文件中的变量，外部可以直接访问么？（注意是变量，不是property）
讲述一下runtime的概念，message send如果寻找不到相应的对象，会如何进行后续处理 ？
TCP和UDP的区别是什么？
MD5和Base64的区别是什么，各自场景是什么？
二叉搜索树的概念，时间复杂度多少？架构：（我们招的不是架构师，这方面问的不多，而且从之前对APP的架构介绍里可以边听边问）哪些类不适合使用单例模式？即使他们在周期中只会出现一次。
Notification的使用场景是什么？同步还是异步？
简单介绍一下KVC和KVO，他们都可以应用在哪些场景？ APP相关：
如何添加一个自定义字体到工程中
如何制作一个静态库/动态库，他们的区别是什么？
Configuration中，debug和release的区别是什么？
简单介绍下发送系统消息的机制（APNS）

##### UI：

系统如何寻找到需要响应用户操作的那个Responder
多屏幕尺寸的适配
UIButton的父类是什么？UILabel呢？
push view controller 和 present view controller的区别
描述下tableview cell的重用机制
UIView的frame和bounds的区别是什么

#####  最后是几道场景题，也是我最喜欢问的：

发送10个网络请求，然后再接收到所有回应之后执行后续操作，如何实现？
实现一个第三方控件，可以在任何时候出现在APP界面最上层
实现一个最简单的点击拖拽功能。上面那个拖拽之外，如果在手放开时，需要根据速度往前滑动呢？
如何减小一个应用程序的尺寸？
如何提高一个性用程序的性能？
不同版本的APP，数据库结构变化了，如何处理?







































