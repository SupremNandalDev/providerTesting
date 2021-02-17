import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demo'
        ),
      ),
      body: ChangeNotifierProvider<MyProvider>(
        create: (context) => MyProvider(),
        child: Consumer<MyProvider>(
          builder: (context, provider, child){
            if(provider.image!=null){
              return Container(
                height: 100,
                width: 100,
                child: Image.file(provider.image),
              );
            }


            return InkWell(
              onTap: () async{
                var imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
                File file = File(imageFile.path);
                provider.setImage(file);
              },
              child: Container(
                padding: EdgeInsets.all(128),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyProvider extends ChangeNotifier{
  var image;

  Future setImage(File file) async{
    this.image = file;
    this.notifyListeners();
  }

}