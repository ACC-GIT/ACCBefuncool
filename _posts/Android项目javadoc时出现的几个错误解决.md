title: Android项目javadoc时出现的几个错误解决
date: 2015-06-16 12:36:00
categories: 娱乐
tags: [android, javadoc, GBK的不可映射字符, 错误 找不到符号, options]
description:
---
### 错误: 编码`GBK`的不可映射字符
> * 
解决：设置`Extra Javadoc options`为`-encoding UTF-8 -charset UTF-8`如下图：

![不可映射字符解决](http://img.blog.csdn.net/20150616123444404?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

### 错误：错误: 找不到符号

> * 解决：很有可能是`android.jar`包找不到，到sdk目录将其拷贝到项目的lib目录下即可。
