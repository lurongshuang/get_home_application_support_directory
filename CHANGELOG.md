# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-12-19

### Added
- Initial release of the get_home_application_support_directory plugin
- Support for getting the Application Support directory path on macOS
- Method `getApplicationSupportDirectory()` to retrieve the directory path
- Comprehensive error handling with proper exception types
- Complete example application demonstrating plugin usage
- Detailed documentation and API reference
- Unit tests for core functionality

### Features
- Native macOS implementation using `NSSearchPathForDirectoriesInDomains`
- Flutter method channel communication
- Null safety support
- Cross-platform plugin architecture (ready for future platform additions)

### Technical Details
- Swift implementation for macOS platform
- Method channel communication between Dart and native code
- Plugin platform interface for extensibility
- Proper error handling and exception propagation
