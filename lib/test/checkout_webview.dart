import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// class ProfileInfoPage extends StatefulWidget {
//   const ProfileInfoPage({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileInfoPage> createState() => _ProfileInfoPageState();
// }
//
// class _ProfileInfoPageState extends State<ProfileInfoPage> {
//
//
//
//
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _instagramController.dispose();
//     super.dispose();
//   }
//
//
//
//
//
//
//
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });
//
//       // محاكاة عملية الإرسال
//       await Future.delayed(Duration(seconds: 2));
//
//       setState(() {
//         _isLoading = false;
//       });
//
//       // عرض رسالة نجاح
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('تم حفظ المعلومات بنجاح!'),
//           backgroundColor: Colors.green[600],
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }