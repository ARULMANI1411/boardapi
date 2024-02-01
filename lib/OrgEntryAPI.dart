import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model class/OrgEntryClass.dart';
class OrgEntryAPI extends StatefulWidget {
  const OrgEntryAPI({super.key});

  @override
  State<OrgEntryAPI> createState() => _OrgEntryAPIState();
}

class _OrgEntryAPIState extends State<OrgEntryAPI> {
  Future<OrEntry>? _future;
  Future<List<Entries>>  fetchEntryDetails() async{
    var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    //print(resp.body);
    var data = jsonDecode(resp.body)["entries"];
    //print(data);

    return (data as List).map((obj)=> Entries.fromJson(obj)).toList();
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // fetchEntryDetails();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SelectableText("api board example"),),

      body: Center(
        child: FutureBuilder<List<Entries>>(future:fetchEntryDetails() ,
          builder: (BuildContext context,  snapshot) {
            if(snapshot.hasData){
              List<Entries> entryList = snapshot.data!;
              return Column(
                children: [
                  Container(
                    height: 700,

                    child: ListView.builder(
                    itemCount: entryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: const Icon(Icons.list),
                          trailing: const Text(
                            "GFG",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text(entryList[index].aPI.toString()));
                    }),
                  ),


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
