class Note {
  Note({this.id, this.owner, this.hasAccess, this.title, this.text});

  String id;
  String owner;
  List<String> hasAccess;
  String title;
  String text;

  factory Note.fromJson(Map<String, Object> json) {
    return Note(
      id: json['noteid'],
      owner: json['owner'],
      // hasAccess: json['hasAccess'],
      title: json['title'],
      text: json['text'],
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'username': owner,
      'newTitle': title,
      'newNote': text,
      // 'hasAccess': hasAccess,
    };
  }
}