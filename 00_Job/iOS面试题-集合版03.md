### iOS面试题-集合版02

----

### ----------------------------------第一部分--------------------------------------


##### 基础篇

Objective-C的类可以多重继承么?可以采用多个协议么?

不可以多重继承,可以采用多个协议.

objc使用什么机制管理对象内存？

MRC 手动引用计数
ARC 自动引用计数,现在通常使用自动引用计数

import 跟#include 又什么区别，@class呢, ＃import<> 跟 #import””又什么区别？

import是Objective-C导入头文件的关键字，#include是C/C++导入头文件的关键字,使用#import头文件会自动只导入一次，不会重复导入，相当于#include和#pragma once；@class告诉编译器某个类的声明，当执行时，才去查看类的实现文件，可以解决头文件的相互包含；#import<>用来包含系统的头文件，#import””用来包含用户头文件。

描述一下iOS SDK中如何实现MVC的开发模式

MVC是模型、试图、控制开发模式，对于iOS SDK，所有的View都是视图层的，它应该独立于模型层，由视图控制层来控制。所有的用户数据都是模型层，它应该独立于视图。所有的ViewController都是控制层，由它负责控制视图，访问模型数据。

浅复制和深复制的区别？

浅层复制：只复制指向对象的指针，而不复制引用对象本身。
深层复制：复制引用对象本身。
意思就是说我有个A对象，复制一份后得到A_copy对象后，对于浅复制来说，A和A_copy指向的是同一个内存资源，复制的只不过是是一个指针，对象本身资源
还是只有一份，那如果我们对A_copy执行了修改操作,那么发现A引用的对象同样被修改，这其实违背了我们复制拷贝的一个思想。深复制就好理解了,内存中存在了
两份独立对象本身。

category是什么? 扩展一个类的方式用继承好还是类目好? 为什么?

category是类目.用类目好,因为继承要满足A is a B的关系,而类目只需要满足A has a B的关系,局限性更小,你不用定义子类就能扩展一个类的功能,还能将类的定义分开放在不同的源文件里,用category去重写类的方法,仅对本category有效,不会影响到其他类与原有类的关系。

延展是什么? 作用是什么?

延展(extension):在自己类的实现文件中添加类目来声明私有方法。

解释一下懒汉模式?

懒汉模式，只在用到的时候才去初始化。
也可以理解成延时加载。
我觉得最好也最简单的一个列子就是tableView中图片的加载显示了。
一个延时载，避免内存过高，一个异步加载，避免线程堵塞。

##### 进阶篇

@property中有哪些属性关键字？

属性可以拥有的特质分为四类:

原子性—- nonatomic 特质
在默认情况下，由编译器合成的方法会通过锁定机制确保其原子性(atomicity)。如果属性具备 nonatomic 特质，则不使用同步锁。请注意，尽管没有名为“atomic”的特质(如果某属性不具备 nonatomic 特质，那它就是“原子的” ( atomic) )，但是仍然可以在属性特质中写明这一点，编译器不会报错。若是自己定义存取方法，那么就应该遵从与属性特质相符的原子性。

读/写权限—-readwrite(读写)、readonly (只读)

内存管理语义—-assign、strong、 weak、copy
方法名—-getter= 、setter=

你经常使用一些第三方库有哪些?

	AFNetworking
	SDWebImage
	FMDB
	JSONKit
	MJRefresh
	MJExtension
	Masonry
	友盟，shareSDK等三方库。

你经常用的设计模式有哪些？

	MVC
	代理模式
	观察者模式
	单例模式
	工厂模式

本地存储有哪些方式？

	属性列表（NSUserDefault 或 plist）
	对象归档 （NSKeyedArchiver）
	SQLite
	CoreData

weak属性需要在dealloc中置nil么？

不需要,在ARC环境无论是强指针还是弱指针都无需在deallco设置为nil,ARC会自动帮我们处理。

@synthesize和@dynamic分别有什么作用？

1. @property有两个对应的词，一个是@synthesize，一个是@dynamic。如果@synthesize和@dynamic都没写，那么默认的就是@syntheszie var = _var;
2. @synthesize的语义是如果你没有手动实现setter方法和getter方法，那么编译器会自动为你加上这两个方法。
3. @dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成。

用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改
用strong关键字，可能造成什么问题？

因为父类指针可以指向子类对象,使用copy的目的是为了让本对象的属性不受外界影响,使用copy无论给我传入是一个可变对象还是不可对象,我本身持有的就是一个不可变的副本.
如果我们使用是strong,那么这个属性就有可能指向一个可变对象,如果这个可变对象在外部被修改了,那么会影响该属性.
什么时候会报unrecognized selector的异常？

