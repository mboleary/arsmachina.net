+++
title = "Javascript Advanced Music Engine (libJAME)"
description = "An advanced music and audio engine written in JS"

date=2023-06-09

[taxonomies]
categories=["projects", "libjame"]
tags=["code", "js", "html", "audio", "music", "engine", "library", "opensource"]

[extra]
titlecard = "bg-gradient-a3-a4"
titlecard_text="fg-dark-color text-shadow-dark"
+++

{{ iconleft(icon="git-branch", class="", content="<b>Engine Source Code on Github: <a href='https://github.com/mboleary/JsAdvancedMusicEngine'>https://github.com/mboleary/JsAdvancedMusicEngine</a></b>")}}

{{ iconleft(icon="git-branch", class="", content="<b>Demo Source Code on Github: <a href='https://github.com/mboleary/BOrk'>https://github.com/mboleary/BOrk</a></b>")}}

{{ iconleft(icon="link", class="", content="<b>See the web demo: <a href='https://bork.deadcomputersociety.com/'>https://bork.deadcomputersociety.com/</a></b>")}}

LibJAME, or the Advanced Music Engine, was a project that was born out of the development of the [Js Game Engine](https://github.com/mboleary/JsGameEngine). I wanted to build a library capable of playing back multiple audio tracks at one with the ability to gate a playback loop, as well as having an excuse to learn more about the [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API), including generating sounds using oscillators, sequencing midi loops on top of the playback audio, and [interfacing with MIDI Devices](https://developer.mozilla.org/en-US/docs/Web/API/Web_MIDI_API). While I did not get around to fully implementing the features I wanted, I did end up with a cool demo, which can be found in the links above.

## Project Inspiration and Motivation

Inspiration was taken from software like [Pure Data](https://puredata.info/), where there were graphical nodes that could be connected to each other. I ended up building an interface that would sit in front of the parameters of AudioNodes, abstracting away some of the rough edges of the Web Audio API (though some of this ended up not being as necessary as I originally thought).

In addition, there were plans to have a way to serialize the nodes and their connection matrix to JSON, allowing the possibility of creating the setup in a separate webapp, exporting the serialized JSON data, and then using it in another application to construct the audio setup there.

## Web Demo

BOrk, or Browser Orchestra, is a demo of this library using React. The demo visualizes connections between nodes, and allows the user to connect up these nodes in order to control where the sound goes, in addition to directly controlling some of the parameters of these nodes, such as the frequency and the start/stop playback.

{{ figure(src="/asset/libjame/bork.png", caption="The React Webapp demo") }}

## Use in the Game Engine

This audio engine was originally designed as a [Game Engine](https://github.com/mboleary/JsGameEngine) module ([see the module export here](https://github.com/mboleary/JsAdvancedMusicEngine/blob/master/packages/libjame/src/Audio.js#L7)), but evolved into something that would likely be useful elsewhere as well.

## Current State

The library is functional, but not fully-featured, and the web demo could certainly be extended.

## Future

Given that other libraries exist to accomplish similar goals to mine, such as [tone.js](https://tonejs.github.io/), I'm probably not going to develop this much further until I find some reason that existing libraries won't meet my current needs, or I develop something new using WASM, given that it will probably be able to directly interface with those APIs in the future.
