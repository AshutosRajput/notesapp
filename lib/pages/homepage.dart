import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/pages/addnote.dart';
import 'package:notesapp/pages/editnote.dart';

class Homepage extends StatelessWidget {
  final ref=FirebaseFirestore.instance.collection('note');
    final date=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote()));
      },child: Icon(Icons.add),),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        centerTitle: true,
        title: Text('NOTES'),
      ),
      backgroundColor: Colors.white70,
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return GridView.builder(
            itemCount: snapshot.hasData? snapshot.data!.docs.length:0,
            gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
             itemBuilder: (context,index){
      
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(edit: snapshot.data!.docs[index])));
              },
              child: Container(
                
                
                
                margin: EdgeInsets.all(20),
                height: double.maxFinite,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 50, 0),
                  child: Column(
                    
                    children: [
                      Text(snapshot.data!.docs[index]['title'],
                      style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 30),
                      Text(snapshot.data!.docs[index]['des']),
                      SizedBox(height: 30),

                    Text(getFormattedDate())
                      
                      
                
                    ],
                  ),
                ),
              ),
            );
          });
        }
      ),
    );
  }
}
String getFormattedDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat(' MMMM d,EEEE').format(now);
  return formattedDate;
}