当该对象上某个方法,而该对象上没有实现这个方法的时候

使用block时什么情况会发生引用循环，如何解决？

只要是一个对象对该block进行了强引用,在block内部有直接使用到该对象。
解决方案：__weak id weakSelf = self;
使用系统的某些block api（如UIView的block版本写动画时），是否也考虑引用循环问题？

一般不用考虑,因为官方文档中没有告诉我们要注意发生强引用,所以推测系统控件一般没有对这些block进行强引用,所以我们可以不用考虑循环强引用的问题

GCD的队列（dispatch_queue_t）分哪两种类型？

串行队列和并行队列

如何用GCD同步若干个异步调用？（如根据若干个url异步加载多张图片，然后在都下载完成后合成一张整图）

总体上说: 使用 dispatch group，然后 wait forever 等待完成， 或者采取 group notify 来通知回调。
 
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_group_t group = dispatch_group_create();
	dispatch_group_async(group, queue, ^{ /*加载图片1 */ });
	dispatch_group_async(group, queue, ^{ /*加载图片2 */ });
	dispatch_group_async(group, queue, ^{ /*加载图片3 */ }); 
	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
	        // 合并图片
	})

以下代码运行结果如何？

只能输出1,然后线程主线程死锁
 
	- (void)viewDidLoad
	{
	    [super viewDidLoad];
	    NSLog(@"1");
	    dispatch_sync(dispatch_get_main_queue(), ^{
	        NSLog(@"2");
	    });
	    NSLog(@"3");
	}

若一个类有实例变量NSString *_foo，调用setValue:forKey:时，可以以foo还是_foo作为key？

都可以

IBOutlet连出来的视图属性为什么可以被设置成weak?

因为视图已经对它有一个强引用了

你单例怎么理解怎么用的?

Singleton Pattern单例设计模式，通过单例模式可以保证系统中一个类只有一个实例而且该实例易于外界访问，从而方便对实例个数的控制并节约系统资源。如果希望在系统中某个类的对象只能存在一个，单例模式是最好的解决方案。类只能有一个实例，而且必须从一个为人熟知的访问点对其进行访问，比如工厂方法。这个唯一的实例只能通过子类化进行扩展，而且扩展的对象不会破坏客户端代码。例如，UIApplication的sharedApplication方法，任何时候都会返回一个当前应用程序的UIApplication实例。

lldb（gdb）常用的调试命令？

最常用就是 : po 对象

什么是谓词？

谓词是通过NSPredicate，是通过给定的逻辑条件作为约束条件，完成对数据的筛选。

+(void)load; +(void)initialize; 的区别？

	+(void)load; 在程序运行后立即执行。
	+(void)initialize; 在类的方法第一次被调时执行.

什么是KVC，什么是KVO？

kvc:键 - 值编码是一种间接访问对象的属性使用字符串来标识属性，而不是通过调用存取方法，直接或通过实例变量访问的机制。
kvo:键值观察机制，他提供了观察某一属性变化的方法，极大的简化了代码。

什么时候用delegate，什么时候用Notification？

delegate针对one-to-one关系，并且reciever可以返回值 给sender，notification 可以针对one-to-one/many/none,reciever无法返回值给sender.所以，delegate用于sender希望接受到 reciever的某个功能反馈值，notification用于通知多个object某个事件

block和weak区别？

__block不管是ARC还是MRC模式下都可以使用，可以修饰对象，还可以修饰基本数据类型。
__weak只能在ARC模式下使用，也只能修饰对象（NSString），不能修饰基本数据类型（int）。
block对象可以在block中被重新赋值，weak不可以。

frame和bounds有什么不同？

frame指的是：该view在父view坐标系统中的位置和大小。（参照点是父亲的坐标系统）bounds指的是：该view在本身坐标系统中 的位置和大小。（参照点是本身坐标系统）

UIView和CALayer有什么不同？

两者最大的区别是,图层不会直接渲染到屏幕上，UIView是iOS系统中界面元素的基础，所有的界面元素都是继承自它。它本身完全是由CoreAnimation来实现的。它真正的绘图部分，是由一个CALayer类来管理。UIView本身更像是一个CALayer的管理器。一个UIView上可以有n个CALayer，每个layer显示一种东西，增强UIView的展现能力。

TCP和UDP的区别？

