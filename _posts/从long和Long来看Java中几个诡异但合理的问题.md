title: 从long和Long来看Java中几个诡异但合理的问题
date: 2015-06-25 11:31:00
categories: 娱乐
tags: [常量池, 堆内存, Long, 默认值, JVM]
description:
---
问题：比如有时候进行JSON数据网络传输，客户端我们用long来表达，但服务端我们用了Long，有时候我们希望Long为null（比如有些自增ID不能设置ID值），但总是有值，搞了半天莫名其妙。
解决：将客户端的long改为Long。
原因：原来是我们客户端并没有设置ID，但是由于使用了long，这样默认值就是0，服务端解析的时候就成了0。
分析：long类型如果是局部变量则编译器要求初始化。而其他情况默认值是0。
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
问题：直接看下面的代码：


```java
	Long a1 = 1l;
	Long b1 = 1l;
	System.out.println(a1 == b1);
	Long a2 = new Long(1);
	Long b2 = 1l;
	System.out.println(a2 == b2);
```

有时候不注意就会遇到这种问题，两个Long用==进行比较，然后自己也莫名其妙了一下。
解决：对于Long用equals代替==。
原因：==比较的内存地址。
分析：如上面代码，1l的内存地址存在于JVM的常量池中，a1和b1都指向这个地址，所以a1==b1为true。a2是通过new得到的一个在堆内存中的地址，肯定和常量池中的1l内存地址不等，所以a2==b2 为false。
题外：equals是Object的方法，默认是比较内存地址，但如果覆盖了就不一样，下面来看Long的覆盖：



```java
public boolean equals(Object obj) {
        if (obj instanceof Long) {
            return value == ((Long)obj).longValue();
        }
        return false;
}
```

可以看到这是比较Long的value常量，所以...
代码：[https://github.com/ACC-GIT/ACCTestJava/blob/master/src/com/acc/test/java/LongTest.java](https://github.com/ACC-GIT/ACCTestJava/blob/master/src/com/acc/test/java/LongTest.java)

