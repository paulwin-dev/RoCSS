???+ warning "Important"

    The module **must** placed somewhere accessible to the `client`. It is common practice to put services like RoCSS into `ReplicatedStorage`, just make
    sure it's not located in `ServerScriptService` or `ServerStorage`. The examples on this website will assume it's located in `ReplicatedStorage`.

## Initializing the Module
In order for RoCSS to work, you will need `two` scripts: a `LocalScript` to initialize RoCSS and a `ModuleScript` to define your styles.


Add a new `ModuleScript` instance to `game.ReplicatedStorage`. You can name it whatever you want, the examples on this page will assume it's called "styles". This module script is where you'll be defining your styles. The general syntax shoud look like this:
```lua
return {
    ["ClassName"] = {
        Property = Value
    }
}
```

Next, we need to `initialize` the module. Create a new `LocalScript` instance inside of `game.StarterPlayer.StarterPlayerScripts`:
```lua
local RoCSS = require(game.ReplicatedStorage.RoCSS) -- require the RoCSS module
local styles = require(game.ReplicatedStorage.styles) -- require our stylesheet

RoCSS.init(styles) -- to initialize RoCSS with our stylesheet, pass it as a parameter into the .init() function
```