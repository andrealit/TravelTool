# TravelTool

This app is created for Udacity iOS Nanodegree Capstone Project.

## Objective
An navigation app for pedestrians, allowing pedestrians to post real-time updates.

## How to use the app
After the app is launched, a map view is shown. 
The user can long press the map to select a destination and get navigation directions.
The user can then switch to a live messaging service for updates on the area.

## Build and Install 
### Requirements
- Xcode 10.1
- iOS 12.1
- Swift 4.2

### Getting the Code
To download the code, you'll have to clone the repo. Then, to install Firebase frameworks, you'll need to use Cocoapods and execute a 'pod install' command for the PodFile to download all third-party frameworks.

`pod install`

### Running the app
After executing 'pod install', open the TravelTool.xcworkspace file that has been generated with XCode. You will need an application ID and application key to use the Mapbox API. Open ClientConstants.swift in XCode and add them:

## Resources
This app uses the following frameworks and APIs: 

### Third-Party Frameworks
| Framework | Description |
| --- | --- |
| Cocoapods | File dependency manager. |
| Firebase | Real time database for messaging. |

### APIS
| API | Description |
| --- | --- |
| Mapbox | Creates navigation paths and maps. |

## License
The contents of this repository are covered under the Apache License 2.0.
