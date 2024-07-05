import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<List<String>>(create: (_) => List.generate(100, (index) => 'Item $index')),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CTCScreen(),
    );
  }
}
class CTCScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dummyList = Provider.of<List<String>>(context);
    final ScrollController _scrollController = ScrollController();
    final List<GlobalKey> _keys = List.generate(100, (index) => GlobalKey());

    double _randomHeight() {
      return Random().nextInt(100).toDouble() + 60;
    }

    void _scrollToRow() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_keys[20].currentContext != null) {
          Scrollable.ensureVisible(
            _keys[20].currentContext!,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollToRow();
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToRow();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Scroll Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: dummyList.length,
        itemBuilder: (context, index) {
          double itemHeight = _randomHeight();

          return Container(
            key: _keys[index],
            height: itemHeight,
            margin: EdgeInsets.symmetric(vertical: 4.0),
            color: index % 2 == 0 ? Colors.blue[50] : Colors.blue[100],
            child: ListTile(
              title: Text(dummyList[index]),
              subtitle: Text('Subtitle $index'),
              trailing: Icon(Icons.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}
