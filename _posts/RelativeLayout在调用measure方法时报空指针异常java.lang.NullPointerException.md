title: RelativeLayout在调用measure方法时报空指针异常java.lang.NullPointerException
date: 2015-05-08 19:54:00
categories: 娱乐
tags: [RelativeLayout, measure, java.lang.NullPointe, LayoutParams, 空指针]
description:
---
原因：由于系统的不完善，RelativeLayout在调用measure方法时LayoutParams还没有初始化，具体可参考[onMeasure()](http://androidxref.com/2.3.6/xref/frameworks/base/core/java/android/widget/RelativeLayout.java#300)接口。
解决：在调用measure前，可以调用View的getLayoutParams方法，如果没有则设置LayoutParams。
	
