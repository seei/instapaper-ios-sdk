## InstapaperSDK for iOS

A Swift library allows you to integrate Instapaper into your iOS app.

### Installation

1. Open your existing project with Xcode6.
2. Drag the **InstapaperSDK** folder into your Xcode project.
3. Make sure the “Copy items into destination group's folder (if needed)” checkbox is checked.
4. Select your Xcode project in the Project Navigator, select your application target, select “Build Phases”, and add Security.framework to your “Link Binary With Libraries” phase.

### Usage

Before adding pages, you'll need to authenticate with an Instapaper username and password.


```
InstapaperSimpleAPI.sharedAPI.login(username, password: password, success: {
	response in
    //
}, failure: {
	error in
	//
})
```

If the user logged in successfully, your app can now make request to add URLs to Instapaper!


```
InstapaperSimpleAPI.sharedAPI.saveURL(url, success: {
	response in
    //
}, failure: {
	error in
    //
})
```

### Unit tests

1. Open the project with Xcode 6.
2. Enter your Instapaper email and password.
3. Press command + u.

### To Do

- Support the Full API

