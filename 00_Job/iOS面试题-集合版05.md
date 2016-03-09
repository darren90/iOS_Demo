### iOS面试题-集合版02

----

### ----------------------------------第一部分--------------------------------------

1：Xcode项目的目录结构是怎么分组的
一级目录按照模块份
二级目录按照模块内的功能分：Model，view,controller，
工具类可以一个单独的category目录

2：真机调试步骤
1，mac生成cer文件：告诉那台电脑进行真机调试
2：添加APP IDs，
3：添加Devices：添加真机设备
4：下载Privinsioning Profiles文件，下载双击即可

3:控制器声明周期

1）启动程序
willFinishLaunchingWithOptions
didFinishLaunchingWithOptions
applicationDidBecomeActive
2）按下home键
applicationWillResignActive
applicationDidEnterBackground
3）双击home键，再打开程序
applicationWillEnterForeground
applicationDidBecomeActive
4）当程序将要退出是被调用，通常是用来保存数据
applicationWillTerminate
4：
协议的定义格式：
@protocol 协议名 <父协议>
定义方法
@end
注：定义协议的关键字是@protocol,同时协议也是可以继承父协议的

@required：这个表示这个方法是其他类必须实现的，也是默认的值
@optional：这个表示这个方法对于其他类实现是可选的

5：修饰类型
copy:NSString/NSMutableString\block 希望获得源对象的副本而不改变源对象内容
strong: 一般对象，其他OC对象 希望获得源对象的所有权时
weak：UI控件，代理
assign：基本数据类型，int ，float，枚举，结构体 对基础数据类型

6：ios程序中数据数据存储

XML属性列表（plist）归档

Preference(偏好设置)

NSKeyedArchiver归档(NSCoding)

SQLite3

Core Data

7：代理的作用

委托代理（degegate），目的是改变和传递控制链

顾名思义，把某个对象要做的事情委托给别的对象去做。那么别的对象就是这个对象的代理，代替它来打理要做的事。反映到程序中，首先要明确一个对象的委托方是哪个对象，委托所做的内容是什么。

委托机制是一种设计模式。

8：通知：

需要有一个通知中心：NSNotificationCenter 然后监听。删掉前必须移除监听者。

代理：

设置代理对象，某一时间只能有一个委托连接到某一对象。

9：判断一个类是否属于某个类：isKindOfClass

10：UIViewController的生命周期及iOS程序执行顺序

当一个视图控制器被创建，并在屏幕上显示的时候。 代码的执行顺序
1、 alloc 创建对象，分配空间
2、init (initWithNibName) 初始化对象，初始化数据
3、loadView 从nib载入视图 ，通常这一步不需要去干涉。除非你没有使用xib文件创建视图
4、viewDidLoad 载入完成，可以进行自定义数据以及动态创建其他控件
5、viewWillAppear 视图将出现在屏幕之前，马上这个视图就会被展现在屏幕上了
6、viewDidAppear 视图已在屏幕上渲染完成
当一个视图被移除屏幕并且销毁的时候的执行顺序，这个顺序差不多和上面的相反
1、viewWillDisappear 视图将被从屏幕上移除之前执行
2、viewDidDisappear 视图已经被从屏幕上移除，用户看不到这个视图了
3、dealloc 视图被销毁，此处需要对你在init和viewDidLoad中创建的对象进行释放

自定义cell：
1：xib：cell的布局相对固定
2：代码：每个cell均不同

//设置tableview尾部显示的控件（footerView的宽度永远是tablev的宽度）
//footer只需要设置高度
self.tableView.tableFooterView = [UIButton buttonWithType:UIButtonTypeContactAdd];

如何封装一个View
1：新建一个xib文件，描述view内部的结构
2：新建一个新的类，继承自系统自带的view，继承自哪个类，取决于xib文件跟对象的class
3：新建的类名，最好个xib文件名一致
4:将xib中的控件和自定义的类连线
5:提供一个类方法，快速返回一个自定义的view。（屏蔽从xib加载的过程）

模型需要访问控制器的内容时，要用到代理

谁主动监听，谁是代理]
代理对象用weak

总结：
协议名称：控件名称+Delegate
代理方法：

thunderboit
thunder

ios中分割线是通过UIView做的，把其高度设为1，即可

//init：通过代码创建，初始化一个对象的时候，才会调用

//当一个对象，从xib中创建，舒适化完毕的时候，就会调用一次

代码自定义cell(cell高度不一致)
1：新建一个继承自UitableviewCell的类
2：（重写initWithStyle）在构造方法中，添加所有需要显示的子控件，不需要设置数据和frame，子控件加入到contentView
注：1：cell内部有imageView ，子控件不能叫imageView
2：自定义控件，要加到conentView中
3：进行子控件的一次性初始化，比如：字体，固定的图片

3:提供2个属性，
1：数据模型：存放文字数据，图片数据
2：frame模型：存放数据数据模型，所有子控件的frame，和cell的高度
4：cell应该拥有frame模型（不要直接拥有数据模型）
5：重新frame模型属性的setter方法。在这个方法中设置子控件的显示数据和frame
6：frame模型数据的初始化，在控制器类中采用懒加载的方式。每一个cell对应的frame模型数据只加载一次
注：可把一些不变的放到init方法中，节省内存

通过代码，任何控件都可以添加其他子控件，但是storyboard和xib不能

import <UIKit/UIKit.h>
textView.titleLabel.numberOfLines = 0;//文本换行
//去掉表格之间的分割线
self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//tableview的cell不能选中
self.tableView.allowsSelection = NO;
//设置按钮内边距
textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);

//transform：平移，缩放，旋转

某个控件出不来
1，检查frame的尺寸和位置。
2，hidden属性是否为yes
3，有没有添加到父控件
4，alpha 是否为0
5，被其他控件遮挡住
6，参考父控件的前面5个情况
任何UI控件，调完init方法后，没有宽高

UIView的生命周期是什么样的，执行顺序是怎么样的？
init —— loadView —— viewDidLoad —— viewWillAppear —— viewWillDisappear —— viewDidUnload —— dealloc.
UIViewController在什么时候会加载UIView，换句话说，技术上在哪个时间点会执行loadView。
在view对象第一次被访问的时候，会执行loadView。
写出 UIButton 的正确继承父类和顺序。
-> UIButton - UIControl - UIView - UIResponder - NSObject
. 如何合并多个数据并去除重复元素？
-> 使用 ‘遍历’ 方法的话，可以坚定为对 NSFoundation 不算熟练，和对算法不敏感。

较好的解决方法为 使用 NSSet(不会有重复元素) 或 NSDictionary(不会对重复key插值)
kvc与kvo
 
### ----------------------------------第二部分--------------------------------------









































