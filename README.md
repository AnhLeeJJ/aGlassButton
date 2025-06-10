# aGlassButton - Glass look and button view modifiers for SwiftUI
![alt text](https://github.com/AnhLeeJJ/aGlassButton/blob/main/show.gif?raw=true)

A simple yet strong swiftui ios glass and glass button view modifiers. Just drop GlassButton.swift to your project.

and use the modifiers as simple as:
```swift
Text("A piece of glass")
  .padding(16)
  .glass()
Text("Button")
  .padding(8)
  .glassButton {
    print("Button down")
  }
```
Support callbacks for button touch down, continuously down, and touch up.

There is an experimental 2 sides button too.

# Main view modifiers:

```swift
func glass(_ corner: CGFloat = 32)
```

```swift
func glassButton(
  downAction: VoidAction? = nil,
  downContAction: VoidAction? = nil,
  upAction: VoidAction? = nil
)
```

```swift
func glassTwoSideButton(
  downAction1: VoidAction? = nil,
  downContAction1: VoidAction? = nil,
  upAction1: VoidAction? = nil,
  downAction2: VoidAction? = nil,
  downContAction2: VoidAction? = nil,
  upAction2: VoidAction? = nil
)
```

A quick and simple helper for time when the iOS 26 liquid glass is still a myth, and maybe a pain to the CPU.

![alt text](https://github.com/AnhLeeJJ/aGlassButton/blob/main/screenshot.png?raw=true)
