# Day 32 – Project 6, Part One

Today we are going to work with implicit animations, explicit animations, binding animations, and more.

## Creating Implicit Animations

* Implicit animations are basically telling how a view should behave if someone tries to invoke animations.
* Here, the `scaleEffect` modifier is used to enlarge the button on each tap. Some amount of it is scaled.
* For that, we used a `@State` variable to keep track of how much to enlarge it.
* The `.animation` modifier is added with a default parameter and the value set to the state variable.
* `blur` is another modifier used just to blur the button visual.

---

## Customizing Animations in SwiftUI

* `.linear` has a smooth initial start to it and then it sort of overshoots the animation. Like a start-and-stop animation.
* **Tip:** If you were curious, implicit animations always need to watch a particular value; otherwise, animations would be triggered for every small change—even rotating the device from portrait to landscape would trigger the animation, which would look strange.
* iOS chooses spring animations by default because they mimic what we're used to in the real world. These are hugely customizable: you can control roughly how long the spring should take to complete and also how bouncy the spring should be—whether it should bounce back and forwards more or less, where `1` is maximum bounciness and `0` is no bounciness.
* For example, this makes our button scale up quickly and then bounce a lot:

```swift
.animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
```

* For more precise control:

```swift
.animation(.easeOut(duration: 2), value: animationAmount)
```

* This allows us to create an ease-in-out animation that lasts for two seconds.
* You can also add a delay to the `easeOut` parameter.
* For example:

```swift
.animation(.easeOut(duration: 1).repeatCount(3, autoreverses: true), value: animationAmount)
```

* Using `autoreverses` as `true` allows the animation to bounce back and forward. This creates a one-second animation that will bounce up and down before reaching its final size.
* For continuous animation, there is the `repeatForever()` modifier which can be used.
* You can use `repeatForever()` and `onAppear` in combination to start an animation immediately when the life of the view starts.
* To achieve this, we are going to apply it to an overlay to make a sort of pulsating circle around the button.
* Overlays are modifiers which let us create new views at the same size and position as the view we’re overlaying.
* In the overlay, it makes a stroked red circle over our button using the opacity value.
* We removed all the modifiers with respect to `scaleEffect` and `blur`, added the overlay, and in `onAppear` set the value of `animationAmount = 2`. This gave a very pulsating and beating effect to the circle. **Spectacular effect!**

---

## Animating Bindings

* `animation()` can be applied to a SwiftUI binding also, even if the binding is a Boolean.
* We printed the `animationAmount` and returned the `VStack`. This is just to see how the behavior of the `animation()` works when added to a modifier.
* Here, SwiftUI examines the state of our view before the binding changes, examines the target state of our views after the binding changes, and then applies an animation to get from point A to point B.
* In this case, since we are adding the animation to the binding variable, we don’t need to explicitly pass the animation value.
* This changes how animations work. An animation does not necessarily need to be added to a view and implicitly animate it with a state change.

---

## Creating Explicit Animations

* Now we are going to make the animation rotate with a 3D effect. This uses `rotation3DEffect()`.
* This can be given with degrees and an axis that determines how the view rotates.
* Think of the axis as a skewer through the view:

  * **X-axis:** Spin forwards and backwards.
  * **Y-axis:** Spin left and right.
  * **Z-axis:** Rotate left and right.
* This requires a state so that we can modify the rotation, and rotation degrees are specified as `Double`.
* Example:

```swift
rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
```

* To the `withAnimation`, if we pass in:

```swift
withAnimation(.spring(duration: 1, bounce: 0.5))
```

it adds a very lovely effect.

---

# Day 33 – Project 6, Part Two

Multiple animations, gesture animations, and transitions.

## Controlling the Animation Stack

* Modifier order matters.
* We can apply the `animation()` modifier to a view in order to have it implicitly animate changes.
* You can add the `animation()` modifier multiple times, and the order in which you use it matters.
* So I added it before and after the animation modifier. When I added it after the animation modifier, it changed shape but it didn’t animate through the transition. Whereas when we added it before the animation modifier, it animated and transitioned smoothly.
* **ONLY CHANGES THAT OCCUR BEFORE THE `animation()` MODIFIER GET ANIMATED.**
* When we try to split the animations and try to individually apply them, it doesn’t work the same way. Multiple `animation()` modifiers, if you try to move or change them, basically undo the work.

---

## Animating Gestures

