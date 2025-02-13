import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    requestPermissions(); // طلب الأذونات عند بدء التطبيق
    _fetchUserData();
    _loadImage(); // تحميل مسار الصورة عند بدء الصفحة
  }

  Future<void> requestPermissions() async {
    await [
      Permission.camera,
      Permission.photos,
      Permission.storage,
    ].request();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _name = user.displayName ?? 'Unknown';
        _email = user.email ?? 'No email';
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
        _saveImage(pickedFile.path); // حفظ مسار الصورة في SharedPreferences
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _saveImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', path);
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString('profile_image');
    if (path != null) {
      setState(() {
        _imageFile = XFile(path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('account_details'.tr()), // استخدام مفتاح الترجمة
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Image'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Gallery'),
                                onTap: () async {
                                  await _pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Camera'),
                                onTap: () async {
                                  await _pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(File(
                            _imageFile!.path)) // تحويل المسار إلى كائن File
                        : AssetImage('assets/profile_avatar.png')
                            as ImageProvider,
                    child: _imageFile == null
                        ? Icon(Icons.camera_alt, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  // استخدم Expanded لضبط عرض النصوص
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'account_name'.tr() + ": " + (_name ?? ''),
                        // عرض اسم الحساب
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'account_email'.tr() + ": " + (_email ?? ''),
                        // عرض البريد الإلكتروني
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            Expanded(
              // استخدم Expanded لضبط المساحة المتبقية للعناصر
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('account_settings'.tr()),
                    // ترجمة إعدادات الحساب
                    onTap: () {
                      // تنفيذ الإجراءات المطلوبة عند الضغط
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('edit_profile'.tr()),
                    // ترجمة تعديل الملف الشخصي
                    onTap: () {
                      // تنفيذ الإجراءات المطلوبة عند الضغط
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('logout'.tr()), // ترجمة تسجيل الخروج
                    onTap: () async {
                      await FirebaseAuth.instance
                          .signOut(); // تسجيل الخروج من Firebase
                      Navigator.pop(context); // العودة إلى الشاشة السابقة
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
