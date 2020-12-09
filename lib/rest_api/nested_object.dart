class NestedObject {
  String name;
  List<NestedObject> objects = List<NestedObject>();

  NestedObject({this.name});
  NestedObject fromJson(Map<String, dynamic> json) {
    json.keys.forEach((element) {
      objects.add(NestedObject(name: element));
      if (json[element]?.keys.isNotEmpty)
        objects.last.fromJson(json[element] as Map<String, dynamic>);
    });
    return this;
  }
}
