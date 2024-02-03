## Basic Syntax
Class information should always be in the `Property = Value` format. This **applies to every item in the dictionary.** For example, to change the `Transparency`, your line of code should look like this:

```lua
Transparency = .5
```

???+ note "Tip"
    Don't forget your commas! Class info is still just a dictionary.


## Advanced Syntax
In addition to basic Properties, RoCSS supports transition and hover values.


### **transition**
```lua
transition: {String}
```
The transition key in a class info `dictionary` should be a `table` of properties that should be smoothly transitioned.

???+ warning "Warning"
    The `transition` table **should not** contain the value you wish the properties to be. Those are still defined in the [onhover dictionary](syntax.md#onhover).


### **transition_time**
```lua
transition_time: number
```
The `transition_time` key defines the time it should take **all** of the properties in the [transition table](syntax.md#transition) to transition from value a to value b.



### onhover
```lua
onhover: {String: any}
```
The `onhover` key defines a dictionary of properties and their respective values that will be changed when a user's mouse enters a member of the class. All properties in this dictionary will be **immediately** changed unless listed in the [transition table](syntax.md#transition), in which case they will be `tweened` in the time defined as the [transition_time key](syntax.md#transition_time).