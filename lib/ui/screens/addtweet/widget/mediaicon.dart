import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/utils/class.dart';

class MediaIcon extends StatefulWidget {
  MediaIcon({super.key, required this.onImageSelected});
  final void Function(File?) onImageSelected;

  @override
  _MediaIconState createState() => _MediaIconState();
}

class _MediaIconState extends State<MediaIcon> {
  File? imageFile;

  Future<void> _selectImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      widget.onImageSelected(imageFile);
    }
  }

  void _removeImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 288,
          height:  imageFile != null ? 288 : 0,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              imageFile != null
                  ? Image.file(
                File(imageFile!.path!),
                width: 288,
                height: null,
                fit: BoxFit.cover,
              )
                  : Container(),
              imageFile != null
                  ? Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CardColor.titleColor.withOpacity(0.7),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: CardColor.fullScreenTitleColor,
                    size: 20,
                  ),
                  onPressed: _removeImage,
                ),
              )
                  : Container(),
            ],
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomLeft,
          child: IconButton(
            icon: Icon(
              Icons.perm_media_outlined,
              size: 30,
              color: CardColor.iconColorblue,
            ),
            onPressed: () {
              _selectImage(context);
            },
          ),
        ),
      ],
    );
  }
}
