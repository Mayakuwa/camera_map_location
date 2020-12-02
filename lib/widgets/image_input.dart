import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  
  File _storeImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final PickedFile imageFile = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 600
    );
    setState(() {
      if(imageFile != null) {
        _storeImage = File(imageFile.path);
      } else {
        print('no Image!!');
      }
    });
    final appDir = await syspaths.getApplicationSupportDirectory();
    final fileName = path.basename(imageFile.path);
    final saveImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(saveImage);
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
