+++
title = "Mandelbrot Explorer"
description = "This is a mandelbrot demo that I built in Javascript in order to learn how the canvas works"

date=2019-10-31

[taxonomies]
categories=["projects", "art"]
tags=["code", "js", "mandelbrot", "canvas"]

[extra]
titlecard = "img"
titlecard_text="fg-dark-color text-shadow-dark"
titlecard_image = "/asset/mandelbrot.png"
git_link = "https://github.com/mboleary/fractals-canvas"
+++

{{ iconleft(icon="link", class="", content="<b><a href='/extern/fractals-canvas'>Go here to see it in action</a></b>")}}

# Mandelbrot Explorer

This was a testing project for me to learn how the canvas works in Javascript, as well as how I can color the Mandelbrot set. This was written without the use of a Javascript Framework.

There are additional Images in the repo linked above.

## Motivation

I built this demo as a way to learn Javascript, and how to specifically use the Canvas to draw things.

## How to run this locally

Go to the repository above, and clone or download the code locally. In there, use `python3 -m http.server 8000 --bind 127.0.0.1` in a console, and then open a web browser and navigate to `localhost:8000`.
