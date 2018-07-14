# UIBezierPath+Spiral
Generates a UIBezierPath approximation of an arithmetic spiral. Swift version of https://github.com/ZevEisenberg/ZESpiral

[![](http://img.shields.io/badge/iOS-9.0%2B-lightgrey.svg)]()
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/mabdulsubhan/UIBezierPath-Spiral)

This is a swift conversion of [ZESpiral](https://github.com/ZevEisenberg/ZESpiral) which is used to generate arithmetic (“Archimedes”) spirals. It uses Bézier curve approximation to create a UIBezierPath of the form r = a + bθ.  

## Setup

Simply drag and drop the extension in your project.

Since the extension is implemented in Swift, if you are using **Objective-C**, you need to go to your target **Build Settings** and change `Define Module` to `Yes`. You can also choose a **Product Module Name**. Finally, import the module in your `.m` file:

```objc
#import "YourProductModuleName-Swift.h"
```

## Example

```swift
let center = self.center
let startRad: CGFloat = 0
let space: CGFloat = 5
let starttheta: CGFloat = 0
let endtheta: CGFloat = 30
let thetastep: CGFloat = 1
YourLayer.path = UIBezierPath.getSpiralPath(center: center, startRadius: startRad, spacePerLoop: space, startTheta: starttheta, endTheta: endtheta, thetaStep: thetastep).cgPath
```
![Sample](https://raw.githubusercontent.com/mabdulsubhan/UIBezierPath-Spiral/blob/master/sample.png)
