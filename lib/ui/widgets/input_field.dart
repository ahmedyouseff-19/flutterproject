import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

import '../size_config.dart';
import '../theme.dart';


class InputField extends StatelessWidget {
  const InputField({Key? key, required this.title, required this.hint, this.controller, this.widget}) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TitleStyle,),
          Container(
            padding: const EdgeInsets.only(left: 8),
            margin: const EdgeInsets.only(top: 3),
            width: SizeConfig.screenWidth,
            height: 53,
            decoration: BoxDecoration(
                color: Get.isDarkMode ?  darkGreyClr : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black
                )
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller ,
                    autofocus: false,
                    readOnly: widget!= null? true : false,
                    style: SubTitleStyle ,
                    cursorColor: Get.isDarkMode? Colors.grey[100] : Colors.grey[700],
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: SubTitleStyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0,
                        ),
                      ),
                    ),
                  ),

                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
