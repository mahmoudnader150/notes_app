class Note{
  late String name;
  late String id;
  late String createdAt;
  late String content;
  late String color;

  Note({
    required this.id,
    required this.name,
    this.content="",
    this.color="grey",
    this.createdAt ="2023-12-12"
});
}