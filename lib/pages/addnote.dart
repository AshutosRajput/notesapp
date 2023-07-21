import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddNote extends StatelessWidget {


TextEditingController title=TextEditingController();
TextEditingController des=TextEditingController();
CollectionReference ref=FirebaseFirestore.instance.collection('note');


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ElevatedButton(onPressed: (){
          ref.add({
            'title':title.text,
            'des':des.text
          }).whenComplete(() => Navigator.pop(context));
        }, child: Text('Save'))],
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 25),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title'
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: TextField(
                controller: des,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  
                  hintText: 'Description'
                ),
                maxLines: null,
                expands: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}