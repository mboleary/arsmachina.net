+++
title = "About This Website"
description = "Information about this website."

weight = 1

[extra]
titlecard = "bg-gradient-lightgray"
titlecard_text="fg-light-color"
toc = [{"title"= "Website Status","id"= "website-status"}]
hide_icons = true
+++
  
## Static Website

This website is what's known as a __Static Website__, meaning that the content that you see on the web browser is exactly the same as what I upload to the server, versus a Dynamic Website, where the content is generated right as you view the webpage either on the server, or in your web browser. I chose to make these static websites so that the page loads faster.
  
## Code

I wrote this website by hand using a template written in HyperText Markup Language (HTML) and Cascading StyleSheets (CSS). This template was originally designed for use with a different project, however was repurposed for both this website, my [Graduation with Leadership Distinction E-Portfolio](https://cse.sc.edu/~mboleary), and the [ACM Website](https://acm.cse.sc.edu). You'll notice how many of the styles are the same, and this is because I can use the same CSS code for both websites. I typically update the code in a common repository, and then move the CSS files to both websites, allowing me to keep all of my websites' styles up to date, and not creating a mess in the process.

## Generation

Through this website's history, I've run through a few ways to build and maintain the website.
### Old arsMach

The old version of the website was generated using a script I improved upon from the Internet, called [Static Site Generator 4 (SSG4)](https://www.romanzolotarev.com/ssg.html). I wrote an index generator in the Python Programming Language which reads all articles in the source code to find information about titles, summaries, and sorting values to determine the order of content in the index. My script is pretty flexible in this regard, whereas the end user may add additional information to display in the index. The source code for my fork of SSG4, [SSGTools, may be found here.](https://github.com/Nesdood007/ssgtools) I run this on my computer every time I want to update the content on the website.

### Arsmachina.net

Due to many limitations of the SSG4 Implementation, and considering that it was meant to be a temporary solution for me managing the University of South Carolina's [ACM Chapter Website](https://acm.cse.sc.edu), I decided to use [Zola](https://www.getzola.org/), which is feature-rich and written in Rust. Rebuilding this website using Zola has allowed for me to implement a number of new features into the website that would have required re-writing large portions of the old SSG, or applying hacky scripts on top of it.
### Current Website

I'm still using Zola as described above, but I've moved domains to `deadcomputersociety.com`. Some small styling changes have occurred, but it largely looks the same as it did previously.


## Open Source

I have made available the Generated Source Code of my website. [It can be found here.](https://gitlab.com/mboleary/mboleary.gitlab.io) There is also a link there to the source which the website is generated from.

