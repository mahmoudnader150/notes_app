class NotesFromApi{
  late bool status;
  late NoteDataModel data;

  NotesFromApi.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = NoteDataModel.fromJson(json['data']);
  }


  void myPrint(){
    print(this.status);
    print("\n");
    print(data);
  }
}
class NoteDataModel{
  List<NoteModel> data=[];

  NoteDataModel.fromJson(Map<String,dynamic> json){

    data = json['data'].forEach((element){
      data.add(NoteModel.fromJson(element));
    });
  }
}

class NoteModel{
  late String name;
  late String id;
  late String createdAt;
  late String content;
  late String color;
  late bool pinned;
  late bool archived;

  NoteModel({
    required this.id,
    required this.name,
    this.content="",
    this.color="grey",
    this.createdAt ="2023-12-12",
    this.pinned = false,
    this.archived = false
});
  NoteModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    content = json['content'];
    color = json['color'];
    createdAt = json['createdAt'];
    archived = json['archived'];
    pinned = json['pinned'];
  }

}