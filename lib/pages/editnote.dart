

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditNote extends StatefulWidget {
  DocumentSnapshot edit;

  EditNote({required this.edit});
  
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title=TextEditingController();
TextEditingController des=TextEditingController();


@override
void initState(){
  title=TextEditingController(text: (widget.edit.data() as Map<String, dynamic>)['title']);
  des=TextEditingController(text: (widget.edit.data() as Map<String, dynamic>)['des']);



  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ElevatedButton(onPressed: (){
          widget.edit.reference.update({
            'title':title.text,
            'des':des.text
          }).whenComplete(() => Navigator.pop(context));
        }, child: Text('Save')
        ),
        ElevatedButton(onPressed: (){
          widget.edit.reference.delete()
          .whenComplete(() => Navigator.pop(context));
        }, child: Text('delete')
        ),
        
        ],
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