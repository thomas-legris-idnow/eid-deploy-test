# Changelog

## [2.0.0] - 2026-03
### SDK Update (breaking change)
- The public EIDError `aborted` changed to add a reason enum value `EIDAbortedReason`.
- The public EIDError `internalError` changed to add a reason enum value `EIDInternalErrorReason`.
- Public API `start` method changes:
  - **Standalone mode**: New async/await `start` method for standalone mode. The legacy one with callback is still usable but deprecated.
  - **Embedded mode**: New `start` method not related to standalone witch takes mobileToken and sessionToken. Internal IDnow use only ⚠️
  - Governikus support through a new dedicated target and a specific `start` method.

## [1.2.2] - 2026-01-30

### Added
- Added a new **security enhancement** to further strengthen user data protection and improve overall reliability of the eID process.

### Fixed
- Fixed an issue where **Terms & Conditions** were displayed even when the corresponding parameter was set to `false`.  
- Resolved a problem where the **PIN Size Selector** screen was not displayed as expected during the identification flow.

## [1.2.1] - 2026-01-12
### Fixed
- TLS Pinning.
- Update IDnowEIDDynamic iOS minimum version to iOS 14. (Static version still remains iOS 13).

## [1.2.0] - 2026-01-08
### Added
- Support for a dynamic `.xcframework` version of the SDK.

### Changed
- Dependencies like Lottie and OpenSSL are now managed as Swift Package Manager (SPM) packages.
- Updated the integration to use the dynamic Authada framework for improved compatibility and maintainability.

## [1.1.1] - 2025-12-15
### Fixed
- Resolved a TLS Pinning issue to enhance security during network requests.

## [1.1.0] - 2025-11-14
### Added
- Implemented a TLS pinning check for initial API calls.

### Changed
- Redesigned the "Terms and Conditions" screen for improved clarity and user experience.
- Made all user flows fully accessible with VoiceOver.
- Switched to using the static version of the Authada framework.

### Fixed
- Addressed several general issues with VoiceOver navigation and accessibility.

## [1.0.7] - 2025-10-13
### Changed
- Pinned the Lottie dependency to a specific version to ensure consistent animations.

### Fixed
- Addressed various accessibility issues related to VoiceOver.

## [1.0.6] - 2025-10-01
### Fixed
- This release includes several minor bug fixes and stability improvements.

## [1.0.5] - 2025-09-18
### Fixed
- General bug fixes and performance improvements.

## [1.0.4] - 2025-09-15
### Added
- Provided an external resource bundle required for the static library version of the SDK.

## [1.0.3] - 2025-09-04
### Fixed
- Addressed several minor issues to improve overall SDK stability.

## [1.0.2] - 2025-07-29
### Added
- A new Lottie animation for the NFC scanning screen.

## [1.0.1] - 2025-07-25
### Added
- A loading indicator is now displayed before the user flow begins.
- Full unit test coverage for core functionalities.

### Changed
- Updated the Theme API to allow for more flexible UI customization.
- Switched to using the unbundled Authada package.
- Refactored and cleaned up the codebase for better maintainability.

### Fixed
- Various minor bug fixes and improvements.

## [1.0.0] - 2025-06-03
### Added
- Initial release of the IDnow EID SDK, featuring a new user flow and a completely reworked design.