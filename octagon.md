---
layout: page
title: Recent Octagon Stories
permalink: /octagon/
redirect_from:
  - /about-1/
---

<p class="page-kicker">My Recent Octagon Work</p>

Just a few of the best stories and pages I've made recently, hope you enjoy!

## Stories

- [The Sameness Of Life: My Philisophical Musings On Living In The Now](https://www.scdsoctagon.com/online-exclusives/opinion/2022/02/02/my-angle-the-sameness-of-life/)
- [A Q&A With A Graduated Senior At UC Davis](https://www.scdsoctagon.com/online-exclusives/features/2022/01/31/freshman-focus-elijah-azar-21-commutes-to-and-enjoys-classes-at-uc-davis/)
- [My Editorial On Bringing Back A Beloved College Tradition](https://www.scdsoctagon.com/online-exclusives/opinion/2022/02/01/editorial-why-the-mm-man-should-come-back/)

## Pages

<div class="gallery">
  {% for p in site.data.octagon_pages %}
  <a href="{{ p.image | relative_url }}"><img src="{{ p.image | relative_url }}" alt="{{ p.title }}" loading="lazy"><span>{{ p.title }}</span></a>
  {% endfor %}
</div>
