import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_home_application_support_directory/get_home_application_support_directory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _applicationSupportPath = 'Unknown';
  String _subdirectoryPath = 'Not created';
  bool _isSupported = false;
  final _getHomeApplicationSupportDirectoryPlugin =
      GetHomeApplicationSupportDirectory();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    String applicationSupportPath;
    bool isSupported;

    // Check platform support
    isSupported = GetHomeApplicationSupportDirectory.isSupported;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _getHomeApplicationSupportDirectoryPlugin
              .getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      applicationSupportPath =
          await _getHomeApplicationSupportDirectoryPlugin
              .getApplicationSupportDirectory() ??
          'Directory not found';
    } on PlatformException catch (e) {
      applicationSupportPath =
          'Failed to get Application Support directory: ${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _applicationSupportPath = applicationSupportPath;
      _isSupported = isSupported;
    });
  }

  Future<void> _createSubdirectory() async {
    try {
      final subdirectoryPath = await _getHomeApplicationSupportDirectoryPlugin
          .createSubdirectory('FlutterTestApp');
      setState(() {
        _subdirectoryPath = subdirectoryPath ?? 'Failed to create subdirectory';
      });
    } on PlatformException catch (e) {
      setState(() {
        _subdirectoryPath = 'Error creating subdirectory: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _subdirectoryPath = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Get Application Support Directory'),
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Platform Support Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Platform Support:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              _isSupported ? Icons.check_circle : Icons.cancel,
                              color: _isSupported ? Colors.green : Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isSupported
                                  ? 'Supported on this platform'
                                  : 'Not supported on this platform',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isSupported ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Platform Version Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Platform Version:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _platformVersion,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Application Support Directory Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Application Support Directory:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          _applicationSupportPath,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Subdirectory Creation Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Created Subdirectory:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          _subdirectoryPath,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _isSupported ? _createSubdirectory : null,
                          icon: const Icon(Icons.create_new_folder),
                          label: const Text('Create Test Subdirectory'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Refresh Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: initPlatformState,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Refresh All'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
