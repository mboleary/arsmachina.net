+++
title = "Javascript Game Engine (JSGE)"
description = "A modular game engine written in JS"

date=2022-06-29

draft = true

[taxonomies]
categories=["projects", "jsge"]
tags=["code", "js", "html", "game", "engine", "library", "opensource"]

[extra]
titlecard = "bg-gradient-a2-a4"
titlecard_text="fg-dark-color text-shadow-dark"
+++

{{ iconleft(icon="git-branch", class="", content="<b>Source Code on Github: <a href='https://github.com/mboleary/JsGameEngine'>https://github.com/mboleary/JsGameEngine</a></b>")}}

The Javascript Game Engine (JSGE) is a modular game engine that I've been working on since [April 2020](https://github.com/mboleary/JsGameEngine/commit/1ed2e7b541b6f7930c7e059c76468eef48b6dc16), and was my pandemic project. While the initial goal was for me to learn the Web APIs better, it evolved into a series of libraries that I can integrate into other projects, and also an engine that can easily be used in a variety of ways and integrated with other 3rd party libraries.

## Original Idea and Goals

When I was building the original version of the game engine, I set out with a few goals:

- Learn more about the various Web APIs, including
    - Input sources such as keyboard, mouse, and gamepads
    - Audio APIs
    - 2D Graphics with the canvas
    - Websockets
- Build some reusable components that can be shared to other projects
- Learn more about software architecture
- Make some interesting demos that I can put on the website
- Enable multiplayer using websockets

I figured that despite many other engines already existing targeting the frontend web browser, I would have a lot to learn from developing my own, and that creating one would help me learn more about those APIs.

With those goals in mind, I set out to create the first prototype over the period of a few days.

### Engine

The engine itself was created with the idea that a developer would extend some base classes to implement a game, and all logic for things like rendering sprites, playing audio, and handling networking would be included within those classes. While this worked fine at first, I would later come to the conclusion that some changes would need to be made in order to make it easier to reuse those component I built, and also lessen the amount of code that would need to be duplicated.

### Networking and Multiplayer

One of the big features I had planned for the engine was to make it easy to add multiplayer support. This type of multiplayer support was originally implemented in a fairly naive way, not taking into account networking latency and the potential for packets to get lost, or clients attempting to hijack the game by sending other updates. It ended up with a system where all clients would send the state of their gameobjects to a server which would cache the data as well as dispatch those updates to other connected clients. A client would have ownership of a gameobject, and would regularly send update messages to the server, which would then distribute those events out to the other connected clients. In addition, the server also supported sending messages directly to a client for communicating events such as keys pressed to update the gameobject owned by another client. Given that the websocket server itself knew nothing of the game, it was expected that one of the clients would act as a master state for the game.

I made a demo for this, however getting it to work was never made particularly ergonomic in terms of the code that had to be written and run. Basically, it used some old art assets I made for a separate game demo and would allow a user to move around a sprite on all connected clients. I wrote 2 versions of this demo; one version would constantly update all state, including the translation of the sprite, and the other would also update the acceleration and rely on the locally-running scripts to handle the translation. As you might expect, the latter version visually looked better given that it was relying on second-order effects for changing its state, however there were still desyncs where the sprite would jump to another place, but the motion was overall more fluid.

## Refactor

I realied a few things at the end of the first development run:

1. The code was not ergonomic to work with as a developer
2. The different parts of the game engine relied on each other and as a result made it difficult to split up the code
3. I might want to use some external dependencies for some parts of the engine
4. Running things directly from source was causing weird issues such as some files being imported twice
5. I wanted to continue building things on top of the engine

And around that time, I finally found some time and had the energy to work on this again. I decided to tackle some of these issues with the end goal of building somethin that was easier to use and more enjoyable to work on, however this would be a big undertaking and break most features present. Given that I was the only person using this codebase, I saw no harm in moving forward with those changes.

These were my new goals:
- Publish NPM packages for the engine
- Split the code into packagable modules that could potentially be used in other contexts
- Make the code more ergonomic to work with
- Harness the power of Typescript to help fix some problems before they became hard-to-debug issues
- Make it easy to replace my modules with other ones

I began by merging all of the separate feature branches into the master branch, and then split off from there to do the refactor. This also involved refactoring lots of pieces of code into several classes.

Using this architecture should allow developer to also include their own modules, or create modules for 3rd-party packages that might be useful in that context.

### Code Style and Splitting

I began by finding where accessory features to the engine could be split off into their own packages. This was an original goal, where I could simply not include the features I didn't need, but was actually not possible with the old architecture of the engine. This ended up with me building this module system to handle importing different engine features, such as input, graphics, and sound, and then moving those modules into separate NPM packages so that a developer can choose which modules to include.

In addition, I also made those modules into proper classes, where the configuration can be passed in as an object, and the module instance simply added to the engine.

### Modules and NPM

In splitting those modules, I created NPM packages to house those features, in addition to the asset loader and the code engine itself. This allows a developer to simply download and include only the needed packages and nothing else.

### Entity-Component System

This was one of the larger changes made in the engine. This modified the structure of the engine to allow for reusable components and less boilerplate code. In short, the Modules provide Components that can be used by Entities to add features to the game. This also invloved expanding the original scripts to be descended from components.

#### Modules

#### Entities

#### Components

### Typescript conversion

In working on this codebase, I discovered many bugs that were caused by having the wrong object in the wrong place, which caused many hard-to-debug issues. This was around the same time that i started to use Typescript in a different project and wanted to take the opportunity to learn more about it.