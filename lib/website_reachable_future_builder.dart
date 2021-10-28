import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WebsiteReachableWidget extends StatefulWidget {
  const WebsiteReachableWidget({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<WebsiteReachableWidget> createState() => _WebsiteReachableWidgetState();
}

Future<Response> getWebSite(String urlString) {
// Imagine that this function is fetching user info but encounters a bug
  var _url = Uri.parse(urlString);

  return http.get(_url).timeout(
    const Duration(seconds: 5),
    onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response('Error', 500); // Replace 500 with your http code.
    },
  );
  ;
}

class _WebsiteReachableWidgetState extends State<WebsiteReachableWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: getWebSite(widget.url),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            (snapshot.data?.statusCode == 200)
                ? const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 40,
                  )
                : const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 40,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('States Code : ${snapshot.data?.statusCode}'),
            )
          ];
        } else if (snapshot.hasError) {
          if (snapshot.error.runtimeType == ClientException
              && (snapshot.error as ClientException).message == 'XMLHttpRequest error.'
          ) {
            children = <Widget>[
              const Tooltip(
                message:
                    'Website is probably reachable, but due to CORS policy, XMLHttpRequest error is returned',
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Tooltip(
                    message:
                        'Website is probably reachable, but due to CORS policy, XMLHttpRequest error is returned',
                    child: Text(
                        'Error: ${((snapshot.error as ClientException).message)}')),
              )
            ];
          } else {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${(snapshot.error.runtimeType)}'),
              )
            ];
          }
        } else {
          children = const <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 40,
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Loading...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
