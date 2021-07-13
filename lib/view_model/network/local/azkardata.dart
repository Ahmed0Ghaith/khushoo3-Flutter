import 'package:khushoo3/models/azkarModel.dart';

import 'package:flutter/services.dart';
import 'dart:convert';



class azkar
{

 
 
Future <List<Azkardata>> get()
async
{
 var jsonText = await  rootBundle.loadString('assets/localdb/azkar.json');
  dynamic userMap = jsonDecode(jsonText);
var azkar =  Azkar.fromJson(userMap).azkar;
 
 return azkar.toSet().toList();
}


}
