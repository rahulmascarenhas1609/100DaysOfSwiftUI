# Day 35 – Milestone: Projects 4–6

- In SwiftUI, all our views and animations must be a function of our state. Basically, we need to attach a function to the state and then modify that state as appropriate.

## Key Points

### Ranges with `ForEach` and `List`

```swift
ForEach(0..<5) {
    Text("Row \($0)")
}
```

### What Makes a `String`?

- Strings can be tricky sometimes, but Swift is doing a huge amount of work behind the scenes to make them work correctly.

---

## Challenge – MathBuilder App

Made a MathBuilder app and need to figure out how to complete the challenge.

### Adding Difficulty

- Created an `Enum` conforming to `String` and `CaseIterable`.
  - The purpose of conforming to `String` is so that all the cases have a readable text value.
  - Conforming to `CaseIterable` allows us to loop through all the cases as a list and use the `allCases` property.
- Within the enum, we created a variable and conformed it to `ClosedRange`, so that the switch case can have closed ranges as cases.
- Created a `struct Question` with `Input` and `Answer` parameters. This is done so that the question array could conform to this structure and add the question and answer.

### UI Structure

- The UI consists of a `Form` having multiple sections. This is the `SettingsView`.
- `GamePlayView` consists of a `VStack` with multiple `Text` views, a `TextField`, and buttons.
- This view has a toolbar and an alert added at the bottom as modifiers to be displayed.

