{% if theme.statement %}
  <div id="end-share">
        <div id="eof" class="print-invisible">
            <hr class="eof">
        </div>
        <style type="text/css">
            hr.eof {
              text-align: center;
              border: 0;
              height: 1px;
              background-image: -webkit-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
              background-image: -moz-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
              background-image: -ms-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
              background-image: -o-linear-gradient(left, #f0f0f0, #8c8b8b, #f0f0f0);
              margin: 40px 0px 10px 0;
            }
            hr.eof:after {
              content: '{{ config.title }}';
              display: inline-block;
              position: relative;
              top: -13px;
              padding: 0 10px;
              background: #fff;
              color: #8c8b8b;
            }
        </style>
        <div align="center">
            <p><a href="{{ page.permalink }}">本文章</a>由<a href="{{ config.url }}" >{{ config.title }}</a>制作，转载请注明出处</p>
        </div>
  </div>
{% endif %}
