import 'package:flutter/material.dart';

extension ExtendedWidget on Widget {
  Widget addPadding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget addMargin(EdgeInsets padding) {
    return Container(
      margin: padding,
      child: this,
    );
  }

  Widget addBorderRadius(BuildContext context,
      {margin = const EdgeInsets.all(0)}) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: this,
    );
  }

  Widget addShadow({Offset? offset}) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          spreadRadius: 0,
          blurRadius: 6,
          offset: offset ?? const Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: this,
    );
  }
}


extension HtmlTagRemover on String {
  String removeHtmlTags() {
    final pattern =
        RegExp(r'<(?!\/?(ul|li|strong|p)\b)[^>]*>', multiLine: true);
    return replaceAll(pattern, '');
  }
}



extension ExtendedInputBorder on Border {
  OutlineInputBorder inputOutlineBorderDecoration({context}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).brightness == Brightness.light
            ? const Color(0xffBDBDBD)
            : const Color(0xff9F9F9F),
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

// String smartDateTimeFormat(
//   String? dateString, {
//   bool isUtc = true,
//   DateFormat? dateFormat,
// }) {
//   if (dateString == null || dateString.isEmpty) {
//     return '';
//   }
//   // parse UTC Date
//   if (isUtc && !dateString.endsWith('Z')) dateString = '${dateString}Z';

//   var date = DateTime.parse(dateString);

//   var today = DateTime.now();

//   if (date.day == today.day) {
//     var format = 'hh:mm a';
//     return "Today at ${DateFormat(format).format(date.toLocal())}";
//   } else if (today.day - 1 == date.day) {
//     var format = 'hh:mm a';
//     return "Yesterday at ${DateFormat(format).format(date.toLocal())}";
//   } else {
//     var format = "dd MMMM "; //dd MMMM hh:mm a
//     return DateFormat(format).format(date.toLocal());
//   }
// }
