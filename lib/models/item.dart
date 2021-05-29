class Item {
  Item(
      {this.id,
      this.name,
      this.style,
      this.caseColor,
      this.caseMaterial,
      this.description,
      this.avatarUrl,
      this.latitude,
      this.longitude});

  String id;
  String name;
  String style;
  String caseColor;
  String caseMaterial;
  String description;
  String avatarUrl;
  double latitude;
  double longitude;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'style': style,
      'caseColor': caseColor,
      'caseMaterial': caseMaterial,
      'description': description,
      'avatarUrl': avatarUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
