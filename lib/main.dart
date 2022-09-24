import 'package:flutter/material.dart';
import 'package:test_call_app/index.dart';
import 'package:test_call_app/log_sink.dart';
import 'package:test_call_app/agora.config.dart' as config;

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _data = [...basic];
  bool _isConfigInvalid() {
    return config.appId == '<YOUR_APP_ID>' ||
        config.token == '<YOUR_TOKEN>' ||
        config.channelId == '<YOUR_CHANNEL_ID>';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text('APIExample'),
          ),
          body: _isConfigInvalid()
              ? const InvalidConfigWidget()
              : ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return _data[index]['widget'] == null
                        ? Ink(
                            color: Colors.grey,
                            child: ListTile(
                              title: Text(_data[index]['name'] as String,
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white)),
                            ),
                          )
                        : ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                            appBar: AppBar(
                                              title: Text(_data[index]['name']
                                                  as String),
                                              // ignore: prefer_const_literals_to_create_immutables
                                              actions: [
                                                const LogActionWidget()
                                              ],
                                            ),
                                            body: _data[index]['widget']
                                                as Widget?,
                                          )));
                            },
                            title: Text(
                              _data[index]['name'] as String,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.black),
                            ),
                          );
                  },
                ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}

class InvalidConfigWidget extends StatelessWidget {
  /// Construct the [InvalidConfigWidget]
  const InvalidConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text(
          'Make sure you set the correct appId, token, channelId, etc.. in the lib/config/agora.config.dart file.'),
    );
  }
}
