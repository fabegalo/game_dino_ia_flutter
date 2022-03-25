// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_dino_ia/ComponentesWidgets/dropdown.dart';

Widget containerShadowHeight(String text, Color color, double height) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.2,
        ),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 1.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
          )
        ],
      ),
      height: height,
      //color: Colors.white,
      child: Center(child: Text(text)));
}

Widget containerShadowHeightAndWidth(
    context, Text text, Color color, double height, double width,
    {double top = 0,
    double right = 0,
    double left = 0,
    double bottom = 0,
    BoxShape shape = BoxShape.rectangle,
    dynamic color2 = Colors.white,
    Icon? icon,
    bool border = false,
    double borderRadius = 5,
    Color? borderColor,
    bool centerText = false,
    bool rightText = false,
    bool leftText = false,
    Icon? incoBeforeText,
    double iconBeforeTextSpace = 15,
    bool animate = false,
    bool inkWell = false,
    Color? inkWellColor,
    Function()? inkWellAction,
    double inkWellBorderRadius = 18,
    Color? inkWellhighlightColor,
    Image? image,
    bool arrowNext = false,
    double arrowLeft = 50,
    Color arrowColor = Colors.white,
    bool dropDownEnable = false,
    bool dropDownUnderlineDisable = false,
    bool dropDownIconArrowDisable = false,
    double dropDownDistanceAfterText = 15,
    String dropDownDefault = '',
    List<DropDownOptions>? dropDownList,
    ValueChanged<String>? dropDownFunction,
    dynamic richText = false}) {
  var rotation = MediaQuery.of(context).orientation;

  bool textRinch = true;

  if (rotation == Orientation.landscape) {
    width = width * 1.0499;
    height = height * 2;
  }

  if (richText != false) {
    debugPrint('IsTrue');
    textRinch = false;
  }

  return animate == false
      ? Container(
          margin: EdgeInsets.only(
              top: top, right: right, left: left, bottom: bottom),
          decoration: border == false
              ? BoxDecoration(
                  shape: shape,
                  boxShadow: [
                    BoxShadow(
                      color: color,
                      blurRadius: 1.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                    )
                  ],
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: border == true
                      ? Border.all(width: 1.0, color: borderColor!)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: color,
                      blurRadius: 1.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                    )
                  ],
                ),
          width: width,
          height: height,
          //color: Colors.white,

          child: inkWell
              ? Material(
                  color: inkWellColor,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(18.0),
                  //     side: BorderSide(color: Colors.red)),
                  child: InkWell(
                    highlightColor: inkWellhighlightColor,
                    //focusColor: Colors.amberAccent,
                    //splashColor: Colors.teal.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(inkWellBorderRadius),
                    child: Center(
                        child: textRinch
                            ? incoBeforeText == null
                                ? (icon == null)
                                    ? (image == null)
                                        ? centerText
                                            ? Center(child: text)
                                            : rightText
                                                ? Align(
                                                    alignment: Alignment.lerp(
                                                        Alignment.centerRight,
                                                        Alignment.centerRight,
                                                        1)!,
                                                    child: text)
                                                : leftText
                                                    ? Align(
                                                        alignment:
                                                            Alignment.lerp(
                                                                Alignment
                                                                    .centerLeft,
                                                                Alignment
                                                                    .centerLeft,
                                                                1)!,
                                                        child: text)
                                                    : text
                                        : image
                                    : icon
                                : Row(
                                    mainAxisAlignment: centerText
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.start,
                                    children: <Widget>[
                                        incoBeforeText,
                                        SizedBox(width: iconBeforeTextSpace),
                                        image ?? const SizedBox(),
                                        Center(child: text),
                                        dropDownEnable
                                            ? SizedBox(
                                                width:
                                                    dropDownDistanceAfterText)
                                            : const SizedBox(),
                                        dropDownEnable
                                            ? dropdown(
                                                dropDownDefault,
                                                dropDownList!,
                                                dropDownFunction!,
                                                underlineEnable:
                                                    !dropDownUnderlineDisable,
                                                iconArrowEnable:
                                                    !dropDownIconArrowDisable)
                                            : const SizedBox(),
                                        arrowNext == true
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    left: arrowLeft),
                                                child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: arrowColor))
                                            : const SizedBox()
                                      ])
                            : richText),
                    onTap: inkWellAction,
                  ))
              : textRinch
                  ? incoBeforeText == null
                      ? (icon == null)
                          ? (image == null)
                              ? centerText
                                  ? Center(child: text)
                                  : rightText
                                      ? Align(
                                          alignment: Alignment.lerp(
                                              Alignment.centerRight,
                                              Alignment.centerRight,
                                              1)!,
                                          child: text)
                                      : leftText
                                          ? Align(
                                              alignment: Alignment.lerp(
                                                  Alignment.centerLeft,
                                                  Alignment.centerLeft,
                                                  1)!,
                                              child: text)
                                          : text
                              : image
                          : icon
                      : Row(
                          mainAxisAlignment: centerText
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: <Widget>[
                              incoBeforeText,
                              SizedBox(width: iconBeforeTextSpace),
                              image ?? const SizedBox(),
                              Center(child: text),
                              dropDownEnable
                                  ? SizedBox(width: dropDownDistanceAfterText)
                                  : const SizedBox(),
                              dropDownEnable
                                  ? dropdown(dropDownDefault, dropDownList!,
                                      dropDownFunction!,
                                      underlineEnable:
                                          !dropDownUnderlineDisable,
                                      iconArrowEnable:
                                          !dropDownIconArrowDisable)
                                  : const SizedBox(),
                              arrowNext == true
                                  ? Container(
                                      margin: EdgeInsets.only(left: arrowLeft),
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: arrowColor))
                                  : const SizedBox()
                            ])
                  : richText)

      //-------------------------------------------CONTAINER ANIMADO !!!!--------------------------------------------------------------------
      : AnimatedContainer(
          //width: size.width / 1.1,
          margin: EdgeInsets.only(
              top: top, right: right, left: left, bottom: bottom),
          // color: corteste,

          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color, color2]),
            //color: corteste
            shape: shape,
            //border: Border.all(width: 0.2),
          ),

          duration: const Duration(seconds: 1),
          //curve: Curves.fastOutSlowIn,
          //curve: Curves.bounceOut,
          //curve: Curves.fastLinearToSlowEaseIn,

          child: SizedBox(
              //margin: EdgeInsets.only(top: top, right: right, left: left, bottom: bottom),

              width: width,
              height: height,
              //color: Colors.white,
              child: Center(child: text)),
        );
}
