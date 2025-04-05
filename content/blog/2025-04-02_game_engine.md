---
title: So about that game engine...
description: The framework makes the game work
date: 2025-04-02

draft: true

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

So, about that game engine...

In an earlier blog post, I talked about abandoning it because I didn't feel like there was much benefit to working on it. However, I recently started working towards making a demo game to help pull the different parts together. This involved updating several pieces to support the new plugin format and structure and fixing a few bugs that came up in some of the supporting libraries. This culminated in a version of Pong, which I implemented because it was a simple game that I could use to validate the architecture of this framework.

## The Demo

{{ figure(src="/asset/2025-04-02_game_engine/pong.png", caption="An implementation of Pong using an ECS" )}}

As a demonstration, I implemented the game [Pong](https://en.wikipedia.org/wiki/Pong) given its simplicity. I intentionally chose a simple game to implement so that I could focus on validating the design of the game engine and some simple plugins to see that it worked correctly. Below, you can see some code examples from it.

One goal of this project was to have all of the engine functionality contained in Plugins, which provide some interfaces for things like drawing graphics to the screen, handling input, and managing the ECS. While this project has some simple plugins co-located within the demo game, they will eventually be fleshed out and moved into their own repositories.

### The Main Function

To create a game with this framework, this is all that's needed within to build and start the game engine:

```ts
import { Engine } from "game_core";
import { buildScene } from "./scene_main";
import { InputPlugin } from "./plugins/basicInput/Input.plugin";
import { Container } from "inversify";
import { Input } from "./plugins/basicInput/Input";
import { ECSPlugin } from "./plugins/ecsPlugin/ECS.plugin";
import { Hotloop } from "game_core_browser";
import { Graphics2DPlugin } from "./plugins/graphics2d_example/Graphics2D.plugin";
import { Graphics2D } from "./plugins/graphics2d_example/g2d/Graphics2D";
function main() {
  const container = new Container();
  const engine = new Engine(container);

  const inputPlugin = InputPlugin.build({
    bindings: [
      { name: "up", key: "ArrowUp" },
      { name: "down", key: "ArrowDown" },
    ],
  });

  const ecsPlugin = ECSPlugin.build({
    initCallback: async () => {
      const world = buildScene(container.get(Input), container.get(Graphics2D));
      console.log("world", world);
      return world;
    }
  });

  const graphics2dPlugin = Graphics2DPlugin.build({
    canvasTarget: document.getElementById("canvas") as HTMLCanvasElement,
    overlayTarget: document.getElementById("overlay") as HTMLDivElement,
  });

  const hotloopPlugin = Hotloop.build();

  engine.initialize([hotloopPlugin, inputPlugin, ecsPlugin, graphics2dPlugin]);

  engine.start();

  window.addEventListener("beforeunload", (e) => {
    engine.destroy();
  });
}
main();
```

Above, note how there are 3 plugins added to the engine; the `InputPlugin`, `ECSPlugin`, and `Graphics2DPlugin`. These plugins each provide some interfaces that are used for Input and Graphics, as well as the game ECS. While this design is not quite finalized, this encompasses the overall goal to separate that functionality from the actual game logic.

Speaking of the game logic, that can be found in [the scene_main.ts file](https://github.com/mboleary/test-ts-game/blob/demo_game_target/package/example_game_pong/src/scene_main.ts). Let's look at a few parts of that file to get a sense of what's happening there. From the file name, it should be obvious that the `buildScene` function generates the scene structure, returning an ECS `World` instance.

```ts
const world = new World({ lifecycles: [SystemLifecycle.INIT, SystemLifecycle.LOOP, SystemLifecycle.DESTROY] });
```

This creates the ECS world, and specifies some lifecycle points for the Systems, which we'll come back to later.

```ts
function createLeftPaddleEntity(world: World) {
  // Player-Controlled Paddle
  const pc = { key: "pc", value: null };
  const lPaddle = { key: "paddle", value: { size: 20 } };
  const lpSpeed = { key: "speed", value: SPEED };
  const lpPosition = { key: "transform", value: new Vector2(10, 10) };
  const lpAcceleration = { key: "acceleration", value: new Vector2(0, 0) };
  const lpName = { key: "name", value: "Left Paddle" };
  const lpCollider = { key: "collider", value: [new Vector2(0, 0), new Vector2(20, 50)]};
  const lpGraphics = { key: Shape.key, value: new Shape(lpPosition.value, Shapes.RECTANGLE, lpCollider.value[1].x, lpCollider.value[1].y) };
  const leftPaddle = world.createEntity(undefined, [lpName, pc, lPaddle, lpSpeed, lpPosition, lpAcceleration, lpGraphics, lpCollider]);

  return leftPaddle;
}
```

This generates an Entity, in this case the Left Paddle which is player controlled. Fun fact: if the `pc` key is replaced with the `ai` key, then the left paddle will also become computer-controlled! This is one of the upsides of using an ECS in that it adds flexibility to how the game is built.

```ts
const playerControlSystem = System.build(SystemLifecycle.LOOP, Q.AND(["pc", "acceleration", "speed"]), (entities) => {
    for (const entity of entities) {
        const acc = entity.getComponent("acceleration") as Vector2;
        const speed = entity.getComponent("speed") as number;
        const transform = entity.getComponent("transform") as Vector2;

        if (input.getKey("up") && transform.y > BTM_BOUNDS) {
            acc.set(acc.x, -speed);
        } else if (input.getKey("down") && transform.y < TOP_BOUNDS) {
            acc.set(acc.x, speed);
        } else {
            acc.set(acc.x, 0);
        }
    }
});
```

Here is an example of a System. It runs on the loop lifecycle and queries for all entities with the components `"pc"`, `"acceleration"`, and `"speed"`. Under the hood, this query is actually cached, meaning that instead of searching for all of those entities every time the lifecycle is run (in this case every frame), the results are updated only when an entity is added, updated, or removed. This system makes use of `input`, which is one of those interfaces mentioned earlier, to get user input from the keyboard. One other thing, this system only sets the acceleration of the Entity, not its actual position. Where does that happen?

```ts
const movementSystem = System.build(SystemLifecycle.LOOP, Q.AND(["acceleration", "transform"]), (entities) => {
    for (const entity of entities) {
        const transform = entity.getComponent("transform") as Vector2;
        const acc = entity.getComponent("acceleration") as Vector2;

        transform.add(acc);
    }
});
```

This system is responsible for actually moving the Entities on the screen, given that it's searching for those with the `"acceleration"` and `"transform"` components.

There are other systems as well for controlling the computer-controlled paddles, moving the ball, and detecting collisions.

## The Framework Makes the Game Work

Let's be honest about what this game engine actually is: it's a framework. The `game_core` package contains a harness into which several plugins are added to give the game functionality such as Input, Graphics, and the scene which is being rendered. This was an intentional decision in that one of the goals was to create a project where a developer can import the parts needed for a given game and leave everything else out so as to reduce the amount of code needed to run the game, while making it flexible and easy to develop. However, the option is also present for a developer to pull only the pieces they want from the engine and build their own custom engine or integrate those parts into another game engine. In that sense, this project is actually a framework for building games and game engines. It's this framework that makes the game work, after all.

Here's an example of one of those plugins:

```ts
import { ContainerModule, inject, injectable, interfaces } from "inversify";
import { BuiltPlugin, PluginOptions, Plugin } from "game_core";
import { InputOptionsToken } from "./tokens.const";
import { InputBinding } from "./binding.type";
import { destroy, init, Input } from "./Input";

export type InputPluginOptions = {
  lifecycleOptions?: PluginOptions;
  bindings: InputBinding[];
}

@injectable()
export class InputPlugin extends Plugin {
  constructor(
    @inject(InputOptionsToken) private readonly options: InputPluginOptions,
    @inject(Input) private readonly input: Input
  ) {
    console.log('construct input');
    super(options.lifecycleOptions);
  }

  public async init(): Promise<void> {
    console.log('init');
    // Set and define keybindings
    for (const binding of this.options.bindings) {
      this.input.defineKey(binding.name);
      this.input.bindKey(binding.name, binding.key);
    }

    init()
  }

  public async destroy(): Promise<void> {
    destroy();
  }

  static build(options: InputPluginOptions): BuiltPlugin {
    const containerModule = new ContainerModule((bind: interfaces.Bind) => {
      bind(InputOptionsToken).toConstantValue(options);
      bind(InputPlugin).toSelf();
      bind(Input).toConstantValue(new Input());
    });

    return {
      plugin: InputPlugin,
      containerModule
    }
  }
}
```

This is the Input Plugin, which handles `KeyboardEvents` to detect input from the keyboard. It, along with the `game_core` library make use of [Inversify](https://inversify.io/), an Inversion of Control (IoC) library which is mainly used here for dependency injection. The Plugin defines hooks which are used to call into other dependencies to manage it throughout the lifecycle of the game engine, enabling a modular architecture which can easily be changed if required. In addition, this affords an easy conversion of the game to a server component, since the game logic is separated from the actual game engine itself. If networked multiplayer support was to be added to this game, it would be easy to construct a NodeJS version of the game engine, import the Entities, leave some systems like graphics and input out if not needed on the backend, and instead add a plugin that manages network state. Portablility is one of the other goals of this engine.

## Future

Let's be honest about what this project has been for most of its life: Yak Shaving.

{{ figure(src="/asset/2025-04-02_game_engine/yak_shaving.jpg", caption="Yak Shaving") }}

Image: David Revoy[^1]

In fact, it got to the point where it's not clear what the original objective even was with this project. It's been through at least 3 re-writes, starting with the original iteration [JsGameEngine](@/projects/jsge.md), its conversion to Typescript, then a group-up rewrite in a new repository in Typescript along with some new architecture ideas around [Inversion of Control](https://en.wikipedia.org/wiki/Inversion_of_control) and [Entity Component Systems](https://en.wikipedia.org/wiki/Entity_component_system). What started in 2020 at the beginning of the COVID-19 Pandemic as a learning project for web APIs evolved into a learning project for software architecture, and then into a project that I just wanted to have finished so that I could have something to show for it. While this game doesn't even touch the true capabilities of the framework approach, it seems like a good starting point to step off into incremental improvements and adding new features, and potentially trying to form a community around this project.

That brings us to what the point of this project is. To be honest, I'm not sure anymore. I think I just wanted to build a game engine because I thought it would be a fun and enriching activity, but I've discovered that it ended up turning into something that felt a lot more like work than fun, and there were points where I didn't dedicate much time to this because I didn't see the value in it. That being said, I think I also wanted some greenfield projects to show off, which is what's motivated me to continue working on it.

So in all, I'm not sure what the future's going to bring for this project, but if you find this useful or end up trying it out, I'd love to hear about it!

[^1]: By <a href="https://en.wikipedia.org/wiki/en:David_Revoy" class="extiw" title="w:en:David Revoy"><span title="French illustrator and creator of the webcomic ''Pepper&amp;Carrot''">David Revoy</span></a> - <a rel="nofollow" class="external free" href="https://davidrevoy.com/article861">https://davidrevoy.com/article861</a>, <a href="https://creativecommons.org/licenses/by/4.0" title="Creative Commons Attribution 4.0">CC BY 4.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=113890788">Link</a>

