title: wsimport报错Use of SOAP Encoding is not supported.
date: 2015-05-04 20:06:00
categories: 娱乐
tags: [wsimport, soap, webservice, SOAP Encoding, not supported]
description:
---
1 错误原因及解决可参考[**这里**](http://stackoverflow.com/questions/412772/java-rpc-encoded-wsdls-are-not-supported-in-jaxws-2-0)。
2  下载好那些jar文件后可cd到那个目录，然后执行：
```bash
java -cpactivation-1.1.jar;axis-1.4.jar;commons-discovery-0.2.jar;commons-logging-1.1.1.jar;jaxrpc-1.1.jar;mail-1.4.jar;saaj-1.1.jar;wsdl4j-1.4.jar org.apache.axis.wsdl.WSDL2Javahttp://xxxxxxxx?wsdl(注意这里是你的wsdl地址）。
```