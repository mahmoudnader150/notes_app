class Note {
  late bool pinned;
  late String id;
  late String name;
  late String color;
  late String content;
  late bool archived;
  late String createdAt;
  Note({
    this.id = "",
    this.name="name",
    this.content="",
    this.color="grey",
    this.createdAt ="2023-12-12",
    this.pinned = false,
    this.archived = false
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      pinned: json['pinned'] ?? false,
      id: json['_id']??DateTime.now().toIso8601String(),
      name: json['name']??"name",
      color: json['color']??"grey",
      content: json['content']??"content",
      archived: json['archived'] ?? false,
    );
  }
  @override
  String toString() {
    return 'Note { pinned: $pinned, id: $id, name: $name, color: $color, content: $content, archived: $archived }';
  }
}

class Data {
  String status;
  int results;
  List<Note> notes;

  Data({
    required this.status,
    required this.results,
    required this.notes,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var notesList = json['data']['notes'] as List;
    List<Note> parsedNotes = notesList.map((note) => Note.fromJson(note)).toList();

    return Data(
      status: json['status'],
      results: json['results'],
      notes: parsedNotes,
    );
  }

  @override
  String toString() {
    return 'Data { status: $status, results: $results, notes: $notes }';
  }
}