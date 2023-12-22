import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/cubit.dart';
import '../Cubit/states.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var  cubit = NoteCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[400],
              actions: [
                IconButton(onPressed: (){
                  NoteCubit.get(context).changeAppMode();
                }, icon: Icon(Icons.sunny_snowing,color:Colors.grey[800] ,))
              ],
              title:  Center(child: Text(cubit.titles[cubit.currentIndex],style: TextStyle(color: Colors.grey[800]),)),
              elevation: 0.0,
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.grey[400],
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                elevation: 0.0,
                selectedItemColor: Colors.grey[800],
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items:cubit.bottomItems
            ),
          );
        }
    );
  }
}
