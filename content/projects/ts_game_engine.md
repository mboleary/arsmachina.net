---
title: Typescript Game Engine
description: A continuation of JSGE
date: 2025-04-04

taxonomies:
  tags:
    - typescript
    - web
    - nodejs
    - js
    - engine
    - framework
    - library
    - opensource

extra:
  titlecard: "bg-gradient-a2-a4"
  titlecard_text: fg-dark-color
  git_link: https://github.com/mboleary/test-ts-game

---

This project was a continuation of [JsGameEngine](@/projects/jsge.md) in an effort to start from scratch in Typescript and fix the issues present in the archetectual design of that project. There were some good ideas present here, including the modular archetecture allowing for different libraries and web standards to be used, and the code separation which would allow the game to be run on different Javascript runtines, such as the browser and NodeJS. This project is one of my first ones to include unit tests as a part of the initial development, which has helped to find bugs at the library level that would otherwise be hard to trace in such a big project.

See [So about that game engine...](@/blog/2025-04-04_game_engine.md) for more information on one of its first demos.

## Framework

I designed this first and foremost as a framework, and made an effort to split the code out into separate parts so that those parts could be used in different environments, such as a browser, or NodeJS. It's also designed to allow easy swapping of core components, implemented as plugins, so that if a 3rd-party library such as Three.js was desired, it can easily be swapped in.

## Subprojects

Given the modular architecture of the game engine, there are a few parts that could be considered separate projects.

### Entity Component System

[ECS Package](https://github.com/mboleary/test-ts-game/tree/demo_game_target/package/game_ecs)

This is an Entity Component System (ECS) implemented in Typescript that also has a query interface and the ability to set relationships between different Entities. The ECS separates the Entity data in the form of Components from the actual game logic, implemented in Systems. Internally, the ECS uses a cached query interface to keep track of Entities entering and leaving the group that matches a given query.

Speaking of the Query interface, it's currently implemented as a filter over all of the Entities. The Query itself is built as an object using the `Q` class for convenience, and then that object is used to generate a filter matching function that determines if an Entity matches the given query. While this is fine as an initial implementation, there are some improvements that can be made to make this process more efficient, such as by using an Archetype tree (Archetypes describe the components on an Entity) and parsing the Query Object into a sub-tree that matches.

This will be written about in a separate article in the future.

### Music Engine

[Music Engine Package](https://github.com/mboleary/test-ts-game/tree/demo_game_target/package/music_engine)
[Music Engine Frontend Package](https://github.com/mboleary/test-ts-game/tree/demo_game_target/package/music_engine_frontend)

The Music Engine is a continuation of [the JavaScript Advanced Music Engine](@/projects/js_adv_music_engine.md) with improvements in how timing works, a ground-up Typescript implementation, and a better architecture. This project is being co-developed with a frontend that will eventually become [BOrk](https://bork.deadcomputersociety.com) once it reaches feature parity with the original project. The Music Engine, much like its predecessor, is built to be a backend in a frontend environment, meaning that it's not directly tied to any specific frontend implementation. This allows it to be used in both this specific frontend implementation that shows a graph of the internal state of the Music Engine container, and also in the game engine, where audio emitter nodes can be set as Components on several Entities.

Currently, the Music Engine is capable of interacting with Midi ports on a device using WebMIDI, and can also generate polyphonic tones using an OscillatorNode implemented as an instrument. There is still a lot of work to be done, but the bones are there to support packaging WebAudio constructs into Music Engine Nodes, allowing their implementation to be portable.

This project will also be written about more in a separate article in the future.

## Plugin Architecture

The core idea of the game engine is that the game logic is separate from the game engine implementation through the use of Dependency Injection and this Plugin Architecture. Any feature required by the game, such as audio, graphics, and player input, are entirely implemented in Plugins that provide interfaces that can be used within the game logic to make the game playable. An example of how this looks can be seen with the [Pong Demo](https://github.com/mboleary/test-ts-game/blob/demo_game_target/package/example_game_pong/src/main.ts), an intentionally simple game implemented in this manner to be a proof-of-concept behind how this implementation structure works. Eventually the plugins used in this demo will be broken out into separate packages, and a new interface will be made for systems from plugins to have a way to be implemented.

Overall, the goal behind taking this approach was a greater flexibility in how the engine itself would be implemented. A developer should be able to use whatever libraries they want from the npm ecosystem, and a developer should also be able to implement the game logic once and be able to use it both in a frontend and backend context without needing to resort to weird mocks needing to be implemented.

## How it builds on [JSGE](@/projects/jsge.md)

This game engine is more like a framework, and as such most of the parts of the engine are split into separate packages that are agnostic to the engine as a whole, allowing them to be used in other contexts as a developer may see fit. This new engine also improves on the architecture of the previous interation by having a proper ECS implementation available, and having a more flexible plugin architecture, allowing different functionalities to be added to the game engine. This engine was also developed from the groud-up to be fully usable in both a Browser Javascript environment and in a backend environment with NodeJS.

## What's left?

There's still a lot of work to do on this game engine, and I'm not sure how far I'm going to get with this work before needing to spend time on other things. One big item though is to have other developers evaluate the framework and use it to build a game so that I can get feedback on the API design and overall architecture of the framework.

