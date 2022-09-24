import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputField extends StatelessWidget {
  String title;
  String hint;
  TextEditingController? controller;
  final Widget? widget;
   MyInputField({super.key,  this.widget,required this.title,required this.hint, this.controller  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start
      ,children: [
      Text(title,style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.w600),),
      Container(
        margin: EdgeInsets.only(top:8 ),
        height: 52,
        padding: EdgeInsets.only(left: 14),
        width: 360,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1,),borderRadius: BorderRadius.circular(12)
        
        
        ),
        child: Row(
          children: [
            Expanded(
            child:TextFormField(
            readOnly: widget==null?false:true,
            autocorrect: false,
            controller: controller,
            cursorColor: Colors.grey,
            style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w600),decoration: InputDecoration(hintText: hint,hintStyle:GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w600),focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),enabledBorder:UnderlineInputBorder(borderSide: BorderSide.none) ),
            ),
            )
            ,
            widget==null?Container():Container(child: widget,)
          ],
        ),


        
      )
    ]),);
  }
}
