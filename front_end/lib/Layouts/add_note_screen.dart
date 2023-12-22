import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants/components.dart';
import '../Cubit/cubit.dart';
import '../Cubit/states.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  var habitNameController = TextEditingController();
  var habitDescController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
                      Text(
                        "Fill the following fields:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.grey[800]
                        ),
                      ),
                      SizedBox(height: 25,),
                      defaultFormField(
                          controller: habitNameController,
                          type: TextInputType.text,
                          validate: (value){
                            if(value!.isEmpty){
                              return "Note Name must not be empty";
                            }
                          },
                          label: "Note Name",
                          prefix: Icons.title
                      ),
                      SizedBox(height: 25,),
                      defaultFormField(
                          controller: habitDescController,
                          type: TextInputType.text,
                          validate: (value){},
                          label: "Note Content (optional)",
                          prefix: Icons.view_headline_sharp,
                        maxLines: 5
                      ),
                      SizedBox(height: 20,),
                      Row(
                         children: [
                           Text("Select color :",
                           style: TextStyle(
                             fontSize: 20,
                             color: Colors.grey[800]
                           ),),
                           SizedBox(width: 20,),
                           Container(
                             child: Row(
                               children: [
                                 InkWell(
                                   onTap: (){},
                                   child: CircleAvatar(
                                     radius: 20,
                                     backgroundColor: Color(0xFFB71C1C),
                                   ),
                                 ),
                                 SizedBox(width: 20,),
                                 InkWell(
                                   onTap: (){},
                                   child: CircleAvatar(
                                     radius: 20,
                                     backgroundColor: Color(0xFF01579B),
                                   ),
                                 ),
                                 SizedBox(width: 20,),
                                 InkWell(
                                   onTap: (){},
                                   child: CircleAvatar(
                                     radius: 20,
                                     backgroundColor: Color(0xFF2E7D32),
                                   ),
                                 ),
                               ],
                             ),
                           )
                         ],
                      ),
                      SizedBox(height: 20,),
                      defaultButton(function: ()async{
                          habitNameController.text = "";
                          habitDescController.text = "";
                      }, text: "Add Note"),
                      SizedBox(height: 20,),
                      defaultButton(function: (){
                        habitNameController.text = "";
                        habitDescController.text = "";
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