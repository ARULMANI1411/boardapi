import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model class/boardclass.dart';
class apiboard extends StatefulWidget {
  const apiboard({super.key});

  @override
  State<apiboard> createState() => _apiboardState();
}

class _apiboardState extends State<apiboard> {
Future<bord> boredetails() async {
  var resp = await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
 print(resp.body);
 print(resp.statusCode);

  return bord.fromJson(jsonDecode(resp.body));
  

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SelectableText("api board example"),),

      body: Center(
        child: FutureBuilder<bord>(future:boredetails() ,
          builder: (BuildContext context,  snapshot) {
          if(snapshot.hasData){
            return Column(
              children: [
                Text(snapshot.data!.activity.toString()),
                Text(snapshot.data!.type.toString()),
                Text(snapshot.data!.participants.toString()),
                Text(snapshot.data!.price.toString()),
                Text(snapshot.data!.link.toString()),
                Text(snapshot.data!.key.toString()),
                Text(snapshot.data!.accessibility.toString()),
              ],
            );
          }else if (snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();

        },),
      ),

    );
  }
}
