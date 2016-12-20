title: wsimport报错Use of SOAP Encoding is not supported.
date: 2015-05-04 20:06:00
categories: 娱乐
tags: [wsimport, soap, webservice, SOAP Encoding, not supported]
description:
---

## 错误原因和解决

* 可以参考=>[**这里**](http://stackoverflow.com/questions/412772/java-rpc-encoded-wsdls-are-not-supported-in-jaxws-2-0)

## 解决步骤

* 下载好这些jar文件：
    * activation-1.1.jar
    * axis-1.4.jar
    * commons-discovery-0.2.jar
    * commons-logging-1.1.1.jar
    * jaxrpc-1.1.jar
    * mail-1.4.jar
    * saaj-1.1.jar
    * wsdl4j-1.4.jar

* 将下载好的jar文件放在一个目录下，在这个目录下执行cmd命令如下：
```bash
Java -cp activation-1.1.jar;axis-1.4.jar;commons-discovery-0.2.jar;commons-logging-1.1.1.jar;jaxrpc-1.1.jar;mail-1.4.jar;saaj-1.1.jar;wsdl4j-1.4.jar org.apache.axis.wsdl.WSDL2Java http://xxx?wsdl
```
（注意：上文的xxx换成你的wsdl地址对应的）