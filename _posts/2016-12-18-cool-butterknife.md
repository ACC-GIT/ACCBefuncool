---
date: '2016-12-18 18:04 +0800'
published: true
title: cool-butterknife
category:
  - 开源
tags:
  - 开源
titile: 简析Butterknife
---
{% cq Butterknife的作用是绑定，不是注入。 %}
## Butterknife概念

基本上有点年纪的开发人员都被`findViewById`烦过，枯燥无味，但还必须得写。Butterknife就是帮我们干这事的。

## 怎么用

### 1. Gradle引入
```
dependencies {
    compile 'com.jakewharton:butterknife:8.4.0'
    annotationProcessor 'com.jakewharton:butterknife-compiler:8.4.0'
}
```
### 2. 调用绑定
在需要绑定的地方调用`ButterKnife.bind`，注意这个方法有好几种绑定方式，也即Butterknife的几种作用方式，可以看接口说明了解。这个方法会返回一个`Unbinder`，在需要的时候，可以将之前的绑定撤销。

## 3. 写绑定注解
可以在[`AS`](http://www.befuncool.com/2016/11/12/JetBrains快捷键汇总)里面键入`@Bind`，在下拉提示框中查看Butterknife提供的成员变量绑定功能。可以键入`@On`看下拉提示框来了解Butterknife提供的绑定方法功能。

## 4. 参考
可以参考这个[DEMO](https://github.com/AfirSraftGarrier/ACCDemoAndroid/blob/master/app/src/main/java/afirsraftgarrier/demoandroid/framework/butterknife/ButterknifeMain.java)，也可以参考[官方介绍](http://jakewharton.github.io/butterknife/)。

## 原理简述
可以看看其引入的包就知道大致原理，如前所列，需要一个`annotationProcessor`，这个是在编译器作用的，大致就是对注解进行解析，生成绑定相关代码。而另外一个库显然就是运行时用的，即`ButterKnife.bind`之所在。我们可以一窥编译器生成代码的美貌（在`/build/generated/source/apt/`目录下）：

```
// Generated code from Butter Knife. Do not modify!
package afirsraftgarrier.demoandroid.framework.butterknife;

import afirsraftgarrier.demoandroid.R;
import android.support.annotation.CallSuper;
import android.support.annotation.UiThread;
import android.view.View;
import android.widget.TextView;
import butterknife.Unbinder;
import butterknife.internal.DebouncingOnClickListener;
import butterknife.internal.Utils;
import java.lang.IllegalStateException;
import java.lang.Override;

public class ButterknifeMain_ViewBinding<T extends ButterknifeMain> implements Unbinder {
  protected T target;

  private View view2131755126;

  @UiThread
  public ButterknifeMain_ViewBinding(final T target, View source) {
    this.target = target;

    View view;
    view = Utils.findRequiredView(source, R.id.tv_hello, "field 'helloTextView' and method 'change'");
    target.helloTextView = Utils.castView(view, R.id.tv_hello, "field 'helloTextView'", TextView.class);
    view2131755126 = view;
    view.setOnClickListener(new DebouncingOnClickListener() {
      @Override
      public void doClick(View p0) {
        target.change();
      }
    });
  }

  @Override
  @CallSuper
  public void unbind() {
    T target = this.target;
    if (target == null) throw new IllegalStateException("Bindings already cleared.");

    target.helloTextView = null;

    view2131755126.setOnClickListener(null);
    view2131755126 = null;

    this.target = null;
  }
}
```
可以看到里面其实也没做什么新奇的事情，就是将我们的原来枯燥的绑定相关代码生成。关于绑定，其实也可以在运行期用反射来实现，但是这显然比这样在编译器生成绑定代码的方式要消耗。这样的生成代码的功能是借助了java的`APT`（Annotation Processing Tool），如果我们想实现类似的功能，即编译期间自动根据注释来做相关的事情，其实可以参考下Butterknife库的写法。

## 相关问题

### 1. Butterknife跟[Dagger](http://www.befuncool.com/2016/12/18/2016-12-18-cool-dagger)的异同

这两者都出自同一个作者。其作者也在官网上也说了：`A butter knife is like a dagger only infinitely less sharp`。实际上是说Butterknife做的事情更专，只是针对`View`，只能用在Android平台上。实际上，其做的事情不是注入之类的，而是做View相关的绑定工作。一句话：`Bind Android views and callbacks to fields and methods`，即绑定View以及设置监听相关事情。

