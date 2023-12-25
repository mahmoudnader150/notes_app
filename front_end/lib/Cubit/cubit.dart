import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Cubit/states.dart';
import 'package:note_app/Layouts/add_note_screen.dart';
import 'package:note_app/Layouts/archived_notes_screen.dart';
import 'package:note_app/Layouts/show_notes_screen.dart';
import 'package:note_app/Models/note_model.dart';
import 'package:note_app/network/end_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../network/dio_package.dart';

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

  String cubitColor = "grey";
  void setColor(String clr){
    if(clr == cubitColor) cubitColor="grey";
    else cubitColor = clr;
    emit(NoteChangeColorState());
  }

  List<String> titles=[
    "Saved Notes",
    "Your Archived",
    "Add Note",
  ];
  List<Widget> screens = [
    ShowNotes(),
    ArchivedNotes(),
    AddNote(),
  ];

  List<Note> notes= [];

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




  // void getNotes(){
  //   if(notes.length==0){
  //     emit(NoteGetFromApiLoadingState());
  //
  //     DioHelper.getData(
  //         url: GET_NOTE,
  //     ).then((value){
  //       notesFromApi = NotesFromApi.fromJson(value as Map<String, dynamic>);
  //       notesFromApi?.myPrint();
  //       emit(NoteGetFromApiSuccessState(data: null));
  //     }).catchError((error){
  //       emit(NoteGetFromApiErrorState());
  //       print("error ${error.toString()}");
  //     });
  //   }else{
  //     emit(NoteGetFromApiLoadingState());
  //   }
  // }
  void splitData(Data data){
    notes.clear();
    archivedNotes.clear();
    for (int i=0;i<data.notes.length;i++){
      if(data.notes[i].archived==false){
        notes.add(data.notes[i]);
      }else{
        archivedNotes.add(data.notes[i]);
      }
    }
  }
  Future<void> fetchDataFromBackend() async {
    final String apiUrl = 'http://192.168.1.6:8000/api/notes/';

    try {
      emit(NoteGetFromApiLoadingState());
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        // Parse JSON data into Data model
        Data data = Data.fromJson(jsonData);
         // Debugging purpose

        // assign local to DB from API
        splitData(data);
        print(notes);
        // to re-sort after fetching ...
        sortNotes();
        emit(NoteGetFromApiSuccessState(data:jsonData)); // Emit success state

      } else {
        print('Request failed with status: ${response.statusCode}');
        emit(NoteGetFromApiErrorState()); // Emit error state
      }
    } catch (error) {
      print('Error fetching data: $error');
      emit(NoteGetFromApiErrorState()); // Emit error state
    }
  }


  Future<void> postData(String name,String content,String color) async {
    emit(NoteAddFromApiLoadingState());
    Map<String,dynamic> data = {
      'name':name,
      'content':content,
      'color':color
    };
    DioHelper.postData(url: 'http://192.168.1.6:8000/api/notes/', data: data);
  // fetchDataFromBackend();
   emit(NoteAddFromApiSuccessState());
  }

  // Future<void> deleteData(String id) async {
  //   final url = 'http://192.168.1.6:8000/api/notes/${id}'; // Replace with your API endpoint
  //
  //   try {
  //     final response = await DioHelper.delete(url);
  //
  //     if (response.statusCode == 200) {
  //       // Successfully deleted
  //       print('Data deleted successfully');
  //     } else {
  //       // Failed to delete
  //       print('Failed to delete data. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error deleting data: $error');
  //   }
  // }
  bool isBottomSheetShown = false;
  void changeButtomSheetState({
    required bool isShow
  }){
    isBottomSheetShown = isShow;
    emit(NoteChangeBottomSheetState());
  }

  Future<void> deleteData(Note note) async {
    emit(NoteDeleteFromApiLoadingState());
    final url = 'http://192.168.1.6:8000/api/notes/${note.id}';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 204) {
      emit(NoteDeleteFromApiSuccessState());
      fetchDataFromBackend();
      print('Data deleted successfully');
    } else {
      emit(NoteDeleteFromApiErrorState());
      // Failed to delete
      print('Failed to delete data. Status code: ${response.statusCode}');
    }
  }

  Future<void> updatePin(Note note) async {
    final url = 'http://192.168.1.6:8000/api/notes/${note.id}';
    note.pinned = !note.pinned;

    final Map<String, dynamic> newData = {
      'pinned':note.pinned
    };

    emit(NotePinApiLoadingState());
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(newData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      emit(NotePinApiSuccessState());
      fetchDataFromBackend();
      print('Data updated successfully');
    } else {
      emit(NotePinApiErrorState());
      print('Failed to update data. Status code: ${response.statusCode}');
    }
  }


  Future<void> updateArchive(Note note) async {
    final url = 'http://192.168.1.6:8000/api/notes/${note.id}';
    note.archived = !note.archived ;

    final Map<String, dynamic> newData = {
      'archived':note.archived
    };

    emit(NoteArchiveApiLoadingState());
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(newData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      emit(NoteArchiveApiSuccessState());
      fetchDataFromBackend();
      print('Data updated successfully');
    } else {
      emit(NoteArchiveApiErrorState());
      print('Failed to update data. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateNote(String name,String content,String color,String id) async {
    final url = 'http://192.168.1.6:8000/api/notes/${id}';


    final Map<String, dynamic> newData = {
      'name':name,
      'content':content,
      'color':color
    };

    emit(NoteArchiveApiLoadingState());
    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(newData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      emit(NoteArchiveApiSuccessState());
      fetchDataFromBackend();
      print('Data updated successfully');
    } else {
      emit(NoteArchiveApiErrorState());
      print('Failed to update data. Status code: ${response.statusCode}');
    }
  }

}