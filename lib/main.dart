import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proxy_provider_demo/color_provider.dart';
import 'package:proxy_provider_demo/string_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ColorProvider()),
    ProxyProvider<ColorProvider, StringProvider>(
        update: (context, colorProvider, _) {
      var stringProvider = StringProvider();
      print('update');
      stringProvider.update(colorProvider.currentColor, colorProvider.count);
      return stringProvider;
    })
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyHomePage build');
    return Scaffold(
      appBar: AppBar(
        title: Text('demo'),
      ),
      body: Center(
        child: _StringItems(),
      ),
      floatingActionButton: RaisedButton(
          onPressed: () {
            context.read<ColorProvider>().toNextColor();
          },
          child: Text('change color')),
    );
  }
}

class _StringItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('_StringItems build');
    int count = context.select<StringProvider, int>((p) => p.count);

    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, i) {
          return _StringItem(i, key: Key('$i'));
        });
  }
}

class _StringItem extends StatelessWidget {
  final int index;

  _StringItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('_StringItem build $index');
    String value = context
        .select<StringProvider, String>((p) => p.getPositionValue(index));
    return Text(value);
  }
}
