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

// GET STATES
class NoteGetFromApiLoadingState extends NoteStates{}
class NoteGetFromApiSuccessState extends NoteStates{
  late final data;
  NoteGetFromApiSuccessState({required this.data}){
    print(data);
  }
}
class NoteGetFromApiErrorState extends NoteStates{}

// POST STATES
class NoteAddFromApiLoadingState extends NoteStates{}
class NoteAddFromApiSuccessState extends NoteStates{}
class NoteAddFromApiErrorState extends NoteStates{}

// DELETE STATES
class NoteDeleteFromApiLoadingState extends NoteStates{}
class NoteDeleteFromApiSuccessState extends NoteStates{}
class NoteDeleteFromApiErrorState extends NoteStates{}

// UPDATE PINNED STATES
class NotePinApiLoadingState extends NoteStates{}
class NotePinApiSuccessState extends NoteStates{}
class NotePinApiErrorState extends NoteStates{}

// UPDATE ARCHIVED STATES
class NoteArchiveApiLoadingState extends NoteStates{}
class NoteArchiveApiSuccessState extends NoteStates{}
class NoteArchiveApiErrorState extends NoteStates{}

