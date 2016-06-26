<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

<div class="copyright">
  <span>HEXO-NEXT | 粤ICP备14100221号-5</span>
</div>

<div class="copyright">
  {% include '../_scripts/third-party/analytics/cnzz-analytics.swig' %}
</div>
