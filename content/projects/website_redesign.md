+++
title = "Ars Materia"
description = "The new stylesheets for my website and a number of other projects"

date=2021-07-15

[taxonomies]
categories=["projects", "css", "web"]
tags=["html", "css", "styling", "ui-ux", "design", "library"]

[extra]
titlecard = "bg-gradient-a1-a2"
+++

{{ iconleft(icon="git-branch", class="", content="<b>Source Code on Github: <a href='https://github.com/mboleary/ars-css-next'>https://github.com/mboleary/ars-css-next</a></b>")}}
# Ars Materia

Ars Materia is the new theme that this website, as well as several other projects will use for styling. This redesign is similar in style to the old arsmachina styling, but is written in such a way that makes it easier to implement these styles elsewhere, as well as cut down on the number of files required to implement the styling, making it better to use on the web, and also to make the code more manageable.

## Project History

This is a continuation of the style first written by me in 2018 for a reboot of a hackathon project that displayed the grade averages for each class at USC, as that data was publicly available. That template eventually became the base for a student organization website, [acm.cse.sc.edu](https://web.archive.org/web/20191101120834/http://acm.cse.sc.edu/). After that, I also used the same template for this website which at the time hosted my portfolio for a New Media Arts class (MART380) that I took during my last semester of school, and my Graduation with Leadership Distinction portfolio as well which can be found at [https://cse.sc.edu/~mboleary/](https://cse.sc.edu/~mboleary/). At the time I initially wrote the styling, I was less familiar with the web ecosystem, and best practices in writing CSS and managing that much styling which ultimately led to code that was difficult to manage and use elsewhere. That was one of many factors that led me to rewrite the website styling.

## Project Goals

There were several shortcomings of the previous collection of css, [WebTemplate](https://github.com/Nesdood007/WebsiteTemplate) including:

- A lack of portability
- Hard-to-manage code
- Lots of colors not in the theme, as well as some more janky code to calculate other related colors.
- A terrible color as the dark mode background
- Lots of files

There were also some features that I wanted implemented that I would have had a hard time doing with the old stylesheets including:

- Toggle-able dark mode (implemented using an attribute on the &lt;body&gt; tag)
- Using the same header menu style on both the landing page (the one with just the cow, the title, and several buttons), and elsewhere on the website
- Some content cards because no modern website is complete without cards
- Making the styling system more modular
- Learn SCSS, and see if using a preprocessor can help to make my code more manageable

## What I learned

In embarking on this project, I learned that using a preprocessor like SCSS can help reduce the amount of code I need to manually write, and makes it much easier to package all of the styles in one file. I definitely should have started these stylesheets out like this.

## Next steps

There are some bugs I need to work out before I can deploy these new stylesheets permanently on this website, and I also need to fix some hard-to-read text in a few places, as well as finish rebuilding the template to be compatible with these new changes.

## Screenshots

{{ figure(src="/asset/ars_css_next_imgs/0.png", caption="First look at the new dark mode.") }}

{{ figure(src="/asset/ars_css_next_imgs/1.png", caption="Some different types of cards.") }}

{{ figure(src="/asset/ars_css_next_imgs/2.png", caption="Demonstration forms.") }}

{{ figure(src="/asset/ars_css_next_imgs/3.png", caption="Different types of tables") }}

{{ figure(src="/asset/ars_css_next_imgs/4.png", caption="Chips, which are going to be used as tags") }}

{{ figure(src="/asset/ars_css_next_imgs/5.png", caption="Modal popup demonstration") }}

{{ figure(src="/asset/ars_css_next_imgs/6.png", caption="Demonstration of translucent cards on top of a picture") }}

{{ figure(src="/asset/ars_css_next_imgs/7.png", caption="New list of articles") }}

{{ figure(src="/asset/ars_css_next_imgs/8.png", caption="New Table of Contents demo") }}

{{ figure(src="/asset/ars_css_next_imgs/9.png", caption="Demo of icons on an article") }}

{{ figure(src="/asset/ars_css_next_imgs/10.png", caption="Shows the footer, the new cow placement, and a share bar") }}