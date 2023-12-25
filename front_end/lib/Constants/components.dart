import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget defaultButton({
  double width = double.infinity,
  Color background = (Colors.black45),
  bool isUpperCase = true,
  double radius = 10.0,
  required VoidCallback function,
  required String text,
  Color textColor = Colors.white,
})=> Container(
  width: width,

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
  child: MaterialButton(
    onPressed:function,
    child: Text(
      "${isUpperCase?text.toUpperCase():text.toLowerCase()}",
      style: TextStyle(
          color: textColor
      ),
    ),

  ),
);


//===================================================

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  required String?Function(String?) validate,
  required String label,
  required IconData prefix,
  bool obscure = false,
  VoidCallback? onTap,
  bool isClickable = true,
  IconData? suffix ,
  void Function()?  suffixPressed,
  int maxLines = 1
})=>TextFormField(

  controller: controller,

  keyboardType: type,

  onFieldSubmitted: onSubmit,

  onChanged: onChange ,

  validator: validate ,

  obscureText: obscure,

  onTap: onTap,

  enabled: isClickable,


maxLines: maxLines,
  cursorColor:  Colors.grey[700],

  decoration: InputDecoration(
    border: OutlineInputBorder(),

    labelText: label,

    labelStyle: TextStyle(

      color:  Colors.grey[700],

    ),

    focusedBorder: OutlineInputBorder(

      borderSide: BorderSide(color: Colors.grey), // Green border when focused

    ),



    suffixIcon: IconButton(

      icon: Icon(suffix),

      onPressed: suffixPressed,

      color:  Colors.grey[700],

    ),

    prefixIcon: Icon(prefix,color:  Colors.grey[800],),


  ),

);


String showDate(String fullDate){
  String date="";
  for(int i=0;i<fullDate.length;i++){
    if(fullDate[i]=='T')break;
    date+=fullDate[i];
  }
  return date;
}

void navigateTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>widget
    )
);
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) =>widget
  ),
      (route)=>false,
);


Widget defaultTextButton({
  required VoidCallback? function,
  required String text
})=>TextButton(
  onPressed: function,
  child: Text(text.toUpperCase(),style: TextStyle(color: Colors.green[600]),),

);

// void showToast({
//   required String text,
// })=>
//     Fluttertoast.showToast(
//         msg: text,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 5,
//         backgroundColor:  Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