TCP：（传输控制协议），提供面向连接的、可靠地点对点的通信；
UDP：（用户数据报协议），提供非连接的不可靠的点对多点的通信；
实际运用中，看程序注重的是哪一方面，是可靠还是快速；
socket连接与http连接

http连接：短连接。即客户端向服务端发送一次请求，服务端响应之后，链接即会断掉；
socket连接：长连接。即客户端一旦与服务器建立接连，便不会主动断掉。
HTTP 的post与get区别与联系，实践中如何选择它们?

get是从服务器上获取数据，post是向服务器传送数据。
在客户端，Get方式在通过URL提交数据，数据在URL中可以看到；POST方式，数据放置在HTML HEADER内提交。
对于get方式，服务器端用Request.QueryString获取变量的值，对于post方式，服务器端用Request.Form获取提交的数据。
GET方式提交的数据最多只能有1024字节，而POST则没有此限制。
安全性问题。正如在（1）中提到，使用 Get 的时候，参数会显示在地址栏上，而 Post 不会。所以，如果这些数据是中文数据而且是非敏感数据，那么使用 get；如果用户输入的数据不是中文字符而且包含敏感数据，那么还是使用 post为好。
Http定义了与服务器交互的不同方法，最基本的方法有4种，分别是GET，POST，PUT，DELETE。URL全称是资源描述符，我们可以这样认为：一个URL地址，它用于描述一个网络上的资源，而HTTP中的GET，POST，PUT，DELETE就对应着对这个资源的查，改，增，删4个操作。GET一般用于获取/查询资源信息，而POST一般用于更新资源信息。
检查内存管理问题的方式有哪些

点击Xcode顶部菜单中的ProductàAnalyze。这种方法主要可以查看内存泄露，变量未初始化，变量定义后没有被使用到
使用Instrument工具检查。点击Xcode顶部菜单中的Product Profile，弹出一个界面，选择左侧的Memory后，再选右侧的Leaks。
人工检查
谈安卓与苹果的优缺点

苹果系统优点是左右流畅，软件多，界面华丽，图标统一，很美观；缺点是系统封闭，不允许用户过多的个性化设置，而且只能在苹果手机上用。安卓系统优点是开放，可以自己扩展的东西很多，支持的硬件也多，各个价位的手机都有；缺点就是软件太杂乱，兼容性有问题，图标混乱不美观。iOS的确比android流畅，这仅仅体现在较大软件切换时，其他差不多流畅，iOS并不能做到完全后台，如果它完全后台估计也不会比安卓流畅多少。反之，如果安卓只是注重单个运行，流畅度也会大大提升，iOS系统更新没有android那么频繁，爱体验的人会选安卓，那些怕烦的会选iOS。iOS的硬件需求选不及android，以至于android机会相对iOS较热，较费电额。

大神篇

运行时你是怎么理解的?

ObjC Runtime 其实是一个 Runtime 库，基本上用 C 和汇编写的，这个库使得 C 语言有了面向对象的能力（脑中浮现当你乔帮主参观了施乐帕克的 SmallTalk 之后嘴角一抹浅笑）。这个库做的事前就是加载类的信息，进行方法的分发和转发之类的。OC是一种面向runtime(运行时)的语言，也就是说，它会尽可能地把代码执行的决策从编译和链接的时候，推迟到运行时。这给程序员写代码带来很大的灵活性，比如说你可以把消息转发给你想要的对象，或者随意交换一个方法的实现之类的。这就要求runtime能检测一个对象是否能对一个方法进行响应，然后再把这个方法分发到对应的对象去。

@protocol 和 category 中如何使用 @property

在 protocol 中使用 property 只会生成 setter 和 getter 方法声明,我们使用属性的目的,是希望遵守我协议的对象能实现该属性
category 使用 @property 也是只会生成 setter 和 getter 方法的声明,如果我们真的需要给 category 增加属性的实现,需要借助于运行时的两个函数：
objc_setAssociatedObject
objc_getAssociatedObject
runtime如何通过selector找到对应的IMP地址？

每一个类对象中都一个方法列表,方法列表中记录着方法的名称,方法实现,以及参数类型,其实selector本质就是方法名称,通过这个方法名称就可以在方法列表中找到对应的方法实现.

一个objc对象如何进行内存布局？

所有父类的成员变量和自己的成员变量都会存放在该对象所对应的存储空间中.
每一个对象内部都有一个isa指针,指向他的类对象,类对象中存放着本对象的
对象方法列表（对象能够接收的消息列表，保存在它所对应的类对象中）
成员变量的列表,
属性列表, 

### ----------------------------------第二部分--------------------------------------









































