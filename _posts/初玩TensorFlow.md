title: 初玩TensorFlow
date: 2016-11-15 19:23:56
tags: [TensorFlow,神经网络,深度学习]
category: 机器学习
---

<img src="/images/tensorflow.png" class="full-image" />

# 简介

* [TensorFlow](https://github.com/tensorflow/tensorflow)是[谷歌大脑](http://research.google.com/teams/brain/)第二代机器学习系统。
* TensorFlow，顾名思义，是Tensor Flow，这里Tensor并非等同[数学上的张量Tensor的理念](https://en.wikipedia.org/wiki/Tensor)(数学上的Tensor理解可[看这](https://www.youtube.com/watch?v=uO_bW2zzrNU))，只是说同样可以用一个多维数组表示，而Flow则是流程的意思。简单说就是多维数组(Tensor)在这个流程(Flow)上跑(运算)。这个流程实际上是`神经网络`，而这个运算实际上要用到`深度学习`算法([关系](http://neuralnetworksanddeeplearning.com/))。
* TensorFlow可以用一张数据流程图来描述整个工作流程，可以通过简单API将其运算部署在多个设备的多个CPU或GPU(利用GPU的运算能力)上，简单说就是能运算的TensorFlow都想利用起来。
* TensorFlow已经被运用到包括语音识别、计算机视觉、机器人、信息检索、自然语言处理、地理信息的提取、计算药物发现等领域。
* Logo是TensorFlow缩写TF的两个角度合成。
* 更多的信息请看[TensorFlow官网](https://www.tensorflow.org)和[TensorFlow白皮书](http://download.tensorflow.org/paper/whitepaper2015.pdf)。
* 可以通过下面这张图大致了解其工作流程：
<!--more-->
![TensorFlow工作流程](https://www.tensorflow.org/images/tensors_flowing.gif)

# 一瞥

TensorFlow说得神乎其神，究竟是什么东西呢？[Talk is cheap. Show me the code](/about).

```
import tensorflow as tf
import numpy as np

# Create 100 phony x, y data points in NumPy, y = x * 0.1 + 0.3
x_data = np.random.rand(100).astype(np.float32)
y_data = x_data * 0.1 + 0.3

# Try to find values for W and b that compute y_data = W * x_data + b
# (We know that W should be 0.1 and b 0.3, but TensorFlow will
# figure that out for us.)
W = tf.Variable(tf.random_uniform([1], -1.0, 1.0))
b = tf.Variable(tf.zeros([1]))
y = W * x_data + b

# Minimize the mean squared errors.
loss = tf.reduce_mean(tf.square(y - y_data))
optimizer = tf.train.GradientDescentOptimizer(0.5)
train = optimizer.minimize(loss)

# Before starting, initialize the variables.  We will 'run' this first.
init = tf.initialize_all_variables()

# Launch the graph.
sess = tf.Session()
sess.run(init)

# Fit the line.
for step in range(201):
    sess.run(train)
    if step % 20 == 0:
        print(step, sess.run(W), sess.run(b))

# Learns best fit is W: [0.1], b: [0.3]
```
一个简单的TensorFlow就这么些代码。注意到有个注释`Launch the graph`,从这句话大致知道，这里开始启动TensorFlow，而前面相当于是对TensorFlow即所谓graph的初始配置。学到后面就会发现，这个TensorFlow其实是要通过`回归模型`去拟合直线`y = x * 0.1 + 0.3`。

# 安装

#### 说明

* 这里的环境是`Ubuntu 64-bit`/`Python 2.7`，其他环境请到[这里](https://www.tensorflow.org/versions/master/get_started/os_setup.html)查找自己相关配置。
* 这里只进行CPU测试，没有GPU。

#### 步骤

* 如果没有安装`pip`：
```
sudo apt-get install python-pip python-dev
```
* 这步请选择自己对应版本的`TF_BINARY_URL`路径：
```
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0rc2-cp27-none-linux_x86_64.whl
```
* 安装TensorFlow:
```
sudo pip install --upgrade $TF_BINARY_URL
```

#### 测试是否安装成功

* 打开一个终端按照下面输入，没有问题的话就说明安装成功了：
```
$ python
...
>>> import tensorflow as tf
>>> hello = tf.constant('Hello, TensorFlow!')
>>> sess = tf.Session()
>>> print(sess.run(hello))
Hello, TensorFlow!
>>> a = tf.constant(10)
>>> b = tf.constant(32)
>>> print(sess.run(a + b))
42
>>>
```
* 我们可以通过下面语句查看TensorFlow的安装目录
```
python -c 'import os; import inspect; import tensorflow; print(os.path.dirname(inspect.getfile(tensorflow)))'
# 可以得到类似这样的目录：
# /usr/local/lib/python2.7/dist-packages/tensorflow
```

# 基本用法

#### 关于TensorFlow必须知道的几点：

* 用`graph`(数据流程图)描述计算过程。
* 图`graph`要在`session`(会话)的上下文中执行。
* 用`tensor`来描述数据。
* 用`variable`来维护状态。
* 用`feed`/`fetch`来对`op`进行输入/输出数据。

#### 概览

TensorFlow是一个可以用`graph`来描述计算过程的编程系统。`graph`包含图的节点即代表运算的`op`(operation)，还包含节点之间流动的代表数据的多维数组`Tensor`。一个op将0个或多个Tensor，通过某些计算，产生0个或多个Tensor。关于`graph`的数据结构和构建过程详细可看[这里](https://www.tensorflow.org/versions/r0.11/api_docs/python/framework.html#core-graph-data-structures)。

`graph`要想做任何`op`，必须要在一个`session`中启动。`session`将`graph`的`op`分配到各种计算设备上(比如CPU/GPU)，并且提供执行`op`的方法，只要需要的`Tensor`准备好后，将异步/并行地执行这些方法，方法返回的数据类型为[numpy ndarray](https://docs.scipy.org/doc/numpy/reference/generated/numpy.ndarray.html)(这个是python上的类型，后面验证)。

#### `graph`的工作流程

通常的做法是，先构建好一个代表问题的`graph`，然后在执行阶段重复执行训练`op`。

##### 构建和运行`graph`

要构建`graph`，首先构建不需要任何输入的`op`(源op)开始。这里选取`constant op`(生产常量`Tensor`的`op`)做为源op。

```
#!/usr/bin/python
# -*- coding: UTF-8 -*-

import tensorflow as tf

print 'Begin build graph...'
# 创建一个生产1x2 矩阵[[3., 3.]]的constant op。这个op将会作为一个node加入默认的graph中。
# 返回值类型为Tensor，能代表constant op的返回值。
matrix1 = tf.constant([[3., 3.]])

# 可以查看matrix1的类型。
print 'The type of matrix is: ' + str(type(matrix1))
# 可以在session没run之前查看constant op设置好的常量值。
print 'The value have been set in the constant op is: ' + str(tf.contrib.util.constant_value(matrix1))
# 可以查看matrix1对应的op。
print 'The name of op corresponding to matrix1 is: ' + str(matrix1.op.name)

# 创建另外一个constant op， 这个op生产 2x1 矩阵[[2.],[2.]]。同样会做为一个node加入默认的graph中。
matrix2 = tf.constant([[2.], [2.]])

# 创建一个 matmul op，这里传入参数是前面创建op返回的两个Tensor。
product = tf.matmul(matrix1, matrix2)
# 可以查看product的类型。
print 'The type of product is: ' + str(type(product))
# 看看能否得到product的常量值。
print 'The value have been set in the matmul op is: ' + str(tf.contrib.util.constant_value(product))

print 'Lunch the graph...'
# 开始在session中启动默认graph。
sess = tf.Session()

# 可以通过此方法知道graph中的所有op。
print 'The ops in graph is: ' + str(sess.graph.get_operations())

# graph的op要在graph启动后，通过session的run接口来执行。
# 所有op的输入都由session自动执行提供，各op并发执行。
# 注意'run(product)'执行了graph的三个op，即两个constant op和一个matmul op，而'run(matrix1)'只执行了一个constant op。
# 执行op的返回值类型我们通过打印可以知道是numpy `ndarray`类型。

# 执行matrix1对应op。
result_matrix1 = sess.run(matrix1)
# 打印run matrix1得到的结果类型。
print 'The type of the result of running matrix1 is: ' + str(type(result_matrix1))
# 打印run matrix1得到的结果。
print 'The result of running matrix1 is: ' + str(result_matrix1)

# 执行product对应op。
result_product = sess.run(product)
# 打印run product得到的结果类型。
print 'The type of the result of running product is: ' + str(type(result_product))
# 打印run product得到的结果。
print 'The result of running product is: ' + str(result_product)

# 完成后关闭session。
sess.close()
```
运行后输出的结果如下：
```
Begin build graph...
The type of matrix is: <class 'tensorflow.python.framework.ops.Tensor'>
The value have been set in the constant op is: [[ 3.  3.]]
The name of op corresponding to matrix1 is: Const
The type of product is: <class 'tensorflow.python.framework.ops.Tensor'>
The value have been set in the matmul op is: None
Lunch the graph...
The ops in graph is: [<tensorflow.python.framework.ops.Operation object at 0x7feaa8b29f50>, <tensorflow.python.framework.ops.Operation object at 0x7fea9f8da3d0>, <tensorflow.python.framework.ops.Operation object at 0x7fea9f8da350>]
The type of the result of running matrix1 is: <type 'numpy.ndarray'>
The result of running matrix1 is: [[ 3.  3.]]
The type of the result of running product is: <type 'numpy.ndarray'>
The result of running product is: [[ 12.]]
```
从这个例子我们大致对TensorFlow的结构有所感受了，注意到`sess = tf.Session()`是`graph`构建和运行的分界线。注意session用完后就要关闭，也可以用`with tf.Session() as sess:`代码块，这样不用调用close，Session在代码块结束后会自动关闭。关于`constant`数据是保存在哪，这个问题文档并没有详细说，调试了也很难发现，不过[这里](https://www.tensorflow.org/versions/r0.11/how_tos/reading_data/index.html#preloaded-data)有说明，即`constant`数据是内联在`graph`的数据结构中的。
```
with tf.Session() as sess:
  result = sess.run(product)
```
另外我们可以用`with`语句指定执行`op`的CPU或GPU：
```
# 指定由序号为1的GPU来执行op。
with tf.device("/gpu:1"):
    matrix1 = tf.constant([[3., 3.]])
    matrix2 = tf.constant([[2.],[2.]])
    product = tf.matmul(matrix1, matrix2)
```

#### `graph`在分布式`session`中启动

要想创建一个TensorFlow集群，首先在集群各设备上创建一个TensorFlow服务端。当客户端创建一个分布式`session`，就需要将某个集群中某个机器的网络地址作为参数传入：
```
with tf.Session("grpc://example.org:2222") as sess:
  # 这里如果调用 sess.run(...) ，将会在集群上执行op。
```
这样之后，这台机器就会成为集群的主机，它将`graph`的`op`分发到集群各机器上。这和一台机器的时候，分发给多个GPU或CPU一样的道理。

你可以通过`with tf.device():`语句将`graph`的某一部分指定分发到某台机器上：
```
# job代表某台机器，task代表graph的某一部分。
with tf.device("/job:ps/task:0"):
  weights = tf.Variable(...)
  biases = tf.Variable(...)
```

更多分布式TensorFlow请看[这里](https://www.tensorflow.org/versions/r0.11/how_tos/distributed/index.html)。

#### Interactive(交互式)用法

前面例子都是用一个变量`sess`来保持`session`，然后通过`sess`去操作`graph`，实际上不用那么麻烦，为了更好地利用交互式python环境，可以用[`InteractiveSession`](https://www.tensorflow.org/versions/r0.11/api_docs/python/client.html#InteractiveSession)代替`Session`:
```
import tensorflow as tf
# 开启一个交互式（interactive） TensorFlow Session。注意这样之后这个session将成为全局默认的session。
sess = tf.InteractiveSession()

x = tf.Variable([1.0, 2.0])
a = tf.constant([3.0, 3.0])

# 直接调用'x'的initialize op的run方法初始化 'x'。
x.initializer.run()

sub = tf.sub(x, a)
# 直接用eval执行op并获取op返回值。
print(sub.eval())
# 这里将输出 [-2. -1.]

# 关闭session。
sess.close()
```

#### Tensor

如前所述，TensorFlow的`op`之间传输的数据都是`Tensor`，它是一个多维array或list。

#### Variable

`variable`维护整个`graph`的执行过程中的状态，下面的例子可以看到`variable`是如何做成一个计数器的……
```
...
# 创建一个名为counter的Variable，初始值为0。
state = tf.Variable(0, name="counter")

# Create an Op to add one to `state`.
one = tf.constant(1)
new_value = tf.add(state, one)
update = tf.assign(state, new_value)

# 用variable必须在graph中加入一个`init` op并且在graph启动后执行该op。
init_op = tf.initialize_all_variables()

# 启动graph开始运行op。
with tf.Session() as sess:
  # 执行 'init' op
  sess.run(init_op)
  # 打印 'state' 的初始值
  print(sess.run(state))
  for _ in range(3):
    # 运行update对应的op
    sess.run(update)
    # 运行相应op得到并打印variable的值
    print(sess.run(state))

# 运行结果如下:
# 0
# 1
# 2
# 3
```
通常会将一个统计模型中的参数表示为一组variable。比如，可以将一个神经网络的权重作为一个variable包装在一个tensor中。在重复训练过程中，每次训练完后去更新这个tensor。

#### Fetch（从TensorFlow输出数据）

在前面的例子中，都是用`session`的`run()`方法去执行单个`op`，实际上可以执行多个：
```
...
input1 = tf.constant([3.0])
input2 = tf.constant([2.0])
input3 = tf.constant([5.0])
intermed = tf.add(input2, input3)
mul = tf.mul(input1, intermed)

with tf.Session() as sess:
  result = sess.run([mul, intermed])
  print(result)

# 运行结果：
# [array([ 21.], dtype=float32), array([ 7.], dtype=float32)]
```
这里要注意下，`session`在`run`过程中，每个`op`只会执行一次。

#### Feed（输入数据到TensorFlow）

都知道，给某个系统输入数据，要么就是常量，要么就是可记录状态的参数，这两者在TensorFlow里面对应的是`constant`和`variable`，还有一种方法，就是用占位符，这样可以在运行时动态设置数据，这样的机制在TensorFlow里也有，即`tf.placeholder`：
```
...
# 占位。
input1 = tf.placeholder(tf.float32)
input2 = tf.placeholder(tf.float32)
output = tf.mul(input1, input2)

with tf.Session() as sess:
  # 运行op的时候，设置好数据。
  print(sess.run([output], feed_dict={input1:[7.], input2:[2.]}))

# 输出结果：
# [array([ 14.], dtype=float32)]
```

# 示例

知道了TensorFlow的基本用法之后，接下来看一个简单的例子，帮助进一步了解TensorFlow。

这个例子用的数据，来自比较经典的[MNIST手写数字集](http://yann.lecun.com/exdb/mnist/)，目的是要实现一个简单的手写字体识别模型，通过训练来提高该模型的准确度。可以在[这里](https://github.com/tensorflow/tensorflow/blob/r0.11/tensorflow/examples/tutorials/mnist/mnist_softmax.py)找到该例子源代码，这里对源代码进行了一些精简：
```
#!/usr/bin/python
# -*- coding: UTF-8 -*-

# 这是一个简单的MNIST分类器

# 导入数据相关程序，这个input_data我们可以在安装目录examples/tutorials/mnist下看到。
from tensorflow.examples.tutorials.mnist import input_data

import tensorflow as tf

FLAGS = None

# 自动下载/解压训练和测试资源文件到当前目录的data/下面。
mnist = input_data.read_data_sets('data/', one_hot=True)

# 创建解决问题以来的模型，后文详说。
x = tf.placeholder(tf.float32, [None, 784])
W = tf.Variable(tf.zeros([784, 10]))
b = tf.Variable(tf.zeros([10]))
y = tf.matmul(x, W) + b

# 定义loss函数和optimizer函数
y_ = tf.placeholder(tf.float32, [None, 10])
# 如果用cross-entropy的原始信息：
#
#   tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(tf.softmax(y)),
#                                 reduction_indices=[1]))
#
# 得到的结果是不稳定的。
#
# 所以这里我们对'y'的输出用 tf.nn.softmax_cross_entropy_with_logits的方法，并在batch数量上取平均值。
cross_entropy = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(y, y_))
train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)

sess = tf.InteractiveSession()
# 初始化op执行
tf.initialize_all_variables().run()

# 重复训练
for _ in range(1000):
    batch_xs, batch_ys = mnist.train.next_batch(100)
    sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys})

# 测试训练好的模型并打印准确度。
correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
# 打印测试数据准确度。
print(sess.run(accuracy, feed_dict={x: mnist.test.images,
                                       y_: mnist.test.labels}))
```

运行后得到的结果是：
```
...
Extracting data/train-images-idx3-ubyte.gz
Extracting data/train-labels-idx1-ubyte.gz
Extracting data/t10k-images-idx3-ubyte.gz
Extracting data/t10k-labels-idx1-ubyte.gz
0.92
...
```
程序大概就是先解压训练和测试资源文件（如果没有就先下载），准备好训练和测试数据，接着定义好模型也即前面说的构建好`graph`（特别要定义好`loss`函数和`optimizer`函数），接着就是重复训练优化模型。这个例子是用的是`softmax`回归方法。整个程序就是这么些，其中的思想接下来详细说明。

#### MNIST数据集

这个数据集里面就是一些手写数字图片如：
![](/images/mnist-one.png)
另外当然包含每张图片对应的标签即数字信息。这个数据集解析出来后，是一个个数据点。每个数据点包含两种信息：图片信息和图片对应数字信息。这些数据点被分到三个集合中，训练集(mnist.train)、验证集(mnist.validation)和测试集(mnist.test)。这三者的作用是不一样的：
* 训练集，是用来拟合`W`(权重)和`b`(偏离值)，简单说就是优化模型的。
* 验证集，是为了防止拟合过度的，就是当模型在训练集上的精确度提高，但在验证集上并没有甚至下降的时候，就要停止训练。
* 测试集，是为了测试模型的最终效果的。
通过上面的源码我们可以猜到，训练集的图片集就是`mnist.train.images`,相应的数字标签集合就是`mnist.train.labels`，测试集的类推即可。

每张图片是28x28分辨率的，我们可以将图片解释成类似这样的一个二维数组(图片像素点越黑，数组相应地方的值越大，反之同理)：
![](/images/minist-two.png)
我们也可以将这个数组展开成一个包含28x28=784个数的向量，也就是图片可以用一个784维向量表示。这样的方法，显然损失了原来2D的结构信息。虽然最好的关于`MNIST`的计算机视觉模型是将图片看成2D的，但我们这里作为简单使用，先用一个784维向量来表示图片先。这种方法实际上叫做`Dimensionality Reduction`(降维)，关于这个方法更多可以看[这里](http://colah.github.io/posts/2014-10-Visualizing-MNIST/)(里面会有动态图展示模型优化过程，另关于高纬度模型的可视化理解可看[这里](http://colah.github.io/posts/2014-03-NN-Manifolds-Topology))。

这里`mnist.train.images`是一个`tensor`(一个多维数组)，它的`shape`是[55000,784]，第一维表示每张图片所在的序号index，第二维表示的是图片的每个像素在图片中的序号。数组的每个值表示的是某张图片的某个像素点的黑色度，值从0~1(0表示全白1表示全黑)。
![](/images/mnist-three.png)
每张图片有一个相应的label，即0~9，表示图片对应的数字。为了这个例子的实现，我们将定义label为[`one-hot`向量](https://en.wikipedia.org/wiki/One-hot)，即只有一项为1，其他项都为0的向量。比如这里3就被表示成[0,0,0,1,0,0,0,0,0,0]。因此，`mnist.train.labels`是一个`shape`为[5500,10]的`tensor`。
![](/images/mnist-four.png)
我们接下来建立模型。

#### Softmax 回归

我们知道这些手写字体的label只有10种可能，即0~9的整数。我们需要有个这样的模型，给一张图片，我们能够估算出它是0，1，2...8,9的可能，这是一种概率计算问题，所有可能加起来显然是1。这是一种经典的用[Softmax](https://en.wikipedia.org/wiki/Softmax_function)回归模型来解决的问题。Softmax就是专门解决这类问题的：在概率理论中，Softmax方法的输出只有几种可能，这几种可能加起来为1。很多就算很复杂的模型(有很多神经网络层)，最后一层也是用这种方法来回归分析的。

要做Softmax回归有两步要走：首先将输入要成为各个类的`证据值`(evidence)分别做一个求和，然后将这些`证据值`转化对应各类的`概率值`。

这里我们要对输入的图片求成为各个类(0~9)的证据值，这个证据值这样求：求图片个像素的颜色值(0~1)乘以权重然后做一个求和(注意这个权重也是我们要通过模型训练调整完善的，我们可以给个初始值0，这个后面会讲)。这个权重是正数，表示这个像素颜色值越高是成为该类的迹象，反之这个权重是负数，表示这个像素颜色值越高是不成为该类的迹象。下面这张图表是一个模型学习出来的权重分布图(红色表示负数，蓝色表示正数)：
![](/images/mnist-five.png)
这里我们除了权重`W`(weight)影响`证据值`，还有另外一项即偏离值`b`(bias)，这个值是鱼输入信息无关的常量，综合所得到的结论是：给定某张图片的像素值数组$x$，可以计算每类(每个数字如0,1...,8,9)$i$的值如下：
$$e\_i = \sum\_{j=0}^{784} W\_{i,j} x\_j + b\_i$$
这是输入一张图片$x$得到的一个等式，$e\_i$表示图片识别为$i$类的`证据值`(evidence)，$x\_j$表示的是图片的第$j$个像素点的颜色值，$W\_{i,j}$表示$i$类在第$j$个像素点的权重值，$b_i$表示$i$类的偏离值。然后我们接着用`softmax`回归来对`evidence`向量(这里在数据表现上是一个一维数组$e$)进行处理：
$$y = \text{softmax}(e)$$
$y$就是我们要求的在各个类上的概率值向量(这里在数值上表现为长度为10的一维数组)。我们常把`softmax`称作`激活函数`或`连接函数`，它将线性函数(稍后会知道)输出的结果转化成了我们想要的概率向量结果(概率数组$y$)。`softmax`公式是这样定义的：
$$\text{softmax}(e) = \text{normalize}(\exp(e))$$
将方程展开，将得到如下等式：
$$y\_i = \text{softmax}(e)\_i = \frac{\exp(e\_i)}{\sum\_{j=0}^{9} \exp(e\_j)}$$
这里$y\_i$当然是类$i$(即label值为$i$)的概率。关于`softmax`函数，可以看[这里](https://en.wikipedia.org/wiki/Softmax_function)理解下。这里也尝试给出如下解释：`softmax`其实是要解决这样的问题：我们已知几个值，这些值可以是正也可以是负。通过这几个值，来得到这几个值对应的的概率值(这几个概率值和为1)，要求是，当某个值增大时，它分得的概率增大。思路就是：我们知道，很显然的想法是把所有值加起来做和，然后用他们的值除于总和作为概率值，这和我们`softmax`去掉`exp`的形式是一样的。那为什么要加`exp`呢？显然我们忽略了一个事实，那些值是可正可负的，如果这样算，就可能算出概率是负数，没有意义。于是我们想到了将这些值都转化为正，并且是单调递增的，于是乎我们想到了`exp`函数，一个单调递增的取值范围大于0的函数。这样总结起来就是：先用`exp`对原数值进行映射，然后按照前面的思想求得概率。`softmax`函数就是这样来的。

我们可以用下面的图来描述我们的`softmax`回归模型，这里用$x_1$、$x_2$、$x_3$来做举例(实际上我们知道$x$有784个，$b$和$y$分别有10个)：
![](/images/mnist-six.png)
如果将其表示成方程组，是这样的：
![](/images/mnist-eight.png)
可以将其转变成矩阵和向量相乘的形式如下：
![](/images/mnist-seven.png)
更加简洁地，我们可以这样表达：
$$y = \text{softmax}(Wx + b)$$
了解了这些后我们接下来看看这个模型是如何用代码实现的。

#### `softmax`回归模型代码实现

说明：完整代码已经在上面，我们这里来分析注意的地方。

```
x = tf.placeholder(tf.float32, [None, 784])`
```
我们这里用了`placeholder`来占位，为了后面输入图片数据。`None`表示维数是不确定的，实际上看后面的代码可以知道，这个维数就是每次训练的图片张数，即`batch`数量值。这里这样做是为了放到后面可以输入设定好的`batch`张图片。需要注意的是这里的$x$并不等同上文方程中的$x$，这里的$x$是一个2维tensor，关于二维tensor在这里的作用，稍后详说。

我们还需要权重(`W`)和偏离值(`b`)，这两个值需要在训练后进行调整完善，我们把它作为比较特殊的输入，这种输入可以在`graph`运行当中可以改变，这样的`tensor`就是variable：
```
W = tf.Variable(tf.zeros([784, 10]))
b = tf.Variable(tf.zeros([10]))
```
可以看到`W`是一个2维tensor，784就是一张图的像素个数，10就是有10个类别(0,1...8,9)，而`b`得10就是10个类别，其中`tf.zeros`表示将tensor里面的数值都初始化为0。

接下来用一句话来定义模型：
```
y = tf.nn.softmax(tf.matmul(x, W) + b)
```
这里有一个迷惑，就是如果我们把$x$看做是向量，那$y$当然是向量，这样跟我们前面的等式是一样的。但在这里`TensorFlow`玩了个小把戏，$x$实际是一个二维tensor，为的是能够输入`batch`张图片。关于一个二维tensor，其包装的输入数据(`input`)在数据结构上表现为一个二维数组，在数学上可以用一个矩阵来表示。而一维tensor，输入数据的数据结构是一个数组，在数学上可以用一个向量来表示。我们知道如果$x$是一个二维tensor，则在数学上表现为一个矩阵，这样`tf.matmul(x, W)`即`Wx`产生的是一个矩阵。我们知道在数学中，矩阵和向量是不能相加的，但我们知道这个`+`其实TensorFlow可以自己定义的(同样`softmax`也可以自己定义，作用在多维数组上)。因此这段代码，在数学上用的正是我们上面分析的方程，但在实际运算过程中实际上相当于做了些自定义，也就是说，TensorFlow这句代码与我们前面分析的等式并不冲突，并同时实现了TensorFlow想要的多张图片输入的需求。

#### 训练

为了训练我们的模型，我们要定义衡量模型有多好的标尺。实际上在机器学习中通常是要定义衡量模型有多坏的标尺。我们称之为**cost**或者**loss**，它定义了我们的模型离我们想要的结果有多远。我们的目标是将错误范围最小化，错误越小，我们的模型就越完善。

一个非常通用、非常好的计算**loss**的方法是[`交叉熵`](https://en.wikipedia.org/wiki/Cross_entropy)(**cross-entropy**)。交叉熵本来产生于信息论里面的信息压缩编码技术，但是它后来演变成为从博弈论到机器学习等许多领域里的重要技术。它是这样定义的：
$$H_{y'}(y) = -\sum_i y'_i \log(y_i)$$
这里$y$是我们模型预测的标签数据的概率分布，而$y'$是正确的概率分布(是我们前面说的one-hot vector)。总体来讲，交叉熵是用来衡量我们的预测概率分布用来描述事实时的低效率程度的。关于交叉熵在视觉机器学习方面的理论可看[这里](http://colah.github.io/posts/2015-09-Visual-Information/)加深理解。

要想实现交叉熵，我们定义一个`placeholder`来为后面的正确标签数据输入占个位。
```
y_ = tf.placeholder(tf.float32, [None, 10])
```
接着来实现   $-\sum y'\log(y)$
```
cross_entropy = tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(y), reduction_indices=[1]))
```
首先，先计算**y**每一项的对数，然后用**y_**的每一项生于对应的**y**的每一项，`reduce_sum`和`reduction_indices[1]`表示将数组第二维的数据加起来组成一个数组，`reduce_mean`不带参数，表示求里面数组的平均值。

注意到程序里面我们没有这么用，因为这样较不稳定。实际上我们用了`softmax_cross_entropy_with_logits`的方法，因为这样的方法较稳定。

现在我们知道了我们训练模型需要做的东西，即减小交叉熵的值。因为TensorFlow有整个`graph`，因此就可以用BP算法([backpropagation algorithm](http://colah.github.io/posts/2015-08-Backprop/))来高效计算每个`variable`对`losss`值的影响。接着我们就可以选择合适的优化算法来调整`variable`的值，达到降低`loss`值的目的。
```
train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)
```
这里我们运用了梯度下降算法来减小交叉熵的值，其中学习速率是0.5。梯度下降算法是一个简单的处理过程，TensorFlow用这个方法，每次小小调整下`variable`，使其往减小交叉熵的方向走。当然，TensorFlow也提供了另外一些优化方法在[这里](https://www.tensorflow.org/versions/r0.11/api_docs/python/train.html#optimizers)。

接着我们创建一个初始化的`op`:
```
init = tf.initialize_all_variables()
```

现在我们可以启动**session**了，然后接着就是执行初始化`op`:
```
sess = tf.Session()
sess.run(init)
```
接着进行训练，我们进行1000次训练：
```
for i in range(1000):
  batch_xs, batch_ys = mnist.train.next_batch(100)
  sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys})
```
可以看到这里每次训练都会取100张图片，然后执行**train_step**，将100张图片的图片和图片对应的标签信息代替前面的**placeholder**，作为输入。

这里通过每次用少量随机数据做训练的方法叫随机训练。实际上我们可以每次用所有的训练数据进行训练，这样给人感觉会更好，但这样做消耗太大，计算时间长，所以我们每次训练都选择适量的不同的数据子集，这样不会每次训练时间太久，还能得到相同的效果。

#### 评估
如何评估我们模型准确性？我们用我们的模型，输入测试数据，因为我们有测试数据的答案，我们可以比对计算出答案正确率，这就是我们想要的测试结果。

我们用这段代码来比较模型测出来的结果和正确答案是否相同：
```
correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
```
`tf.argmax`是根据[这里](http://stackoverflow.com/questions/38094217/tensorflow-argmax-min)描述，可以知道，它相当于是从一个二维数组里面从某一维里选最大的值的序号，得到的结果是一个数组。这里`tf.argmax(y,1)`表示从`y`的第二维找出最大值的序号，然后组成一个第一维长度的数组。通过上文我们知道`y`是我们模型预测的图片的标签答案，而`y_`是图片的标签正确答案。`equal`则比较这两个素组的各个序号是否相等，最后得到一个数组如`[true,false,true,...,false,true]`我们通过下面的方法进一步转成正确率：
```
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
```
我们可以猜到，上面的`tf.cast`先将`correct_prediction`的结果比如`[true, false, true, true]`转成`tf.float32`格式数据比如`[1,0,1,1]`这样`reduce_mean`就可以通过数值计算正确率出来0.75。

下面这段代码，就是输入测试数据进行测试，然后将计算正确率结果打印出来：
```
print(sess.run(accuracy, feed_dict={x: mnist.test.images, y_: mnist.test.labels}))
```
结果大概在`0.92`左右。这样的结果作为入门可以，但这样的结果实际上并不理想，这是因为我们用的模型比较简单，只是入门模型。最好的结果可以达到`0.997`左右，关于`MNIST`的训练结果和所用方法列表可看[这里](http://rodrigob.github.io/are_we_there_yet/build/classification_datasets_results.html)。

# 更多

#### 关于更深入`MNIST`手写字识别机器学习的机制，可以看这个比较简单的[介绍](http://cs.stanford.edu/people/karpathy/convnetjs/intro.html)。
![](/images/mnist-pre.png)
我们可看到，尽管经过这么多隐藏层，最后一层还是要通过`softmax`回归来处理。

#### 网页神经网络展示[Playground](http://playground.tensorflow.org)

我们可以通过这个大致感受下神经网络相关。

注意总体看里面的黄色代表负数，蓝色代表正数。包括数据点（圆点）、神经元权重连接线（连线）、神经元像素点(神经元背景色)。其中数据点在分类问题中只有两种颜色，要么黄要么蓝，标示两种不同数据；神经元权重连接线的宽度表示权重绝对值的大小；在分类问题中，神经元像素点的颜色的透明度代表预测的信心度（从0~1，注意有图标示）。

可以看到通过学习，可以逐步得到出数据点的分布情况。

可以看到`Training loss`代表模型训练的完善度，`Test loss`代表模型测试的好坏度，这两者是越小越好。

##### 这个例子可以做如下操作：

* 选择数据集
* 修改训练数据集合测试数据集的比例
* 设置数据混乱度
* 设置一次训练的数据量
* 选择学习速度
* 选择激活函数（ReLU/Tanh/Sigmoid/Linear）
* 选择正则化方法（L1/L2）
* 选择正则化速度
* 选择问题类型（分类/回归）
* 选择要加入的特征性质
* 可自由设置W权重
* 可增删隐藏层
* 可增删神经元

##### 可以看到有这些项

* $X_1$
* $X_2$
* $X_1^2$
* $X_2^2$
* $X_1X_2$
* $sin(X_1)$
* $sin(X_2)$

猜想其实这个解决问题的方式是用神经网络多层去逼近描述数据的最优函数。

#### 更多的网页神经网络[在这](http://cs.stanford.edu/people/karpathy/convnetjs/index.html)。

#### 关于机器学习如何选择评估方法（`estimator`）请看[这里](http://scikit-learn.org/stable/tutorial/machine_learning_map/)。