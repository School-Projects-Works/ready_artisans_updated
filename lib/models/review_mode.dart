// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReviewModel {
  String? id;
  String? senderId;
  String? artisanId;
  String? message;
  double? rating;
  String? senderName;
  String? senderImage;
  int? createdAt;
  ReviewModel({
    this.id,
    this.senderId,
    this.artisanId,
    this.message,
    this.rating,
    this.senderName,
    this.senderImage,
    this.createdAt,
  });

  ReviewModel copyWith({
    String? id,
    String? senderId,
    String? artisanId,
    String? message,
    double? rating,
    String? senderName,
    String? senderImage,
    int? createdAt,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      artisanId: artisanId ?? this.artisanId,
      message: message ?? this.message,
      rating: rating ?? this.rating,
      senderName: senderName ?? this.senderName,
      senderImage: senderImage ?? this.senderImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'artisanId': artisanId,
      'message': message,
      'rating': rating,
      'senderName': senderName,
      'senderImage': senderImage,
      'createdAt': createdAt,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] != null ? map['id'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      artisanId: map['artisanId'] != null ? map['artisanId'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      senderName:
          map['senderName'] != null ? map['senderName'] as String : null,
      senderImage:
          map['senderImage'] != null ? map['senderImage'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewModel(id: $id, senderId: $senderId, artisanId: $artisanId, message: $message, rating: $rating, senderName: $senderName, senderImage: $senderImage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.senderId == senderId &&
        other.artisanId == artisanId &&
        other.message == message &&
        other.rating == rating &&
        other.senderName == senderName &&
        other.senderImage == senderImage &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderId.hashCode ^
        artisanId.hashCode ^
        message.hashCode ^
        rating.hashCode ^
        senderName.hashCode ^
        senderImage.hashCode ^
        createdAt.hashCode;
  }
}

List<String> messages = [
  "The service provided by the artisan was exceptional! They were prompt, professional, and skilled. I was amazed by the quality of their work and how quickly they completed the task. ",
  "I had an urgent requirement, and the artisan responded promptly. They understood my needs and communicated effectively throughout the process. The end result exceeded my expectations, and I couldn't be happier. ",
  "I'll be recommending them to all my friends and family.",
  "The attention to detail and craftsmanship displayed were outstanding."
      "This artisan is a true expert in their field.  They are not only talented but also very friendly and approachable. They went above and beyond to ensure that I was satisfied with the outcome.",
  "I will undoubtedly hire them again and again for any upcoming projects.",
  "I can't thank the artisan enough for their dedication and hard work.  If you need someone reliable and talented, look no further!",
  "The whole experience of working with them was pleasant and stress-free. ",
  "I would highly recommend their services to anyone in need. I'm definitely going to hire them again for future projects.",
  "I am extremely impressed by the professionalism and expertise of this artisan. They provided top-notch service and delivered exceptional results. ",
  "The project was completed ahead of schedule, and the attention to detail was impressive. They are a pleasure to work with, and I'll definitely be hiring them again for my next venture."
];
