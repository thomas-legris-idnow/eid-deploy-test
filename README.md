# eID - IDnow

[![Platform](https://img.shields.io/badge/Platform-iOS-brightgreen.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9-blue.svg)](https://developer.apple.com/swift/)
[![iOS](https://img.shields.io/badge/iOS-13.0-red.svg)](https://developer.apple.com/swift/)

## Table of Contents

- [eID - IDnow](#eid---idnow)
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Key Features](#key-features)
  - [Requirements](#requirements)
  - [Installation](#installation)
    - [Add IDnowEID library](#add-idnoweid-library)
	  - [IDnowEID library (static)](#static-idnoweid-library)
	  - [IDnowEID library (dynamic)](#dynamic-idnoweid-library)
    - [Configure NFC](#configure-nfc)
      - [Target settings - Signing \& Capabilities](#target-settings---signing--capabilities)
      - [Entitlements file](#entitlements-file)
      - [Info.plist file](#infoplist-file)
  - [Integration](#integration)
    - [Starting the SDK](#starting-the-sdk)
    - [Handle result](#handle-result)
    - [Error Description:](#error-description)
  - [Customization](#customization)
  - [Additional features](#additional-features)
    - [Dark mode](#dark-mode)
    - [Localization](#localization)

## About

The German government introduced RFID chip-based electronic ID cards in November 2010. 
The eID iOS SDK is a library designed to authenticate with these German ID cards. The flow requires the personal PIN code and uses the NFC smartphone chip.

## Key Features

* **6-digit PIN flow**: Securely authenticate using your existing 6-digit PIN code.
* **5-digit PIN flow**: Create your own 6-digit PIN code through our 5-step guided process, then use it for authentication.
* **CAN PIN**: Card Access Number (CAN) support in case of error.

## Requirements

* **Xcode:** version 16.3 or higher.
* **Deployment target:** Depends of the target: iOS 13.0 for IDnowEID, iOS 14.0 for IDnowEIDDynamic and IDnowEIDGovernikus
* **Swift:** 5.9
* **Authada library:** One of the 2 providers used to scan the chip (provided separately as an xcframework)
* **Governikus library:**  One of the 2 providers used to scan the chip (automaticaly fetched via SPM)
* **OpenSSL:** used by the AuthadaAuthenticationLibrary. Current version: 3.1.5
* **NFC:** NFC-enabled smartphone. (iPhone7 or newer models)

## Installation

You have the choice to install 3 possible targets:
- IDnowEID: static version with Authada external provider
- IDnowEIDDynamic: dynamic version of eID with Authada external provider
- IDnowEIDGovernikus: dynamic version of eID with Governikus (AusweisApp) external provider

Follow the next steps to integrate one of them into your application:

### Import the project
IDnowEID (static, dynamic or governikus) sdk are only available through a single URL via Swift Package Manager (SPM):

* [https://github.com/idnow/eid-sdk-ios](https://github.com/idnow/eid-sdk-ios)

After importing it, select a target according to your need, you should only import one ⚠️

### Add a specific eID library
#### Static IDnowEID library

Add `IDnowEID` to your target.

3 libraries will be provided separately + 1 resource bundle. You will need to add `AuthadaAuthenticationLibraryUnbundledStatic.xcframework`, `Lottie.xcframework`, `OpenSSL.xcframework` and `AALUSResources.bundle` to your Xcode project.
Here is the step to add them:

- Add `AuthadaAuthenticationLibraryUnbundledStatic.xcframework`, `Lottie.xcframework` and `OpenSSL.xcframework` to `Frameworks, Libraries, and Embedded Content` section of your application target.
- Verify that `Link Binary With Libraries` in your target’s Build Phases include `AuthadaAuthenticationLibraryUnbundledStatic.xcframework`, `Lottie.xcframework` and `OpenSSL.xcframework`.
- Verify that `Embed Frameworks` in your target’s Build Phases include `Lottie.xcframework` and `OpenSSL.xcframework`.
- Verify that `Embed Frameworks` in your target's Build Phases **do not** include `AuthadaAuthenticationLibraryUnbundledStatic.xcframework`.
- Verify that `Copy resources` in your target’s Build Phases include `AALUSResources.bundle`.

#### IDnowEIDDynamic library

Add `IDnowEIDDynamic` to your target.

1 library will be provided separately. You will need to add `AuthadaAuthenticationLibraryUnbundled.xcframework` to your Xcode project.
Here is the step to add it:

- Add `AuthadaAuthenticationLibraryUnbundled.xcframework` to `Frameworks, Libraries, and Embedded Content` section of your application target.
- Verify that `Link Binary With Libraries` in your target’s Build Phases include `AuthadaAuthenticationLibraryUnbundled.xcframework`.
- Verify that `Embed Frameworks` in your target’s Build Phases include `AuthadaAuthenticationLibraryUnbundled.xcframework`.

#### IDnowEIDGovernikus library

Add `IDnowEIDGovernikus` to your target.

All libraries are imported automatically. It will be the case of the Governikus sdk.

### Configure NFC
#### Target settings - Signing & Capabilities
Add Near Field Communication Tag Reading as a capability

#### Entitlements file

1. Create an entitlements file if you do not have one.
2. Add an array with the key `Near Field Communication Tag Reader Session Formats`
3. In this array, add an item:
    - key: `Item 0 (Near Field Communication Tag Reading Session Format)`
    - value: `Tag-Specific Data Protocol (TAG)`

#### Info.plist file

1. Add an array with the key `com.apple.developer.nfc.readersession.iso7816.select-identifiers` / `ISO7816 application identifiers for NFC Tag Reader Session`.
2. Add the following entries to this array:
    - `E80704007F00070302`
    - `A0000002471001`
3. Add an entry for `Privacy - NFC Scan Usage Description` that describes usage of the NFC functionality to the users

👏 You have now access to the eID SDK, so let's see how to work with it.

## Integration
eID started with a `Standalone` mode, containing some intro screen handling user consent or api calls directly inside the sdk.

Howether, another mode has been added named `embedded`.This mode is used for internal integration into other IDnow product. API calls to get customer configuration are done in another sdk. 

As we will see, implementation is not totally the same, see bellow how to start the sdk and handle the result according to the selected mode.

### Standalone
For Standalone mode, there is no difference that you use Governikus or Authada, it is automatically managed internaly.
Please only provide following parameters in the start method.

#### Start the SDK
You can start the sdk using 2 methods :
- ⚠️ Deprecated method with callback and host view controller:

```swift
func start(presentationViewController: UIViewController,
           token: String,
           config: EIDConfig,
           callback: EIDCallback)
```
- 💡 Since 1.3.0, prefer using the new async/await method which simplify integration

```swift
func start(identToken: String,
           config: EIDConfig) async throws(EIDError)
```
Here is an example of how to call it:
```swift
let defaultConfig = try EIDConfig.Builder().build()
do {
    try await EIDSdk.shared.start(identToken: identToken
                                  config: defaultConfig)
    // Handle success.
} catch {
    // Handle error.
}
```

This code call the main start method to launch the eID library in a standalone mode. It takes several parameters:

| Parameters | Type          | Description |
| ---------- | ------------- | ----------- |
| identToken | `String`      | The provided Ident token. |
| config     | `EIDConfig`   | Object used to configure the SDK (see [Customization](#customization) section). |

#### Handle result
With the legacy deprecated implementation, callback argument was needed in start method then your object must inherit from EIDCallback.

📣 Since 1.3.0, prefer using the new async/await method which simplify integration. It return void for success and an `EIDError` in case of failure (see [Error Description](#error-description) section).

### Embedded Mode
The embedded mode is another endpoint to start eID using a `token`, a `mobileToken`, a `sessionToken` and a specific embedded config. It is only here for internal integration into IDnow product. 
⚠️ As external client, you don't need to worry about these 2 functions: 

```swift
func start(
  identToken: String,
  mobileToken: String,
  sessionToken: String,
  embeddedConfig: EIDEmbeddedConfig)
```
and 

```swift
func start(
  identToken: String,
  tcTokenUrl: String,
  embeddedConfig: EIDEmbeddedConfig)
```

### Error Description:
When the SDK stops with an error, you have access to several type of errors from the sdk callback. You can easily work with these errors to display any content in your application. Here is the list of available `EIDError` with their description.
```swift
public enum EIDError {
    /// Session has been cancelled by user.
    ///
    /// - Parameters:
    ///   - reason: reason of the user cancellation
    ///   - message: optionnal short text to describe the reason
    case aborted(reason: EIDAbortedReason, message: String? = nil)
     /// A network error occurred.
    ///
    /// - Parameters:
    ///   - reason: optionnal reason for specific cases, nil by default for client or server errors.
    case networkError(reason: NetworErrorReason?)
    /// NFC is not available on the device.
    case nfcNotAvailable
    /// Ident-ID is invalid.
    case invalidToken
    /// Ident-ID has already been completed and cannot be started again
    case tokenAlreadyCompleted
    /// Internal Error occurred during the session.
    /// - Parameters reason: optionnal reason to describe the error occurred.
    case internalError(reason: EIDInternalErrorReason? = nil)
    /// The eID card is already blocked or user blocked it during the session.
    case cardBlocked
    /// The eID card is deactivated, authority needs to be contacted.
    case cardDeactivated
    /// The eID card has been lost and can not be found. A new session can be start again.
    /// Notes: Happens on the Governikus provider only. Authada allow card lost retry directly.
    case cardLost
    /// The scanned card is not compatible, faulty or expired. User should change or update its document
    case invalidCard
    /// Timeout occurred during the scan session.
    case sessionTimeout
}
```

🎉 eID can now be launched from your host app, now let's see how to customize it.

## Customization

- The parameter `config` contains all the properties to customize your eID experience.
  - Use `showTermsAndConditions(true/false)` to display or not the terms and conditions screen.
  - Use `setTheme` to customize all screen designs: colors, fonts, radius, spacing.
  - Use `setCustomFont` to customize all fonts.

Note: Customization is only available for the standalone mode. In embedded mode, The Sunflower theme setup should be done on host app/sdk.
Here is a example of theme and font customization to apply on eID:

```swift
private var exampleTheme: EIDTheme {
        let brandColors = EIDBrandColorsApi(primary: "#2C64E3",
                                            primaryVariant: "#e8f0fc",
                                            secondary: "#2C64E3",
                                            secondaryVariant: "#2C64E3",
                                            error: "#d94a4a",
                                            processing: "#f9bf25",
                                            success: "#26d357",
                                            active: "#2c64e3")

        let greyColors = EIDGreyColorsApi(grey100: "#ffffff",
                                          grey200: "#eeeeee",
                                          grey300: "#dedede",
                                          grey400: "#b6b6b6",
                                          grey500: "#888888",
                                          grey600: "#595959",
                                          grey800: "#333333",
                                          grey900: "#000000")

        let customColors = EIDColorsApi(brand: brandColors, grey: greyColors)

        let customRadius = EIDRadiusApi(radius1: 8,
                                        radius2: 16,
                                        radius3: 24,
                                        radius4: 400)

        let customSpacing = EIDSpacingApi(spacing05: 8,
                                          spacing1: 16,
                                          spacing2: 24,
                                          spacing3: 32,
                                          spacing4: 40,
                                          spacing5: 48,
                                          spacing6: 56)

        let fontSize = EIDFontSizeApi(size0: 1.1)
        let fontApi = EIDFontApi(fontSize: fontSize)

        return EIDTheme(color: customColors, radius: customRadius, spacing: customSpacing, font: fontApi)
}

private var exampleFont: EIDCustomFont {
        return EIDCustomFont(heading: UIFont.systemFont(ofSize: 24, weight: .bold),
                             regularContent: UIFont.systemFont(ofSize: 17),
                             mediumContent: UIFont.systemFont(ofSize: 17, weight: .medium))
}
```


Then, you can apply this theme to the eID SDK: 
```swift
let config = EIDConfig.Builder()
			.setTheme(exampleTheme)
			.setCustomFont(exampleFont)
			.build()
```

🎨 You are now fully ready to install, implement, integrate and customize our SDK.

## Additional features 
### Dark mode

Each screen of the IDnowEID SDK natively supports the dark mode according to your app’s setting. It automatically adjusts for the custom appearance using the default theme or the colors you applied using the theme property. 

If you want to set dark mode colors, please use the `variant` colors. Example: for the primary dark mode color, set `primaryVariant` color.

### Localization

The SDK supports 18 languages. Find bellow the list: 

English, German, French, Spanish, Italian, Portuguese, Estonian, Croatian, Hungarian, Georgian, Korean, Lithuanian, Latvian, Dutch, Polish, Ukrainian, Chinese, Russian
