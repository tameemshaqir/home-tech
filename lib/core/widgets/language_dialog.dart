import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showLanguageDialog(BuildContext context) {
  AwesomeDialog(
    dialogBackgroundColor: const Color(0xFF2a2a2a),
    context: context,
    animType: AnimType.scale,
    btnOkColor: primaryColor,
    dialogType: DialogType.noHeader,
    padding: EdgeInsets.all(10.r),
    body: StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          _buildLanguageOption(
            context: context,
            language: const Locale('ar'),
            title: 'العربية',
            setState: setState,
          ),
          _buildLanguageOption(
            context: context,
            language: const Locale('en'),
            title: 'English',
            setState: setState,
          ),
        ],
      ),
    ),
    btnOkText: 'Ok'.tr(),
    btnOkOnPress: () async {
      if (appLanguage != null) {
        if(appLanguage == const Locale('ar')){
          if(token == null){
            await context.setLocale(appLanguage!);
            Phoenix.rebirth(context);
          }else {
              MainCubit.get(context).postLang(
                  langId: 3, appLanguage: appLanguage!, context: context);
          }
        }else{
          if(token == null){
            await context.setLocale(appLanguage!);
            Phoenix.rebirth(context);
          }else {
            MainCubit.get(context).postLang(
                langId: 1, appLanguage: appLanguage!, context: context);
          }
        }
      }
    },
  ).show();
}

Widget _buildLanguageOption({
  required BuildContext context,
  required Locale language,
  required String title,
  required StateSetter setState,
}) {
  return RadioListTile<Locale>(
    title: Text(title,style: const TextStyle(color: Colors.white),),
    value: language,
    groupValue: appLanguage,
    onChanged: (newLanguage) {
      setState(() {
        appLanguage = newLanguage;
      });
    },
  );
}