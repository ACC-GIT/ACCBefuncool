title: 如何将ApiDemos嵌入到自己的工程当中
date: 2016-12-01 16:48:12
tags: android
category: android
---

<img src="http://afirsraftgarrier.qiniudn.com/apidemos.jpg" class="full-image" />

题目看起来比较简单，考察的却是很多能力，要做好没那么简单。

有许多人，用开源框架用得很六，但很多基本的原理都不知道。很多android API在`ApiDemos`这个项目里面都已经有例子，里面很多DEMO是值得我们去学习的，但实际是很多人都没有认真去看。现在比较流行用`gradle`来构建工程，可是找了半天，很难找到`ApiDemos`的`gradle`工程，有的也是比较旧的，错误百出。于是自己做了一个，如果你想看可以[来这](https://github.com/AfirSraftGarrier/ACCDemoAndroid)。下面总结一下将`ApiDemos`这个工程导入自己工程要注意的东西。

###### 怎么下载到较新的`ApiDemos`源码？有这几种方法：

1. SDK自带，在SDK的`sample`目录下，这样要看SDK版本是否较新，还有之前有没有选择下载。
2. 网上搜索。这可能是最笨拙的方法，下载到也可能编译错误一大堆。
3. 到android `Github`[镜像](https://github.com/android/platform_development/tree/master/samples/ApiDemos)下载。注意这里只要下载GITHUB工程的一部分，所以要用SVN下载，并且下载路径中的`tree/master`要换成`trunk`。
3. 直接到[官网](https://android.googlesource.com/platform/development.git)下载，这个可以直接下文件夹就可以。

###### 怎么讲`ApiDemos`从`eclipse`工程变成`gradle`工程？有这些方法：

1. 可以先用eclipse导出一个`build.gradle`文件，然后用android studio通过`gradle`文件导入工程。
2. 用AS导入工程的时候选择`Eclipse ADT...`，这样很方便，但也不一定成功。

###### 项目中的一些问题

想不到像`google`这么大的公司也这么不重视细节，非常好的项目，却有这些低级问题。来说说遇到的问题和解决方法。

* `preference_switch`不是xml文件问题，解决方法就是将其改为xml文件。
* No resource found that matches the given name (at 'style' with value '@android:style/Widget.Material.SeekBar.Discrete')。如果遇到这类错误，请把鼠标移动到错误代码上，它会提示你怎么做。答案是要修改`compileSdkVersion`到合适的版本。
* 程序包android.support.annotation不存在，这里有几种方法，可以通过`project structure`中添加`maven`依赖，也可以直接在`gradle`文件中添加依赖代码。这里是要添加`v4`依赖，当然也可以添加`v7`依赖，要注意`gradle`的语法，可以用`+`代替具体的版本号。另外有些错误，其实看工具提示就可以解决。
* com.google.android.mms找不到的问题，这个真搞不懂谷歌要做什么，这个包在SDK当中，有`@hide`标注，是不开放的。因此我们是无法在自己代码中import的。解决方法：可以自己修改源码，编一个SDK，太麻烦；可以自己用反射来实现，这样要修改`ApiDemos`大堆源码，很不方便；直接删掉相关demo，这个方法简单粗暴；将错误的地方注释掉，嗯，这个方法可以让它有个demo界面，但功能先暂时不管，比较可取。

###### 如何将`ApiDemos`导入到自己的工程

也许这个问题很少人会去想。这也考验人解决项目集成问题能力，而不仅仅是在`gradle`里面加个`EventBus`库这么简单。考虑到要做个DEMO，这个demo要包含`ApiDemo`，而且包名要用自己的。有人说改个包名就可以了，很简单。但这里其实有许多问题要处理。

* 首先将要集成的代码拷贝到相应的位置。这是后会有很多包名错误，不用管先。
* 资源文件全局搜索，将包名改过来。
* 代码全局搜索，将包名改过来。
* AIDL文件也用同样要修改。注意AIDL要放在aidl目录下，即本文的插图那样形式。
* 将Manifest文件改过来，注意这是需要技巧的，很容易将文件改错，注意搜索匹配问题。
* 按照原来的逻辑修改，这要熟悉下`ApiDemos.java`的巧妙逻辑(巧妙运用了activity的`name`和`label`标签)。

这里面做一些android的多个DEMO集成可以考虑下参考`ApiDemos.java`的实现。如果要在原来的基础上加上一层目录的话，可以参考下[这里](https://github.com/AfirSraftGarrier/ACCDemoAndroid/blob/master/app/src/main/java/afirsraftgarrier/demoandroid/MainActivity.java)的修改。

