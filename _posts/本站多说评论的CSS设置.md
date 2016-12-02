title: 本站多说评论的CSS设置
date: 2015-12-28 19:46:24
tags: [CSS,多说]
category: CSS
description:
---
### 以下是本站多说的CSS设置内容：

``` css
#ds-thread #ds-reset ul.ds-comments-tabs li.ds-tab a.ds-current {
	border:0px;
	color:#848568;
	text-shadow:none;
	background:#dddfc2
}
#ds-thread #ds-reset .ds-highlight {
	font-family:Arial,Helvetica,sans-serif;
	font-size:14px;
	font-weight:bold;
	color:#848568 !important;
}
#ds-thread #ds-reset ul.ds-comments-tabs li.ds-tab a.ds-current:hover {
	color:#696a52;
	background:#d4d6ba
}
#ds-thread #ds-reset a.ds-highlight:hover {
	color:#696a52 !important;
}
#ds-thread {
	padding-left:30px;
}
#ds-thread #ds-reset li.ds-post,#ds-thread #ds-reset #ds-hot-posts {
	overflow:visible
}
#ds-thread #ds-reset .ds-post-self {
	padding:10px 29px 10px 10px;
}
#ds-thread #ds-reset li.ds-post {
	padding:0 26px 10px;
}
#ds-thread #ds-reset li.ds-post,#ds-thread #ds-reset .ds-post-self {
	border:0 !important;
}
#ds-reset .ds-avatar,#ds-thread #ds-reset ul.ds-children .ds-avatar {
	position:absolute;
	top:26px;
	left:-14px;
	padding:5px;
	width:36px;
	height:36px;
	box-shadow:-1px 0 1px rgba(0,0,0,.15) inset;
	border-radius:46px;
	background:#E5E6D0;
}
#ds-thread #ds-reset ul.ds-children .ds-avatar {
	left:-23px;
}
#ds-thread .ds-avatar a {
	display:inline-block;
	padding:1px;
	width:32px;
	height:32px;
	border:1px solid #b9baa6;
	border-radius:50%;
	background-color:#fff !important
}
#ds-thread .ds-avatar a:hover {
	border-color:#de5a4e
}
#ds-thread .ds-avatar > img {
	margin:2px 0 0 2px
}
#ds-thread #ds-reset .ds-replybox {
	box-shadow:none;
}
#ds-thread #ds-reset ul.ds-children .ds-replybox.ds-inline-replybox a.ds-avatar,
#ds-reset .ds-replybox.ds-inline-replybox a.ds-avatar {
	left:0;
	top:0;
	padding:0;
	width:32px !important;
	height:32px !important;
	background:none;
	box-shadow:none;
}
#ds-reset .ds-replybox.ds-inline-replybox a.ds-avatar img {
	width:32px !important;
	height:32px !important;
	border-radius:50%;
}
#ds-reset .ds-replybox a.ds-avatar,#ds-reset .ds-replybox .ds-avatar img {
	padding:0;
	width:50px !important;
	height:50px !important;
	border-radius:5px;
}
#ds-reset .ds-avatar img, #ds-recent-visitors .ds-avatar img {
	width:32px !important;
	height:32px !important;
	border-radius:32px;
	box-shadow:0 1px 3px rgba(0,0,0,0.22);
	-webkit-transition:.4s all ease-in-out;
	-moz-transition:.4s all ease-in-out;
	-o-transition:.4s all ease-in-out;
	-ms-transition:.4s all ease-in-out;
	transition:.4s all ease-in-out;
}
.ds-post-self:hover .ds-avatar img {
	-webkit-transform:rotate(360deg);
	-moz-transform:rotate(360deg);
	-o-transform:rotate(360deg);
	-ms-transform:rotate(360deg);
	transform:rotate(360deg);
}
#ds-thread #ds-reset .ds-comment-body {
	background:#F0F0E3;
	padding:15px 15px 12px 32px;
	border-radius:5px;
	box-shadow:0 1px 2px rgba(0,0,0,.15),0 1px 0 rgba(255,255,255,.75) inset;
}
#ds-thread #ds-reset .ds-comment-body p {
	color:#787968
}
#ds-thread #ds-reset .ds-comments a.ds-user-name {
	font-weight:bold;
	color:#696A52 !important;
}
#ds-thread #ds-reset .ds-comments a.ds-user-name:hover {
	color:#D32 !important;
}
#ds-thread #ds-reset #ds-hot-posts {
	border:0
}
#ds-reset #ds-hot-posts .ds-gradient-bg {
	background:none;
}
#ds-reset #ds-bubble #ds-ctx .ds-ctx-entry {
	padding:0;
}
#ds-reset #ds-bubble .ds-avatar,#ds-reset #ds-bubble #ds-ctx-bubble .ds-avatar a {
	position:static;
	padding:0;
	border:0;
	background:none;
	box-shadow:none;
}
#ds-reset #ds-bubble .ds-avatar img,#ds-reset #ds-bubble #ds-ctx-bubble .ds-avatar a {
	width:45px !important;
	height:45px !important;
}
#ds-reset #ds-bubble .ds-user-name {
	padding-left:13px;
}
#ds-reset .ds-comment-body #ds-ctx {
	border-left:1px solid #b9baa6;
	background-color:#e8e8dc !important
}
#ds-reset #ds-ctx {
	margin-right:-15px
}
#ds-reset #ds-ctx .ds-ctx-entry {
	position:relative;
	padding:10px 30px 10px 10px;
}
#ds-reset #ds-ctx .ds-ctx-entry .ds-avatar {
	top:6px;
	left:5px;
	background:none;
	box-shadow:none;
}
#ds-reset #ds-ctx .ds-ctx-entry .ds-ctx-body {
	margin-left:46px;
}
#ds-reset #ds-ctx .ds-ctx-entry .ds-ctx-content {
	color:#787968
}
#ds-reset #ds-ctx .ds-ctx-entry .ds-ctx-head a {
	color:#696A52;
	font-weight:bold
}
#ds-thread #ds-reset .ds-powered-by {
	display:none;
}
#ds-recent-visitors .ds-avatar {
	float:left
}
#ds-thread #ds-reset .ds-header {
	padding:0px;
}
#ds-recent-visitors .ds-avatar {
	padding-bottom: 30px !important;
}
```
#### 可将上面的代码复制，然后到多说后台设置，如下图：

![多说CSS设置](/images/duoshuo_set.png)

<!--more-->

> * 其他多说设置，如隐藏最早最新，隐藏评论框分享按钮，隐藏所有权信息等都在这里面设置。
> * 多说的CSS修改请参考[这里](http://dev.duoshuo.com/docs/4ff1cfd0397309552c000017)。
