# AppIconCorrespondingToDarkMode
This is a sample project that considers whether iOS app icons can support dark mode.   
For YUMEMI.swift #5.  
[https://yumemi.connpass.com/event/153206/](https://yumemi.connpass.com/event/153206/)  

## Environment

* macOS Catalina 10.15.1
* Xcode 11.2.1
* iOS 13 and later

## Catch Appearance switch and distinction

As you know, this code.

```swift
// ViewController.swift
override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if self.traitCollection.userInterfaceStyle == .dark {
        // dark-mode
    } else {
        // light-mode
    }
}
```

## Change Icons by code (iOS 10.3 ~)

1. Add another icon to Project on Xcode
2. Edit info.plist
3. write below code in ViewController

```swift
UIApplication.shared.setAlternateIconName("hoge") { error in
    if let error = error {
        self.errorLabel.text = error.localizedDescription
    }
}
```


## Change App Icon for each Appearances.

Cannot change, maybe.  
Received error like as bellow.

> The operation was cancelled.

## About like Settings Screen

However, it worked when triggered by a cell tap on like Settings Screen.

### Light -> Dark

![RPReplay_Final1574677144](https://user-images.githubusercontent.com/8732417/69804719-881cd380-1222-11ea-9639-0737753b8a71.gif)

### Dark -> Light

![RPReplay_Final1574677169](https://user-images.githubusercontent.com/8732417/69804727-8c48f100-1222-11ea-9942-cf592546af3e.gif)