* In this lesson, we created a `LinearGradient`, giving it a `startPoint`, `endPoint`, colors, and a frame.
* We took a `@State` variable:

```swift
@State var dragAmount = CGSize.zero
```

* `offset()` can manipulate the X and Y coordinates of a view without moving the other views around. It takes `CGSize` directly.
* A `DragGesture` has two extra modifiers:

  * `onChanged()` runs a closure whenever the user moves their finger.
  * `onEnded()` runs a closure when the user lifts their finger off the screen, ending the drag.
* This allows the UI to change properly and return back to the origin, i.e. the initial/zero position.
* Adding `.bouncy` gives it a good smooth transition.
* `.bouncy` is one of the built-in animation options for SwiftUI, producing a spring with a gentle bounce.
* When we add `withAnimation`, the card will follow your drag immediately, but when you release it, it will animate.
* If we combine offset animations with drag gestures and a little delay, we can create remarkably fun animations without a lot of code.
* In the given example, we took a string in an array and looped over each letter. We gave it padding, font, background with a ternary operator, offset, and animation.
* We gave it a linear animation with a delay.
* In the gesture, we added a `DragGesture` and passed the value to `onChanged`.

---

## Showing and Hiding Views with Transitions

* Here we are showing and hiding views based on a button click.
* We use a `@State` variable and change the value on toggle.
* We used `withAnimation` to make it transition smoothly.
* We also have a `transition` modifier which is used with the shape, in this case the `Rectangle`.
* `.transition(.scale)` enlarges and shrinks the shape.
* `.transition(.asymmetric(insertion: .scale, removal: .opacity))` does the same thing but allows you to keep different transitions for insertion and removal.

---

## Building Custom Transitions Using `ViewModifier`

* The `.modifier` transition allows any view modifier we want. We just need to be able to instantiate the modifier, which means it needs to be one we create ourselves.
* We created a `struct` conforming to `ViewModifier`, with variables for degree and anchor.
* We passed the value to a function which returns some view, then added `rotationEffect` and `clipped()`.
* `.clipped()` basically doesn’t let the shape go out of bounds.
* We could have directly used it as a modifier, but it is a bit difficult to carry out. It is better to wrap it/extend `AnyTransition`, making it rotate according to the requirement.
* Added it to a tap gesture just to make it more appealing.

---

# Day 34 – Project 6, Part Three

## Animation: Wrap Up

* Using `withAnimation` can specify exactly which animation to use.
* We can use multiple `animation()` modifiers on a single view. Using several animation modifiers lets us animate a view’s state in different ways.
* `blur()` modifier applies a Gaussian blur to a view, using a radius we specify. This is all done on the GPU, so it’s really fast.
* In left-to-right, the trailing edge is on the right of the screen.
* `rotation3DEffect()` can rotate around more than one axis. For example:

```swift
rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 0))
```

* `offset()` modifier lets us delay animations. It also lets us move a view relative to its natural position.
* Sending `nil` to an animation disables the animation.
* Implicit animations can be looped using `repeatCount()` or `repeatForever()`.
* SwiftUI can animate background colors.
* SwiftUI comes with several basic transitions built in. You can use scale, opacity, and more.
* We can attach `onChanged()` and `onEnded()` modifiers to a `DragGesture`. This lets us update our view state every time the user’s finger moves or when they end the gesture.
* Using a value of `100` with the `scaleEffect()` modifier makes a view 100× its natural size.
* Ease-in animations start slow and end fast. Think of it as the animation gently easing into its movement.
* SwiftUI lets us animate changes that occur as a result of modifying a Boolean value. It evaluates your view state before the change and after, and animates the differences.
* `clipShape()` modifier lets us specify a shape for a view to be drawn inside.
* We can attach an `animation()` modifier to a binding. This causes changes in the binding to trigger an animation.
* We can animate views, and we can also animate overlays just like views.
* Asymmetric transitions let us specify one transition for insertion and another for removal.
* SwiftUI can animate several properties changing at the same time. It will animate them all simultaneously.
* Animation delays are specified in seconds. You can specify partial seconds such as `1.5` and similar values.
* You can mix and match however much you want.
* `rotation3DEffect()` lets us spin a view around its X, Y, and Z axes. It’s best to think of these axes as a skewer through your view.
* **Transitions and animations are not the same.** Although transitions make use of animations, they aren’t the same thing.
