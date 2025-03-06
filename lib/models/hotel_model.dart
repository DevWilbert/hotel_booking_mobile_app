class HotelModel {
 int? id;
 String? name;
 String? city;
 String? address;
 String? phone;
 String? checkInTime;
 String? checkOutTime;
 String? imageHotel;

 HotelModel({
   this.id,
   this.name,
   this.city,
   this.address,
   this.phone,
   this.checkInTime,
   this.checkOutTime,
   this.imageHotel
 });

 factory HotelModel.fromJson(Map<String, dynamic> json) {
   return HotelModel(
     id: json['id'],
     name: json['name'],
     city: json['city'],
     address: json['address'],
     phone: json['phone'],
     checkInTime: json['checkin_time'],
     checkOutTime: json['checkout_time'],
     imageHotel: json['image_hotel'],
   );
 }

}