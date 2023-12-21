import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Cubit/states.dart';
import 'package:note_app/Layouts/add_note_screen.dart';
import 'package:note_app/Layouts/archived_notes_screen.dart';
import 'package:note_app/Layouts/show_notes_screen.dart';

class NoteCubit extends Cubit<NoteStates> {

  NoteCubit() :super(NoteInitialState());
  bool isDark = false;

  void changeAppMode({bool? fromShared}){
    isDark = !isDark;
    emit(NoteChangeModeState());
  }
  static NoteCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void changeIndex(index){
    currentIndex = index;
    emit(NoteChangeBottomNavBarState());
  }

  List<String> titles=[
    "Notes",
    "Your Archived",
    "Add Note",
  ];
  List<Widget> screens = [
    ShowNotes(),
    ArchivedNotes(),
    AddNote(),

  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.archive_outlined),
        label: 'Archived'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined),
        label: 'Add Note'
    ),


  ];


}