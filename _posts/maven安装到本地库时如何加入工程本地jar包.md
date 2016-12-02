title: maven安装到本地库时如何加入工程本地jar包
date: 2015-06-09 19:24:00
categories: 娱乐
tags: [maven, dependency, install, jar, systemPath]
description:
---
maven安装到本地仓库时，需要用到暂无仓库记录的jar包时，可以这样做：
方法一：安装到本地仓库，这种方法最好是别人也能访问的仓库。
1)  mvn install:install-file -Dfile=your_jar_dir\your_jar_file.jar -DgroupId=your_package -DartifactId=your_factId -Dversion=your_version -Dpackaging=jar
2)  注册：

```html
<dependency>
    <groupId>your_package</groupId>
    <artifactId>your_factId</artifactId>
    <version>your_version</version>
</dependency>
```
方法二：直接在注册文件里面写（注意可以用basedir等变量，这样可以相对工程目录设定，比较通用。这里假设jar在libs目录下）：

```html
<dependency>
    <groupId>your_package</groupId>
    <artifactId>your_factId</artifactId>
    <version>your_version</version>
    <scope>system</scope>
    <systemPath>${basedir}/libs/your_jar_file.jar</systemPath>
</dependency>
```
特别提醒：所有jar都必须一个个写，不能用通配符如*.jar。
