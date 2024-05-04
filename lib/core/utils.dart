import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/constants.dart';

String token = '';
String username = '';

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token') ?? '';

  log(token);
  log(username);
}

Future<void> saveData(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> logout() async {
  await saveData('token', '');
  username = '';
}

Future<bool> tokenValid() async {
  await getData();
  List<String> parts = token.split('.');
  if (token.isNotEmpty && parts.length == 3) {
    String payload = parts[1];
    String normalized = base64Url.normalize(payload);
    String decodedPayload = utf8.decode(base64Url.decode(normalized));
    Map<String, dynamic> payloadJson = json.decode(decodedPayload);
    final now = DateTime.now().millisecondsSinceEpoch / 1000;

    if (payloadJson['expiry'] >= now) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

Future<XFile?> pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    return image;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<CroppedFile?> cropImage(String path) async {
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

void showAlertDialog(
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

void showToast(
  BuildContext context,
  String message, [
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
            message,
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
