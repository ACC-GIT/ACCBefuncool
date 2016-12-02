title: 快速开发Adapter（源码）
date: 2014-08-20 01:22:00
categories: 娱乐
tags: 
description:
---
先来看目前按照普通方法实现adapter会遇到的问题：
1  adapter似乎要处理太多东西，如一个List数据，还要实现BaseAdapter继承下来的getCount、getItem、getItemId等方法。
2  setOnItemClickListener似乎使得代码看上去比较不完善，能否直接点击的回掉方法的参数就是所关心的数据。
3  普通实现的ViewHolder似乎要写很多代码，要写ViewHolder类等等。

针对上面问题可以做如下处理：
1  adapter其实可以抽象出一个类来，负责处理List数据的相关逻辑，只需将List里面的数据做泛型处理，如例子程序中的ACCBaseAdapter实现（代码截图1）。
2  针对问题2的setOnItemClickListener的问题其实也通过我们自己写一个点击监听事件来回掉解决，如ACCBaseAdapter中的onItemClickListener成员的实现。
3  针对问题3的ViewHolder，这里借用网上实现得较好的接口，即通过SparseArray的get的方式代替findViewById这个耗内存的方式。

代码截图：
1  通过泛型的方式，将一些通用的逻辑和数据实现在一个抽象基类中。
![](http://img.blog.csdn.net/20140820014902275?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

2  通过自己实现点击事件来人性化setOnItemClickListener:

 1）基础adapter中进行相关事件处理：
![](http://img.blog.csdn.net/20140822110814625?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
  2 ）listView只需这样设置listener:
![](http://img.blog.csdn.net/20140820015736702?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
  
3  通过用一个较好的接口，完全抛弃ViewHolder那大堆代码（此接口放在基础adapter类中），最后达到的效果是，一个adapter实现只需这样：
![](http://img.blog.csdn.net/20140820020131139?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

具体的项目源码：
[https://github.com/AfirSraftGarrier/TickFastAdapter](https://github.com/AfirSraftGarrier/TickFastAdapter)

