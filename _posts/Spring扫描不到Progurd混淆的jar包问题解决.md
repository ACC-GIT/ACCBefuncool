title: Spring扫描不到Progurd混淆的jar包问题解决
date: 2014-09-25 10:00:00
categories: 娱乐
tags: 
description:
---
## 假设有两个包com.A和com.B，前者在src目录下，后者在jar包中，如想要Spring能够扫描到com.B，需要保证下面：
#### 1 保证扫描包声明包括jar包里要扫描的路径。可以通过三种方式声明：
1）<context:component-scan base-package="com.A" />
  <context:component-scan base-package="com.B" />
2）<context:component-scan base-package="com.A,com.B" />
3）<context:component-scan base-package="com.*" />
#### 2 保证jar包生成时勾选如下图（主要是为了将包信息也包含进jar包去，因为spring是按路径扫描的，需要这个）![](http://img.blog.csdn.net/20140925095656261?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
#### 3 保证progurd混淆参数有设置如下选项（原因同2）
![](http://img.blog.csdn.net/20140925095714984?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
