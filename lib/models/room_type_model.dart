class RoomTypeModel {
  int? id;
  String? name;
  int? capacity;
  String? description;
  String? price;
  String? imageRoom;

  RoomTypeModel({
    this.id,
    this.name,
    this.capacity,
    this.description,
    this.price,
    this.imageRoom
  });

  factory RoomTypeModel.fromJson(Map<String, dynamic>json) {
    return RoomTypeModel(
      id: json['id'],
      name: json['name'],
      capacity: json['capacity'],
      description: json['description'],
      price: json['price'],
      imageRoom: json['image_room'],
    );
  }

}