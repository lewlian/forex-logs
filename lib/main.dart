import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title; 

  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
    File sampleImage;

  Future _getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: sampleImage == null? Text('Select an image'): enableUpload(),
       ),
       floatingActionButton: new FloatingActionButton(
         onPressed: _getImage,
         tooltip: 'Add Image',
          child: new Icon (Icons.add),
        ),
    );
  }
  Widget enableUpload() {
    return Container(
      child:Column(children: <Widget>[
        Image.file(sampleImage,height:300.0, width: 300.0),
      RaisedButton(
        elevation: 7.0,
        child: Text ('Upload'),
        textColor:Colors.white,
        color:Colors.blue,
      onPressed: () {
        final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("myimage.jpg");
        final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
      },)
      ],)
    );
  }
}
