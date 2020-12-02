import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  
  File _storeImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    PickedFile image = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 600
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey)
        ),
        child: _storeImage != null 
            ? Image.file(
                _storeImage, 
                fit: BoxFit.cover, 
                width: double.infinity,
              )
            : Text('No image Taken', textAlign: TextAlign.center),
        alignment: Alignment.center,
      ),
      SizedBox(width: 10),
      Expanded(
          child: FlatButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Take picture'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _takePicture
          )
        ),
      ],
    );
  }
}
