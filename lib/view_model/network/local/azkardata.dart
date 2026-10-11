import 'package:khushoo3/models/azkarModel.dart';

import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:khushoo3/gen/assets.gen.dart';

class azkar {
  Future<List<Azkardata>> get() async {
    var jsonText = await rootBundle.loadString(Assets.localdb.azkar);
    dynamic userMap = jsonDecode(jsonText);
    var azkar = Azkar.fromJson(userMap).azkar;

    return azkar.toSet().toList();
  }
}
