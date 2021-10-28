import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reachability_web/website_reachable_future_builder.dart';

import 'model/url_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UrlModel(),
      child: MaterialApp(
        title: 'Can I reach these website ?',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Can I reach this website ?', websites: [
          'https://www.google.com',
          'https://www.apple.com',
          'https://www.cloudflare.com',
          'https://www.nordvpn.com',
          'https://nutritionkitchenhk.com',
          'https://www.stackoverflow.com',
          'https://www.youtube.com',
          'https://www.amazon.com',
          'https://www.yahoo.com',
          'https://www.lihkg.com',
          'https://www.taobao.com',
          'https://www.instagram.com',
          'https://jsonplaceholder.typicode.com/albums/1'
        ]),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title, required this.websites})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final List<String> websites;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Consumer<UrlModel>(
        builder: (context, urlModel, child) {
      return Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: ListView.builder(

            shrinkWrap: true,
            itemCount: urlModel.urlCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    key: Key(urlModel.urls[index].toString()),
                    children: [
                      Expanded(
                          child: WebsiteReachableWidget(
                        url: urlModel.urls[index],
                      )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            urlModel.urls[index],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                        flex: 2,
                      ),
                      TextButton(onPressed: (){
                        urlModel.deleteUrl(urlModel.urls[index]);
                      }, child: const Text('Delete',style: TextStyle(color: Colors.red)))
                    ],
                  ),
                ),
              );
            },
          ),
        );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
