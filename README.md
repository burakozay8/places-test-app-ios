# Places + Wikipedia Deep Link Assignment

This repository contains two parts:

1) **Wikipedia iOS app changes** (fork)
2) **Places test app** (SwiftUI)

The goal is:
- Open Wikipedia directly on the **Places** tab
- Show a location based on **coordinates** sent by another app
- Provide a simple SwiftUI app that lists locations, allows adding a custom one, and opens Wikipedia via deep link

---

## 1) Wikipedia app changes

### What was added
- The Wikipedia app can now read `lat` and `lon` values (from the deep link / userInfo).
- When opened with coordinates, the app switches to the **Places** tab and shows the given location instead of the current location.

### Deep link format
wikipedia://places?lat=&lon=
Example:
wikipedia://places?lat=52.3547498&lon=4.8339215

---

## 2) Places app (SwiftUI)

### Features
- Fetches locations from the provided JSON endpoint
- Shows the list as rows
- Each row has an action to open Wikipedia on that location
- User can add a custom location (name optional, latitude/longitude required)
- Added locations are also stored locally so they don’t disappear after app restart
- Basic accessibility improvements (VoiceOver labels/hints)
- Unit tests for `LocationsVM` using stub JSON and mock services

### How it works
- App loads remote locations on launch
- If there are stored locations, they are appended to the list
- When user saves a custom location, it is appended to the UI list and stored locally

---

## Running the project

### Requirements
- Xcode (latest stable)
- iOS simulator or a physical device

### Run Places app
1. Open `Places.xcodeproj` (or workspace if you have one)
2. Select a simulator/device
3. Run

### Run Wikipedia app (fork)
1. Open the Wikipedia project
2. Make sure it builds and runs on a simulator/device

---

## Testing the deep link

### From Places app
- Tap **Explore on Wikipedia** on any row.
- Wikipedia should open and show the Places tab for that coordinate.

### Manually (Simulator)
You can also test via Terminal:
xcrun simctl openurl booted “wikipedia://places?lat=52.3547498&lon=4.8339215”

---

## Unit tests
- Unit tests are located under `PlacesTests`
- They use stub JSON files and mock services/stores to keep tests deterministic

Run with:
- Xcode Test navigator → Run all tests

---

## Notes
- If `UIApplication.canOpenURL` returns `false` in Places, make sure the Wikipedia app is installed on the same simulator/device.
- If you test on a real device, you may need to add the scheme to `LSApplicationQueriesSchemes` depending on your approach.