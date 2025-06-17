# get_home_application_support_directory

A Flutter plugin that provides access to the macOS Application Support directory path. This plugin allows Flutter applications to easily retrieve the standard location for storing user data and configuration files on macOS.

## Features

- ✅ Get the Application Support directory path on macOS
- ✅ Cross-platform ready (currently supports macOS, can be extended to other platforms)
- ✅ Simple and easy-to-use API
- ✅ Null safety support
- ✅ Comprehensive error handling

## Platform Support

| Platform | Supported |
|----------|-----------|
| macOS    | ✅        |
| iOS      | ❌        |
| Android  | ❌        |
| Windows  | ❌        |
| Linux    | ❌        |
| Web      | ❌        |

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  get_home_application_support_directory: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:get_home_application_support_directory/get_home_application_support_directory.dart';

// Create an instance of the plugin
final plugin = GetHomeApplicationSupportDirectory();

// Get the Application Support directory path
try {
  final path = await plugin.getApplicationSupportDirectory();
  if (path != null) {
    print('Application Support directory: $path');
    // Typically prints: /Users/username/Library/Application Support
  } else {
    print('Could not retrieve the directory path');
  }
} catch (e) {
  print('Error getting Application Support directory: $e');
}
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _directoryPath = 'Unknown';
  final _plugin = GetHomeApplicationSupportDirectory();

  @override
  void initState() {
    super.initState();
    _getApplicationSupportDirectory();
  }

  Future<void> _getApplicationSupportDirectory() async {
    try {
      final path = await _plugin.getApplicationSupportDirectory();
      setState(() {
        _directoryPath = path ?? 'Directory not found';
      });
    } catch (e) {
      setState(() {
        _directoryPath = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Application Support Directory')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Directory Path:'),
              SizedBox(height: 10),
              SelectableText(
                _directoryPath,
                style: TextStyle(fontFamily: 'monospace'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getApplicationSupportDirectory,
                child: Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## API Reference

### GetHomeApplicationSupportDirectory

The main class for accessing the Application Support directory.

#### Methods

##### `getApplicationSupportDirectory()`

Returns the path to the Application Support directory.

**Returns:** `Future<String?>`

- Returns the full path to the Application Support directory on success
- Returns `null` if the directory cannot be found
- Throws `PlatformException` on error

**Example:**
```dart
final plugin = GetHomeApplicationSupportDirectory();
final path = await plugin.getApplicationSupportDirectory();
```

##### `getPlatformVersion()`

Returns the platform version string (useful for debugging).

**Returns:** `Future<String?>`

- Returns the platform version string
- Returns `null` on error

## Error Handling

The plugin includes comprehensive error handling:

```dart
try {
  final path = await plugin.getApplicationSupportDirectory();
  // Use the path
} on PlatformException catch (e) {
  print('Platform error: ${e.message}');
} catch (e) {
  print('General error: $e');
}
```

## What is the Application Support Directory?

On macOS, the Application Support directory is the standard location for storing:

- User-specific application data
- Configuration files
- Cached data
- User preferences
- Application-specific documents

The typical path is: `/Users/[username]/Library/Application Support`

## Use Cases

This plugin is perfect for applications that need to:

- Store user configuration files
- Cache data locally
- Save user preferences
- Store application-specific documents
- Maintain user data between app sessions

## Example App

The plugin includes a complete example app that demonstrates how to use the plugin. You can find it in the `example/` directory.

To run the example:

```bash
cd example
flutter run -d macos
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Issues

If you encounter any issues or have feature requests, please file them in the [issue tracker](https://github.com/yourusername/get_home_application_support_directory/issues).

## Changelog

### 1.0.0
- Initial release
- Added support for getting Application Support directory on macOS
- Comprehensive error handling
- Example app included

