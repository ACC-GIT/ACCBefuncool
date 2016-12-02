title: HttpServlet注入Spring管理的bean的方法
date: 2015-05-06 16:29:00
categories: 娱乐
tags: [HttpServlet, Spring, bean, Autowired, 注入]
description:
---
问题：Spring初始化HttpServlet不是用@Comonent的方式，所以用@Autowired无法注入bean。
解决：可以实现init方法，在里面绑定bean，方式如下(假设要注入的bean类为A)：
```bash
private A a;
@Override
public void init() throws ServletException {
    super.init();
    ServletContext servletContext = this.getServletContext();
    WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);
    this.a = (A) context.getBean("a");
}
```







