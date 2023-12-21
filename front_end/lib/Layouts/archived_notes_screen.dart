import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/cubit.dart';
import '../Cubit/states.dart';
import '../Models/note_model.dart';

class ArchivedNotes extends StatelessWidget {
  const ArchivedNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit,NoteStates>(
        listener: (context,state){},

        builder:(context,state) {
          print(NoteCubit.get(context).notes);
          return (NoteCubit.get(context).archivedNotes.length>0)?
          Scaffold(
              backgroundColor: Colors.grey[300],
              body:ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildNoteItem(NoteCubit.get(context).archivedNotes[index],context,index),
                separatorBuilder: (context, index) =>
                    Padding
                      (
                      padding: const EdgeInsetsDirectional.only(
                          start: 10.0
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 0.0,
                        color: Colors.grey[300],
                      ),
                    ),
                itemCount: (NoteCubit.get(context).archivedNotes.length),
              )
          ):
          Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color:  Colors.grey[600],
                    size: 100,
                  ),
                  Text(
                    "No Archived Notes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[600]
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}


Widget buildNoteItem(Note model,context,int index){

  Color? noteColor = Color(0xFF303030) ;
  if(model.color=="blue") noteColor = Color(0xFF01579B);
  if(model.color=="green") noteColor = Color(0xFF2E7D32);
  if(model.color=="red") noteColor =  Color(0xFFB71C1C);

  return InkWell(
      onTap: (){
        //   print ("we pressed on "+model.name);

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 10.0),
        child: Container(
          margin: EdgeInsets.all(12.0),

          decoration: BoxDecoration(
            color: noteColor,
            border: Border.all(color: noteColor, width: 2.0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(model.name,
                      style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  model.content,
                  maxLines: 3,
                  style: TextStyle(fontSize: 16,color: Colors.white70),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          NoteCubit.get(context).changeArchive(model);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 35.0,
                          color: Colors.white,
                        )
                    ),
                    SizedBox(width: 20,),
                    Icon(Icons.delete_rounded,size: 35,color: Colors.white,),
                    SizedBox(width: 20,),
                    Icon(Icons.edit_outlined,size: 35,color: Colors.white,),
                  ],
                )

              ],
            ),
          ),

        ),
      ));
}
