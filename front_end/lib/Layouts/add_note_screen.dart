import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/network/dio_package.dart';

import '../Constants/components.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
import '../Models/note_model.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  var noteNameController = TextEditingController();
  var noteContentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String color = "grey";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit,NoteStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.grey[400],
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text(
                        "Fill the following fields:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.grey[800]
                        ),
                      ),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: noteNameController,
                          type: TextInputType.text,
                          validate: (value){
                            if(value!.isEmpty){
                              return "Note Name must not be empty";
                            }
                          },
                          label: "Note Name",
                          prefix: Icons.title
                      ),
                      SizedBox(height: 30,),
                      defaultFormField(
                          controller: noteContentController,
                          type: TextInputType.text,
                          validate: (value){},
                          label: "Note Content (optional)",
                          prefix: Icons.view_headline_sharp,
                        maxLines: 7
                      ),
                      SizedBox(height: 25,),
                      Row(
                         children: [
                           Text("Select color :",
                           style: TextStyle(
                             fontSize: 20,
                             color: Colors.grey[800]
                           ),),
                           SizedBox(width: 25,),
                           Container(
                             child: Row(
                               children: [
                                 InkWell(
                                   onTap: (){
                                     NoteCubit.get(context).setColor("red");
                                   },
                                   child: CircleAvatar(
                                     child: NoteCubit.get(context).cubitColor=="red"?Icon(Icons.check):null,
                                     radius: 20,
                                     backgroundColor: Color(0xFFB71C1C),
                                   ),
                                 ),
                                 SizedBox(width: 25,),
                                 InkWell(
                                   onTap: (){
                                     NoteCubit.get(context).setColor("blue");
                                   },
                                   child: CircleAvatar(
                                     child:NoteCubit.get(context).cubitColor=="blue"?Icon(Icons.check):null ,
                                     radius: 20,
                                     backgroundColor: Color(0xFF01579B),
                                   ),
                                 ),
                                 SizedBox(width: 25,),
                                 InkWell(
                                   onTap: (){
                                     NoteCubit.get(context).setColor("green");
                                   },
                                   child: CircleAvatar(
                                     child:NoteCubit.get(context).cubitColor=="green"?Icon(Icons.check):null ,
                                     radius: 20,
                                     backgroundColor: Color(0xFF2E7D32),
                                   ),
                                 ),
                               ],
                             ),
                           )
                         ],
                      ),
                      SizedBox(height: 25,),
                      defaultButton(function: ()async{
                        if(formKey.currentState!.validate()) {
                          NoteCubit.get(context).postData(noteNameController.text, noteContentController.text,NoteCubit.get(context).cubitColor);                          // Note note = Note(name:noteNameController.text,content: noteContentController.text );
                          // print(note);
                          NoteCubit.get(context).fetchDataFromBackend();
                          noteNameController.text = "";
                          noteContentController.text = "";
                          NoteCubit.get(context).setColor("grey");
                        }
                      }, text: "Add Note"),
                      SizedBox(height: 25,),
                      defaultButton(function: (){
                        noteNameController.text = "";
                        noteContentController.text = "";
                        NoteCubit.get(context).setColor("grey");
                      }, text: "Clear",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );

  }
}