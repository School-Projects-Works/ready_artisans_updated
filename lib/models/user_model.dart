// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:ready_artisans/models/category_mode.dart';

class UserModel {
  String? id;
  String? idNumber;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? userType;
  Map<String, dynamic>? location;
  String? gender;
  double? rating;
  double? latitude;
  double? longitude;
  bool? isOnline;
  bool? available;
  String? city;
  String? region;
  List<dynamic>? images;
  int? createdAt;
  String? artisanCategory;

  UserModel({
    this.id,
    this.idNumber,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.image,
    this.userType,
    this.location,
    this.gender,
    this.rating = 2.0,
    this.latitude,
    this.longitude,
    this.isOnline,
    this.available = true,
    this.city,
    this.region,
    this.images,
    this.createdAt,
    this.artisanCategory,
  });

  UserModel copyWith({
    String? id,
    String? idNumber,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? image,
    String? userType,
    Map<String, dynamic>? location,
    String? gender,
    double? rating,
    double? latitude,
    double? longitude,
    bool? isOnline,
    bool? available,
    String? city,
    String? region,
    List<dynamic>? images,
    int? createdAt,
    String? artisanCategory,
  }) {
    return UserModel(
      id: id ?? this.id,
      idNumber: idNumber ?? this.idNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      image: image ?? this.image,
      userType: userType ?? this.userType,
      location: location ?? this.location,
      gender: gender ?? this.gender,
      rating: rating ?? this.rating,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isOnline: isOnline ?? this.isOnline,
      available: available ?? this.available,
      city: city ?? this.city,
      region: region ?? this.region,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      artisanCategory: artisanCategory ?? this.artisanCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idNumber': idNumber,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'image': image,
      'userType': userType,
      'location': location,
      'gender': gender,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
      'isOnline': isOnline,
      'available': available,
      'city': city,
      'region': region,
      'images': images,
      'createdAt': createdAt,
      'artisanCategory': artisanCategory,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      idNumber: map['idNumber'] != null ? map['idNumber'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
      location: map['location'] != null
          ? Map<String, dynamic>.from((map['location'] as Map<String, dynamic>))
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      available: map['available'] != null ? map['available'] as bool : null,
      city: map['city'] != null ? map['city'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      images: map['images'] != null
          ? List<dynamic>.from((map['images'] as List<dynamic>))
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
      artisanCategory: map['artisanCategory'] != null
          ? map['artisanCategory'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, idNumber: $idNumber, name: $name, email: $email, phone: $phone, address: $address, image: $image, userType: $userType, location: $location, gender: $gender, rating: $rating, latitude: $latitude, longitude: $longitude, isOnline: $isOnline, available: $available, city: $city, region: $region, images: $images, createdAt: $createdAt, artisanCategory: $artisanCategory)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idNumber == idNumber &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.address == address &&
        other.image == image &&
        other.userType == userType &&
        mapEquals(other.location, location) &&
        other.gender == gender &&
        other.rating == rating &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isOnline == isOnline &&
        other.available == available &&
        other.city == city &&
        other.region == region &&
        listEquals(other.images, images) &&
        other.createdAt == createdAt &&
        other.artisanCategory == artisanCategory;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idNumber.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        image.hashCode ^
        userType.hashCode ^
        location.hashCode ^
        gender.hashCode ^
        rating.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        isOnline.hashCode ^
        available.hashCode ^
        city.hashCode ^
        region.hashCode ^
        images.hashCode ^
        createdAt.hashCode ^
        artisanCategory.hashCode;
  }

  Map<String, dynamic> locationUpdateMap() {
    return <String, dynamic>{
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'region': region,
    };
  }
}

class DummyData {
  static final Random _random = Random();
  static List<String> ghanaianNames = [
    'Kwame Mensah',
    'Abena Osei',
    'Kofi Boateng',
    'Akua Acheampong',
    'Nana Asante',
    'Ama Adjei',
    'Kwaku Appiah',
    'Efua Ansah',
    'Yaw Amponsah',
    'Esi Adu',
    'Kojo Ampofo',
    'Afia Adomako',
    'Kwabena Boateng',
    'Akosua Darko',
    'Kodjo Nkrumah',
    'Abrafi Ansong',
    'Yaw Boateng',
    'Abena Mensah',
    'Kwame Asamoah',
    'Ama Owusu',
  ];
  static List<String> doctorsImages = [
    "https://img.freepik.com/free-photo/carpenter-cutting-mdf-board-inside-workshop_23-2149451041.jpg?w=740&t=st=1690891302~exp=1690891902~hmac=87ecc13f10e29a2309ec9d3d78cd7a789fc130e3bc384119c606b91383634643",
    "https://img.freepik.com/free-photo/young-african-american-builder-man-wearing-construction-uniform-safety-helmet-standing-with-clipboard-raising-hand-clenching-fist-smiling-standing-with-happy-face-celebrating-victory_141793-19024.jpg?w=740&t=st=1690891336~exp=1690891936~hmac=998707c6b5050f8a0780c4e3dc44c01932f5a22b4e179cb543a6ed2d230a72a0",
    "https://img.freepik.com/premium-photo/people-renovating-house-concept_53876-71844.jpg?w=740",
    "https://img.freepik.com/free-photo/mechanic-checking-oil-level-car-engine_1170-1656.jpg?w=740&t=st=1690891414~exp=1690892014~hmac=c751c038494e0654b0a902d38e5f91b13515fb875dc09a03eebaea605d4bad94",
    "https://img.freepik.com/free-photo/mechanic-servicing-car_1170-1689.jpg?w=740&t=st=1690891477~exp=1690892077~hmac=98f87441e427acbe05691c533b505ce33194fd2a839d0eac25318045cc7c4db2",
    "https://img.freepik.com/free-photo/smiling-holding-points-bucket-cleaning-tools-young-africanamerican-cleaner-male-uniform-with-gloves-isolated-green-background_141793-135154.jpg?w=740&t=st=1690891512~exp=1690892112~hmac=acb989b3159bba3a2612549fba79cf1fd05baf4e362cef14f8e45ccc4b787d8a",
    "https://img.freepik.com/free-photo/full-shot-man-pushing-elevator-button_23-2149345535.jpg?w=740&t=st=1690891529~exp=1690892129~hmac=9d2f59b15cad8fdc988c38f8c6a1da540a8b95b26f193086fe22dec59fb758bb",
    "https://img.freepik.com/free-photo/woman-getting-her-hair-done-salon_23-2148976118.jpg?w=740&t=st=1690891561~exp=1690892161~hmac=b6928a188fba2720ac544cf12d238ac36a0b727d862ace8555fdfe22ba14b3b8",
    "https://img.freepik.com/free-photo/woman-getting-her-hair-done-beauty-salon_23-2148976097.jpg?w=740&t=st=1690891585~exp=1690892185~hmac=8f67a3af0780471d122dd866f033b21f3c593392b7295afcc444871b7e698fc0",
    "https://img.freepik.com/free-photo/man-electrical-technician-working-switchboard-with-fuses_169016-24062.jpg?w=740&t=st=1690891627~exp=1690892227~hmac=fbad92afea9e8694cf4582283580fdaf0fcb737c7f6a2c7d2d2f207ff7dac183",
    "https://img.freepik.com/premium-photo/thoughtful-young-black-african-man-construction-worker_251136-39757.jpg?w=740",
    "https://img.freepik.com/free-photo/young-african-american-man-visiting-barbershop_1157-47691.jpg?w=740&t=st=1690891717~exp=1690892317~hmac=6bd6579030f7741bee762d7d70be8510c86f450d8f3d30b47e20cbee9721d937",
    "https://img.freepik.com/free-photo/side-view-image-young-concentrated-shoemaker_171337-12283.jpg?w=740&t=st=1690891742~exp=1690892342~hmac=dd0027417e179f5619e6f427d0ebb08e84c89420b9716a95b7c75095431b543a",
    "https://img.freepik.com/free-photo/confident-head-cook-standing-restaurant-professional-kitchen-with-arms-crossed-while-smiling-camera-sous-chef-wearing-cooking-uniform-while-preparing-ingredients-dinner-service_482257-44194.jpg?w=740&t=st=1690891778~exp=1690892378~hmac=990ed623630d0ec5f14fda277c776ddf1e544f9cce2bbabd5a2cb08287f77a3b",
    "https://img.freepik.com/free-photo/mechanic-checking-oil-level-car-engine_1170-1656.jpg?w=740&t=st=1690891414~exp=1690892014~hmac=c751c038494e0654b0a902d38e5f91b13515fb875dc09a03eebaea605d4bad94",
    "https://img.freepik.com/free-photo/mechanic-servicing-car_1170-1689.jpg?w=740&t=st=1690891477~exp=1690892077~hmac=98f87441e427acbe05691c533b505ce33194fd2a839d0eac25318045cc7c4db2",
    "https://img.freepik.com/free-photo/smiling-holding-points-bucket-cleaning-tools-young-africanamerican-cleaner-male-uniform-with-gloves-isolated-green-background_141793-135154.jpg?w=740&t=st=1690891512~exp=1690892112~hmac=acb989b3159bba3a2612549fba79cf1fd05baf4e362cef14f8e45ccc4b787d8a",
    "https://img.freepik.com/free-photo/full-shot-man-pushing-elevator-button_23-2149345535.jpg?w=740&t=st=1690891529~exp=1690892129~hmac=9d2f59b15cad8fdc988c38f8c6a1da540a8b95b26f193086fe22dec59fb758bb",
    "https://img.freepik.com/free-photo/woman-getting-her-hair-done-salon_23-2148976118.jpg?w=740&t=st=1690891561~exp=1690892161~hmac=b6928a188fba2720ac544cf12d238ac36a0b727d862ace8555fdfe22ba14b3b8",
    "https://img.freepik.com/free-photo/woman-getting-her-hair-done-beauty-salon_23-2148976097.jpg?w=740&t=st=1690891585~exp=1690892185~hmac=8f67a3af0780471d122dd866f033b21f3c593392b7295afcc444871b7e698fc0",
    "https://img.freepik.com/free-photo/young-african-american-builder-man-wearing-construction-uniform-safety-helmet-standing-with-clipboard-raising-hand-clenching-fist-smiling-standing-with-happy-face-celebrating-victory_141793-19024.jpg?w=740&t=st=1690891336~exp=1690891936~hmac=998707c6b5050f8a0780c4e3dc44c01932f5a22b4e179cb543a6ed2d230a72a0",
    "https://img.freepik.com/premium-photo/people-renovating-house-concept_53876-71844.jpg?w=740",
    "https://img.freepik.com/free-photo/mechanic-checking-oil-level-car-engine_1170-1656.jpg?w=740&t=st=1690891414~exp=1690892014~hmac=c751c038494e0654b0a902d38e5f91b13515fb875dc09a03eebaea605d4bad94",
    "https://img.freepik.com/free-photo/mechanic-servicing-car_1170-1689.jpg?w=740&t=st=1690891477~exp=1690892077~hmac=98f87441e427acbe05691c533b505ce33194fd2a839d0eac25318045cc7c4db2",
  ];

  static List<String> doctorsEmails = [
    'kofimensah@gmail.com',
    'akomansah@gmail.com',
    'owusukwame@example.com',
    'amamensah@example.com',
    'nanaosei@example.com',
    'abenaappiah@example.com',
    'kwesiagyemang@example.com',
    'adwoaboateng@example.com',
    'kofiansah@example.com',
    'afuamensah@example.com',
    'koboateng@example.com',
    'yaadjei@example.com',
    'kwabenadarko@example.com',
    'akuaasante@example.com',
    'kwekuaddo@example.com',
    'efuaamoah@example.com',
    'kwamemensah@example.com',
    'abenaofori@example.com',
    'kofiadu@example.com',
    'akosuafrimpong@example.com',
    'nanakwame@example.com',
    'adwoaboateng@example.com',
    'kwabenaosei@example.com',
    'amaasare@example.com',
    'kofiantwi@example.com',
    'afiaowusu@example.com',
    'kojogyasi@example.com',
    'yaaansah@example.com',
    'kwesiamponsah@example.com',
    'akosuaasamoah@example.com',
  ];
  static List<String> doctorsAddresses = [
    'Block 5, Office 3, Accra',
    'Lapas, P.O. Box 234-4567, Accra',
    'Kumasi, AK-234-4567',
    'Lapas, P.O. Box 234-4567, Accra',
    'Sunyani, BA-345-6789',
    'Tema, TP-789-0123',
    'Kumasi, AK-234-4567',
    'Lapas, P.O. Box 234-4567, Accra',
    'Sunyani, BA-345-6789',
    'Tema, TP-789-0123',
    'Kumasi, AK-234-4567',
    'Lapas, P.O. Box 234-4567, Accra',
    'Sunyani, BA-345-6789',
    'Tema, TP-789-0123',
    'Kumasi, AK-234-4567',
    'Lapas, P.O. Box 234-4567, Accra',
    'Sunyani, BA-345-6789',
    'Tema, TP-789-0123',
    'Kumasi, AK-234-4567',
    'Lapas, P.O. Box 234-4567, Accra',
    'Sunyani, BA-345-6789',
    'Tema, TP-789-0123',
    'Kumasi, AK-234-4567',
    'Lapas, P.O. Box 234-4567, Accra',
    'Sunyani, BA-345-6789',
    'Tema, TP-789-0123',
    'Kumasi, AK-234-4567',
    'Lapas, P.O. Box 234-4567, Accra',
    'Sunyani, BA-345-6789',
    'Tema, TP-789-0123',
  ];
  static List<String> doctorsPhoneNumbers = [
    '0248235689',
    '02458965656',
    '0557823456',
    '0245678921',
    '0509876543',
    '0278765432',
    '0263456789',
    '0234567890',
    '0541234567',
    '0209876543',
    '0556789012',
    '0245678901',
    '0557823456',
    '02458965656',
    '0509876543',
    '0278765432',
    '0263456789',
    '0234567890',
    '0541234567',
    '0209876543',
    '0556789012',
    '0245678901',
    '0557823456',
    '02458965656',
    '0509876543',
    '0278765432',
    '0263456789',
    '0234567890',
    '0541234567',
    '0209876543',
  ];

  static bool _getRandomBool() {
    return _random.nextBool();
  }

  static String _getRandomGender() {
    //rettuen random gender
    return ['Male', 'Female'][_random.nextInt(2)];
  }

  static String _getDoctorSpecialty() {
    //return random doctor specialty
    final doctorSpecialty = CategoryModel.dummyData;
    return doctorSpecialty[_random.nextInt(doctorSpecialty.length)].name!;
  }

  static String generateRandomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    const idLength = 15;
    String id = '';

    for (int i = 0; i < idLength; i++) {
      id += chars[random.nextInt(chars.length)];
    }

    return id;
  }

  static List<UserModel> artisanList() {
    List<UserModel> artisans = [];

    for (int i = 0; i < ghanaianNames.length; i++) {
      artisans.add(
        UserModel(
          name: ghanaianNames[i],
          email: doctorsEmails[i],
          address: doctorsAddresses[i],
          idNumber: generateRandomId(),
          gender: _getRandomGender(),
          phone: doctorsPhoneNumbers[i],
          userType: 'artisan',
          image: doctorsImages[i],
          artisanCategory: _getDoctorSpecialty(),
          //return random double between 1.5 and 5.0
          rating: 1.5 + _random.nextDouble() * (5.0 - 1.5),
          isOnline: _getRandomBool(),
        ),
      );
    }
    return artisans;
  }
}
