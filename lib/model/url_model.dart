import 'dart:collection';

import 'package:flutter/material.dart';

class UrlModel extends ChangeNotifier {
  final List<String> _urls = [
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
  ];

  // SECURITY THAT DO NOT ALLOW TO ADD ITEM TO LIST WITHOUT USING METHOD
  UnmodifiableListView<String> get urls {
    return UnmodifiableListView(_urls);
  }

  int get urlCount {
    return urls.length;
  }

  // IT REQUIRES NOTIFYLISTENERS !!!
  void addUrl(String newUrl) {
    if (!_urls.contains(newUrl)) {
      _urls.add(newUrl);
      notifyListeners();
    }
  }

  void deleteUrl(String newUrl) {
    _urls.removeWhere((element) => element == newUrl);
    notifyListeners();
  }
}
