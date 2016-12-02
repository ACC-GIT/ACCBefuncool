title: Hexo集成Algolia搜索插件
date: 2016-05-30 19:12:38
tags: [Hexo, Algolia, 插件]
category: Hexo
description:
---

Swiftype搜索最近停了，开始收费，不想收费又想有这个站内搜索功能怎么办？
可以用Algolia免费版！不仅免费，感觉上要比Swiftype要快，下面简单说下集成步骤。

<!--more-->

### 第一步：到官网注册帐号(可以用github登录)
* [官网地址](https://www.algolia.com)注册帐号
* 新建一个INDEX如图
  ![Algolia新建Index](/images/algolia-index.png)
* 来到[API-KEYS页面](https://www.algolia.com/api-keys)，上面有后面需要的信息（记得还有上面的INDEX名）。
  ![Algolia的结果](/images/algolia-result.png)

### 第二步：上传数据到Algolia
* 在Hexo工程目录的根目录下执行
```c
npm install hexo-algolia --save
```
* 在`根目录`的`_config.yml`中加入如下配置，注意改成前面第一步注册成果数据
```c
algolia:
  applicationID: 'your applicationID'
  apiKey: 'your apiKey'
  adminApiKey: 'your adminApiKey'
  indexName: 'your indexName'
  chunkSize: 5000
```
* 接着执行，确保得到提交成功提示
```c
hexo algolia
```
* 如下说明成功：
```c
INFO  [Algolia] Identified 58 posts to index.
INFO  [Algolia] Clearing index...
INFO  Files loaded in 8.83 s
INFO  [Algolia] Highlight tag definition success.
INFO  [Algolia] Index cleared.
INFO  [Algolia] Starting indexation...
INFO  [Algolia] Import done.
INFO  0 files generated in 57 s
```
* 注意事项：
> * 有的人可能发现没有上传数据，这时候可以先hexo clean然后再hexo algolia。 
> * Mac下有可能出现Cannot read property之类的错误，则先检查看是否是.DS_Store惹的祸。

### 第三步：修改Hexo主题集成Algolia
* 确保在`head.swig`文件中加入如下配置，注意改成自己的（本人用的是NEXT主题，如果是其他主题，请放在类似的生成页面头部的文件中）
```javascript
<script type="text/javascript" id="hexo.configuration">
  var CONFIG = {
    root: '/',
    algolia: {
          applicationID: 'your applicationID',
          apiKey: 'your apiKey',
          indexName: ''your indexName',
          hits: {"per_page":10},
          labels: {"input_placeholder":"搜索...","hits_empty":"未发现与 「${query}」相关的内容","hits_stats":"${hits} 条相关条目，使用了 ${time} 毫秒"}
        }
  };
</script>
```
* 在要搜索的页面加入如下div
```javascript
<div class="site-search">
  <div class="algolia-popup popup">
    <div class="algolia-search">
      <div class="algolia-search-input-icon">
        <i class="fa fa-search"></i>
      </div>
      <div class="algolia-search-input" id="algolia-search-input"></div>
    </div>

    <div class="algolia-results">
      <div id="algolia-stats"></div>
      <div id="algolia-hits"></div>
      <div id="algolia-pagination" class="algolia-pagination"></div>
    </div>

    <span class="popup-btn-close">
      <i class="fa fa-times-circle"></i>
    </span>
  </div>
</div>
```
* 在要触发搜索的HTML节点加入一个CLASS名为`popup-trigger`，如图
  ![Algolia的结果](/images/algolia-class.png)
* 确保要搜索页包含如下JS代码（可以单独建立一个.swig文件，然后在整体layout的swig文件中加入）
```javascript
<script src="http://cdn.bootcss.com/instantsearch.js/1.5.1/instantsearch.js"></script>

<script type="text/javascript">
$(document).ready(function () {
  var algoliaSettings = CONFIG.algolia;
  var isAlgoliaSettingsValid = algoliaSettings.applicationID &&
    algoliaSettings.apiKey &&
    algoliaSettings.indexName;

  if (!isAlgoliaSettingsValid) {
    window.console.error('Algolia Settings are invalid.');
    return;
  }

  var search = instantsearch({
    appId: algoliaSettings.applicationID,
    apiKey: algoliaSettings.apiKey,
    indexName: algoliaSettings.indexName,
    searchFunction: function (helper) {
      var searchInput = $('#algolia-search-input').find('input');

      if (searchInput.val()) {
        helper.search();
      }
    }
  });

  // Registering Widgets
  [
    instantsearch.widgets.searchBox({
      container: '#algolia-search-input',
      placeholder: algoliaSettings.labels.input_placeholder
    }),

    instantsearch.widgets.hits({
      container: '#algolia-hits',
      hitsPerPage: algoliaSettings.hits.per_page || 10,
      templates: {
        item: function (data) {
          return (
            '<a href="' + CONFIG.root + data.path + '" class="algolia-hit-item-link">' +
            data._highlightResult.title.value +
            '</a>'
          );
        },
        empty: function (data) {
          return (
            '<div id="algolia-hits-empty">' +
            algoliaSettings.labels.hits_empty.replace(/\$\{query}/, data.query) +
            '</div>'
          );
        }
      },
      cssClasses: {
        item: 'algolia-hit-item'
      }
    }),

    instantsearch.widgets.stats({
      container: '#algolia-stats',
      templates: {
        body: function (data) {
          var stats = algoliaSettings.labels.hits_stats
            .replace(/\$\{hits}/, data.nbHits)
            .replace(/\$\{time}/, data.processingTimeMS);
          return (
            stats +
            '<span class="algolia-powered">' +
            '  <img src="' + CONFIG.root + 'images/algolia_logo.svg" alt="Algolia" />' +
            '</span>' +
            '<hr />'
          );
        }
      }
    }),

    instantsearch.widgets.pagination({
      container: '#algolia-pagination',
      scrollTo: false,
      showFirstLast: false,
      labels: {
        first: '<i class="fa fa-angle-double-left"></i>',
        last: '<i class="fa fa-angle-double-right"></i>',
        previous: '<i class="fa fa-angle-left"></i>',
        next: '<i class="fa fa-angle-right"></i>'
      },
      cssClasses: {
        root: 'pagination',
        item: 'pagination-item',
        link: 'page-number',
        active: 'current',
        disabled: 'disabled-item'
      }
    })
  ].forEach(search.addWidget, search);

  search.start();

  $('.popup-trigger').on('click', function(e) {
    e.stopPropagation();
    $('body').append('<div class="popoverlay">').css('overflow', 'hidden');
    $('.popup').toggle();
    $('#algolia-search-input').find('input').focus();
  });

  $('.popup-btn-close').click(function(){
    $('.popup').hide();
    $('.popoverlay').remove();
    $('body').css('overflow', '');
  });

});
</script>

<script type="text/javascript">
  $(document).ready(function () {
    if ( $('#local-search-input').size() === 0) {
      return;
    }

    // Popup Window;
    var isfetched = false;
    // Search DB path;
    var search_path = "search.xml";
    if (search_path.length == 0) {
      search_path = "search.xml";
    }
    var path = "/" + search_path;
    // monitor main search box;

    function proceedsearch() {
      $("body").append('<div class="popoverlay">').css('overflow', 'hidden');
      $('.popup').toggle();

    }
    // search function;
    var searchFunc = function(path, search_id, content_id) {
      'use strict';
      $.ajax({
        url: path,
        dataType: "xml",
        async: true,
        success: function( xmlResponse ) {
          // get the contents from search data
          isfetched = true;
          $('.popup').detach().appendTo('.header-inner');
          var datas = $( "entry", xmlResponse ).map(function() {
            return {
              title: $( "title", this ).text(),
              content: $("content",this).text(),
              url: $( "url" , this).text()
            };
          }).get();
          var $input = document.getElementById(search_id);
          var $resultContent = document.getElementById(content_id);
          $input.addEventListener('input', function(){
            var matchcounts = 0;
            var str='<ul class=\"search-result-list\">';
            var keywords = this.value.trim().toLowerCase().split(/[\s\-]+/);
            $resultContent.innerHTML = "";
            if (this.value.trim().length > 1) {
              // perform local searching
              datas.forEach(function(data) {
                var isMatch = true;
                var content_index = [];
                var data_title = data.title.trim().toLowerCase();
                var data_content = data.content.trim().replace(/<[^>]+>/g,"").toLowerCase();
                var data_url = data.url;
                var index_title = -1;
                var index_content = -1;
                var first_occur = -1;
                // only match artiles with not empty titles and contents
                if(data_title != '' && data_content != '') {
                  keywords.forEach(function(keyword, i) {
                    index_title = data_title.indexOf(keyword);
                    index_content = data_content.indexOf(keyword);
                    if( index_title < 0 && index_content < 0 ){
                      isMatch = false;
                    } else {
                      if (index_content < 0) {
                        index_content = 0;
                      }
                      if (i == 0) {
                        first_occur = index_content;
                      }
                    }
                  });
                }
                // show search results
                if (isMatch) {
                  matchcounts += 1;
                  str += "<li><a href='"+ data_url +"' class='search-result-title'>"+ data_title +"</a>";
                  var content = data.content.trim().replace(/<[^>]+>/g,"");
                  if (first_occur >= 0) {
                    // cut out 100 characters
                    var start = first_occur - 20;
                    var end = first_occur + 80;
                    if(start < 0){
                      start = 0;
                    }
                    if(start == 0){
                      end = 50;
                    }
                    if(end > content.length){
                      end = content.length;
                    }
                    var match_content = content.substring(start, end);
                    // highlight all keywords
                    keywords.forEach(function(keyword){
                      var regS = new RegExp(keyword, "gi");
                      match_content = match_content.replace(regS, "<b class=\"search-keyword\">"+keyword+"</b>");
                    });

                    str += "<p class=\"search-result\">" + match_content +"...</p>"
                  }
                  str += "</li>";
                }
              })};
            str += "</ul>";
            if (matchcounts == 0) { str = '<div id="no-result"><i class="fa fa-frown-o fa-5x" /></div>' }
            if (keywords == "") { str = '<div id="no-result"><i class="fa fa-search fa-5x" /></div>' }
            $resultContent.innerHTML = str;
          });
          proceedsearch();
        }
      });}

    // handle and trigger popup window;
    $('.popup-trigger').mousedown(function(e) {
      e.stopPropagation();
      if (isfetched == false) {
        searchFunc(path, 'local-search-input', 'local-search-result');
      } else {
        proceedsearch();
      };

    });

    $('.popup-btn-close').click(function(e){
      $('.popup').hide();
      $(".popoverlay").remove();
      $('body').css('overflow', '');
    });
    $('.popup').click(function(e){
      e.stopPropagation();
    });
  });
</script>
```
* 确保要搜索页包含如下CSS代码（可以单独建立一个.styl文件，然后在整体css的styl文件中加入，注意确保生成正确，必要时可以执行`hexo clean`）
```css
ul.search-result-list {
  padding-left: 0px;
  margin: 0px 5px 0px 8px;
}
p.search-result {
  border-bottom: 1px dashed #ccc;
  padding: 5px 0;
}
a.search-result-title {
  font-weight: bold;
}
a.search-result {
  border-bottom: transparent;
  display: block;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.search-keyword {
  border-bottom: 1px dashed #4088b8;
  font-weight: bold;
}
#local-search-result {
  height: 90%;
  overflow: auto;
}
.popup {
  display: none;
  position: fixed;
  top: 10%;
  left: 50%;
  width: 700px;
  height: 80%;
  margin-left: -350px;
  padding: 3px 0 0 10px;
  background: #fff;
  color: #333;
  z-index: 9999;
  border-radius: 5px;
}
@media (max-width: 767px) {
  .popup {
    padding: 3px;
    top: 0;
    left: 0;
    margin: 0;
    width: 100%;
    height: 100%;
    border-radius: 0px;
  }
}
.popoverlay {
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0px;
  left: 0px;
  z-index: 2080;
  background-color: rgba(0,0,0,0.3);
}
#local-search-input {
  margin-bottom: 10px;
  width: 50%;
}
.popup-btn-close {
  position: absolute;
  top: 6px;
  right: 14px;
  color: #4ebd79;
  font-size: 14px;
  font-weight: bold;
  text-transform: uppercase;
  cursor: pointer;
}
#no-result {
  position: absolute;
  left: 44%;
  top: 42%;
  color: #ccc;
}
.busuanzi-count:before {
  content: " ";
  float: left;
  width: 260px;
  min-height: 25px;
}
@media (min-width: 768px) and (max-width: 991px) {
  .busuanzi-count {
    width: auto;
  }
  .busuanzi-count:before {
    display: none;
  }
}
@media (max-width: 767px) {
  .busuanzi-count {
    width: auto;
  }
  .busuanzi-count:before {
    display: none;
  }
}
.site-uv,
.site-pv,
.page-pv {
  display: inline-block;
}
.site-uv .busuanzi-value,
.site-pv .busuanzi-value,
.page-pv .busuanzi-value {
  margin: 0 5px;
}
.site-uv {
  margin-right: 10px;
}
.site-uv::after {
  content: "|";
  padding-left: 10px;
}
.algolia-popup {
  overflow: hidden;
  padding: 0;
}
.algolia-popup .popup-btn-close {
  padding-left: 15px;
  border-left: 1px solid #eee;
  top: 10px;
}
.algolia-popup .popup-btn-close .fa {
  color: #999;
  font-size: 18px;
}
.algolia-popup .popup-btn-close:hover .fa {
  color: #222;
}
.algolia-search {
  padding: 10px 15px 5px;
  max-height: 50px;
  border-bottom: 1px solid #ccc;
  background: #f5f5f5;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
}
.algolia-search-input-icon {
  display: inline-block;
  width: 20px;
}
.algolia-search-input-icon .fa {
  font-size: 18px;
}
.algolia-search-input {
  display: inline-block;
  width: calc(90% - 20px);
}
.algolia-search-input input {
  padding: 5px 0;
  width: 100%;
  outline: none;
  border: none;
  background: transparent;
}
.algolia-powered {
  float: right;
}
.algolia-powered img {
  display: inline-block;
  height: 18px;
  vertical-align: middle;
}
.algolia-results {
  position: relative;
  overflow: auto;
  padding: 10px 30px;
  height: calc(100% - 50px);
}
.algolia-results hr {
  margin: 10px 0;
}
.algolia-results .highlight {
  font-style: normal;
  margin: 0;
  padding: 0 2px;
  font-size: inherit;
  color: #f00;
}
.algolia-hits {
  margin-top: 20px;
}
.algolia-hit-item {
  margin: 15px 0;
}
.algolia-hit-item-link {
  display: block;
  border-bottom: 1px dashed #ccc;
  transition-duration: 0.2s;
  transition-timing-function: ease-in-out;
  transition-delay: 0s;
}
.algolia-pagination .pagination {
  margin-top: 40px;
  border-top: none;
  padding: 0;
}
.algolia-pagination .pagination-item {
  display: inline-block;
}
.algolia-pagination .page-number {
  border-top: none;
}
.algolia-pagination .page-number:hover {
  border-bottom: 1px solid #222;
}
.algolia-pagination .disabled-item {
  visibility: hidden;
}
```
* 将下面这张图片拷贝到你的source目录的images目录下
  ![Algolia图片](/images/algolia_logo.svg)

### OK，终于完成了，样子可以参照本站的搜索功能！