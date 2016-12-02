title: maven发布jar、aar、war等到中央库（Central Repository）的步骤
date: 2015-06-11 08:06:00
categories: 娱乐
tags: [maven, release, Central Repository, 中央库, GPG]
description:
---
步骤一：注册账号，申请ticket。
注册在这里：[https://issues.sonatype.org](https://issues.sonatype.org)
申请ticket：创建一个issue，注意这里要选OSSRH，且是PROJECT而不是TASK，group id要慎重写，不能写你没有权限的，不然服务人员会让你重写（半天左右）。
申请成功后会提示：Configuration has been prepared, now you can:please comment on this ticket when you promoted your first release, thanks
步骤二：GPG，签名和加密用。
下载：[https://www.gnupg.org/download/index.html](https://www.gnupg.org/download/index.html)
注意：签名的名字，邮箱和步骤一的一样，记住passphrase用于下面步骤。
步骤三：编译和提交文件。
         注意事项：
1）.m2\settings.xml文件中要加入：


```html
<servers>
	<server>
		<id>sonatype-nexus-snapshots</id>
		<username>your-jira-username</username>
		<password>your-jira-password</password>
	</server>
	<server>
		<id>sonatype-nexus-staging</id>
		<username>your-jira-username</username>
		<password>your-jira-password</password>
	</server>
</servers>
```
2)  pom.xml文件中要加入（project标签下）：


```html
<parent>
	<groupId>org.sonatype.oss</groupId>
	<artifactId>oss-parent</artifactId>
	<version>7</version>
</parent>
```

3）如果出现javadoc编译不通过的可以在javadoc插件下加入：


```html
<configuration>
	<additionalparam>-Xdoclint:none</additionalparam>
</configuration>
```

4） 注意如过时release要加入：


```html
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-gpg-plugin</artifactId>
	<version>${maven-gpg-plugin.version}</version>
	<executions>
		<execution>
			<phase>verify</phase>
			<goals>
				<goal>sign</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

5) 如果是java web项目，javadoc可能会报错：找不到类javax.servlet.ServletContext，可以添加依赖：


```html
<dependency>
	<groupId>javax.servlet</groupId>
	<artifactId>javax.servlet-api</artifactId>
	<version>3.0.1</version>
	<scope>provided</scope>
</dependency>
```

6) POM编写可参考[https://github.com/ACC-GIT/ACCWeb/blob/master/pom.xml](https://github.com/ACC-GIT/ACCWeb/blob/master/pom.xml)
步骤四：release和提示同步。
先在[https://oss.sonatype.org/#stagingRepositories](https://oss.sonatype.org/#stagingRepositories)进行close,release等操作（注意这里会检测）
然后在issue中回复服务人员，提出同步到中央库（半天左右）。
   