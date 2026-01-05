class TrackerItem {
  final int id;
  final String name;
  final String type;

  TrackerItem({required this.id, required this.name, required this.type});

  factory TrackerItem.fromMap(Map<String, dynamic> map) {
    return TrackerItem(id: map['id'], name: map['name'], type: map['type']);
  }
}
