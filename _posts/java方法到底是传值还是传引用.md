title: Java方法到底是传值还是传引用
date: 2016-11-25 23:44:53
tags: java
category: java
---

先来看[代码](https://github.com/AfirSraftGarrier/ACCDemoJava/blob/master/src/com/acc/demo/java/pre/ExecutorServiceTest.java)：

```java
public class MethodParamTest {
    private static void change(int intNumm) {
        intNumm = 10;
    }

    private static void change(String string) {
        string = "Another string...";
    }

    private static void change(StringBuilder stringBuilder) {
        stringBuilder.append(" append...");
    }

    private static class TestClass {
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        private String name;
    }

    private static void change(TestClass testClass) {
        testClass.setName("Hi, i'm changed...");
    }

    public static void main(String args[]) {
        int intNum = 99;
        change(intNum);
        System.out.println("After change, intNum is: " + intNum);
        String string = "Original string...";
        change(string);
        System.out.println("After change, string is: " + string);
        StringBuilder stringBuilder = new StringBuilder(string);
        change(stringBuilder);
        System.out.println("After change, stringBuilder is: " + stringBuilder);
        TestClass testClass = new TestClass();
        testClass.setName("Hi, i'm acc...");
        change(testClass);
        System.out.println("After change, testClass's name is: " + testClass.getName());
    }
}
```
先来看看输出结果：
```
After change, intNum is: 99
After change, string is: Original string...
After change, stringBuilder is: Original string... append...
After change, testClass's name is: Hi, i'm changed...
```
我们发现这里有个疑惑，为什么`string`的值没有改变呢？我们都说`String`是一个引用类型。既然是引用类型，那应该是要变化才对啊。如果有`c/c++`知识的话，这里就更加迷惑。这里面究竟有什么道理呢？

首先我们来看Java里面的`=`是怎样操作的，也就可以理解传参数的时候，到底怎么传的。我们知道，对于变量，都会在栈内存里面分配一个地址，然后在后面跟着存放变量的值。这个变量的值，对于基本数据类型来讲是对应的基本数值，而对于引用变量来讲则是指向堆内存的一个内存地址(也就是引用变量的对象地址)。我们这里不管这个值是什么，姑且都叫做`变量的值`。这样定义之后，Java的`=`就好解释了，它就是将`=`右边变量的值拷贝到左边。传递参数也是这样，没什么神秘的。

那好了，既然上文`string`是引用变量，传递参数时，将其变量值即堆内存里面对象地址传了过去，为什么还是那样的结果呢？秘密同样在这个`=`，对于`String`(对于基本类型包装类一样)，`"A String"`其实是在编译器已确定好的，对应`常量池`中的一块内存地址，这样也就是说`string = "Another string..."`就相当于将`String`变量的数值地址改变，而不是改变原来地址对应对象的值，因此调用`change`方法后，并没有改变，这也就解决了迷惑了。

## 总结

* Java传递参数的时候，可以说都是传值的，这个值对于基本类型来讲，就是数值；对于引用来讲，就是对象地址。
* 注意[常量池](http://baike.baidu.com/item/常量池)的概念，将一个字符串赋值给变量时，其实是要将这个变量的对象地址改变的。