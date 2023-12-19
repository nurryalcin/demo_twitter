import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/profiledetail/editprofile/editprofileavatarphoto.dart';
import 'package:twitter/utils/provider.dart';


class ProfileSelectImage extends StatefulWidget {
  ProfileSelectImage({
    Key? key,
    required this.selectedImagePath,
    required this.onUpdateSelectedImagePath,
  }) : super(key: key);

  String? selectedImagePath;
   void Function(String) onUpdateSelectedImagePath;




   @override
  State<StatefulWidget> createState() => _ProfileSelectImageState();
}

class _ProfileSelectImageState extends State<ProfileSelectImage> {
  final userProvider = UserProfileProvider();



  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null  ) {
        setState(() {
          widget.selectedImagePath = pickedImage.path;
          widget.onUpdateSelectedImagePath(widget.selectedImagePath!);
        });
      }
    }




  Future<void> _pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(()  {
        widget.selectedImagePath= pickedImage.path;
        widget.onUpdateSelectedImagePath(widget.selectedImagePath!);



      });
    }
  }

  void _showImageSourceSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Fotoğrafı Nasıl Seçmek İstersiniz"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Galeri"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kamera"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 80, top: 10),
              width: 500,
              height: 150,
              color: Colors.grey[300],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _showImageSourceSelection(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.only(left: 15, top: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Provider.of<UserProfileProvider>(context).fullScreenTitleColor,
                      ),
                      height: 100,
                      width: 100,
                      child: EditProfileAvatarPhoto(
                        imagePath: widget.selectedImagePath,
                      )),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

