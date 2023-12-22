import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Cubit/states.dart';
import 'package:note_app/Layouts/add_note_screen.dart';
import 'package:note_app/Layouts/archived_notes_screen.dart';
import 'package:note_app/Layouts/show_notes_screen.dart';
import 'package:note_app/Models/note_model.dart';

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

  List<Note> notes=[
    Note(id: "123456", name: "Note one",content: "Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented",color: "grey",createdAt: "10:00 AM"),
    Note(id: "123456", name: "Note Two",content: "Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented",color: "red",createdAt: "10:00 AM"),
    Note(id: "123456", name: "Note Three",content: "Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented",color: "blue",createdAt: "10:00 AM"),
    Note(id: "123456", name: "Note Two",content: "Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented Content for my note to be presented",color: "green",createdAt: "10:00 AM"),
  ];

  List<Note> archivedNotes=[];

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

  void sortNotes(){
    for (int i = 0; i < notes.length - 1; i++) {
      for (int j = 0; j < notes.length - i - 1; j++) {
        if (!notes[j].pinned && notes[j + 1].pinned) {
          // Swap if the current note is unpinned and the next note is pinned
          Note temp = notes[j];
          notes[j] = notes[j + 1];
          notes[j + 1] = temp;
        }
      }
    }
    emit(NoteSortNotesState());
  }

  void changePin(Note note) {
    note.pinned = !note.pinned;
    sortNotes();
    emit(NoteChangePinState());
  }

  void changeArchive(Note note) {
    note.archived = !note.archived;
    if(note.archived){
      notes.remove(note);
      archivedNotes.add(note);
      emit(NoteAddArchiveState());
    }else{
      notes.add(note);
      archivedNotes.remove(note);
      emit(NoteRemoveArchiveState());
    }
    sortNotes();
    emit(NoteChangeArchiveState());
  }


}