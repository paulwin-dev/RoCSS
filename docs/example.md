???+ note "Info"
    This example assumes that you've inserted RoCSS into `game.ReplicatedStorage` along with a module script called "styles" and that you've added at `LocalScript` instance into `game.StarterPlayer.StarterPlayerScripts`.

 In this example, we will be making a `Class` called "Example" with a black `BackgroundColor3` that rotates `45°` whenever we hover over it.

## Creating the GUI Element
First off, let's create a `ScreenGui` instance inside of `game.StarterGui`. Inside of this `ScreenGui`, add a new `Frame` instance. You should see a white square appear on your screen.
<br>

## Tagging the Element
Next, we need to make this GUI element a member of a `Class` called `Example`. Select the `Frame` scroll down in the `Properties` window until you see the `Tags` section. Click on the `+` icon next to the `Tags` header and type `Example` into the text box that appears. Now, press enter to create a new `tag` called `Example`.

## Changing the Background Color
Now that we've created a new `Frame` and made it a member of our `Example` class, let's style any `Example` class members to have a black `BackgroundColor3`. Open the **styles** `ModuleScript`:

```lua
return {
    Example = { -- create a section for our class
        BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- change the BackgroundColor3 of any Example class members to black
    }
}
```

## Initializing RoCSS
Now that we've created a very simple `class`, let's initialize RoCSS and style our elements! Open your `LocalScript`:

```lua
local RoCSS = require(game.ReplicatedStorage.RoCSS)
local styles = require(game.ReplicatedStorage.styles)

task.wait(2)

RoCSS.init(styles)
```
???+ warning "Warning"
    Due to RoCSS relying on `CollectionService` to get all members of a class, you **must** wait until all GUI elements have been replicated before you initialize it. Not waiting will lead to an empty `CollectionService:GetTagged()` table and no class members being recognized.

You should now have a white Frame that turns black after a couple seconds.


## Adding a Hover Effect
In addition to supporting regular property changing, RoCSS also supports hover effects by adding a `Dictionary` called "onhover" into the class information. We will be making our `Frame` smoothly rotate `45°` on hover, so open your **styles** `ModuleScript` again:

```lua
return {
    Example = {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        onhover = {
            Rotation = 45, -- change the rotation of class members to 45° on hover
        }
    }
}
```

Click on *Play*, and you should now have a black frame that rotates 45 degrees when you hover over it, but something is missing...


## Smooth Transitions
While our `Frame` now rotates 45° when we hover over it, it does so instantly. This doesn't look good, so let's make it smoothly transition in one second. To do this, we will utilize the `transition` and `transition_time` values in our class info `dictionary`:

```lua
return {
    Example = {
        transition = {"Rotation"}, -- a table of all properties you wish to smoothly transition
        transition_time = 1, -- specify how long you want the transition to take
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        onhover = {
            Rotation = 45,
        }
    }
}
```

Congrats! You should now have a `Frame` with a black background that smoothly rotates `45°` in one second when your mouse enters it and transitions back to a rotation of 0° when your mouse leaves the `Frame`.
???+ note "Info"
    Once you've set up your class, you can add as many members as you wish to it by adding the class name as a tag in those objects!



## Final Scripts

*styles `ModuleScript`:*

```lua
return {
    Example = { -- create a section for our class
        transition = {"Rotation"}, -- a table of all properties you wish to smoothly transition
        transition_time = 1, -- specify how long you want the transition to take
        BackgroundColor3 = Color3.fromRGB(0, 0, 0), -- change the BackgroundColor3 of any Example class members to black
        onhover = {
            Rotation = 45, -- change the rotation of class members to 45° on hover
        },
    },
}
```

*`LocalScript`:*
```lua
local RoCSS = require(game.ReplicatedStorage.RoCSS)
local styles = require(game.ReplicatedStorage.styles)

task.wait(2)

RoCSS.init(styles)
```