abstract class NoteStates{}

class NoteInitialState extends NoteStates{}
class NoteBottomNavState extends NoteStates{}
class NoteChangeBottomNavBarState extends NoteStates{}
class NoteChangeModeState extends NoteStates{}
class NoteSortNotesState extends NoteStates{}
class NoteChangePinState extends NoteStates{}
class NoteChangeArchiveState extends NoteStates{}
class NoteAddArchiveState extends NoteStates{}
class NoteRemoveArchiveState extends NoteStates{}
class NoteChangeColorState extends NoteStates{}

class NoteGetFromApiLoadingState extends NoteStates{

}
class NoteGetFromApiSuccessState extends NoteStates{
  late final data;
  NoteGetFromApiSuccessState({required this.data}){
    print(data);
  }
}
class NoteGetFromApiErrorState extends NoteStates{}


class NoteAddFromApiLoadingState extends NoteStates{}
class NoteAddFromApiSuccessState extends NoteStates{}
class NoteAddFromApiErrorState extends NoteStates{}
