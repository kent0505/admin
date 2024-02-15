import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/constants.dart';

class Utils {
  static Future<XFile?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      return image;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<CroppedFile?> cropImage(String path) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: Const.editImagePageTitle,
            backgroundColor: Colors.white,
            toolbarColor: Colors.blueGrey,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Colors.blueGrey,
            hideBottomControls: true,
            lockAspectRatio: false,
          ),
        ],
      );

      if (croppedFile == null) return null;

      return croppedFile;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    Const.token = prefs.getString('token') ?? '';
    Const.username = prefs.getString('username') ?? 'Null';
  }

  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static void showAlertDialog(
    BuildContext context,
    String title,
    void Function() onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(Const.alertButtonCancel),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                onPressed();
              },
              child: Text(Const.alertButtonYes),
            ),
          ],
        );
      },
    );
  }

  static void showToast(
    BuildContext context,
    String message,
    int? status, [
    bool error = false,
  ]) {
    if (error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(20),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: 200,
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: error ? Colors.redAccent : Colors.greenAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              status == null ? message : '$message\n($status)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: error ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
