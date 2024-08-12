// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AppointmentModel {
  String? id;
  String? clientId;
  String? artisanId;
  String? artisanName;
  List<dynamic>? ids;
  String? artisanImage;
  String? artisanCategory;
  String? clientName;
  String? clientImage;
  String? clientPhone;
  String? clientAddress;
  String? clientEmail;
  String? artisanPhone;
  String? artisanAddress;
  String? artisanEmail;
  String? note;
  double? artisanLatitude;
  double? artisanLongitude;
  double? clientLatitude;
  double? clientLongitude;
  Map<String, dynamic>? clientLocation;
  Map<String, dynamic>? artisanLocation;
  String? status;
  bool? paid;
  double? perHourRate;
  double? totalAmount;
  int? startTime;
  int? endTime;
  int? createdAt;
  AppointmentModel({
    this.id,
    this.clientId,
    this.artisanId,
    this.artisanName,
    this.ids,
    this.artisanImage,
    this.artisanCategory,
    this.clientName,
    this.clientImage,
    this.clientPhone,
    this.clientAddress,
    this.clientEmail,
    this.artisanPhone,
    this.artisanAddress,
    this.artisanEmail,
    this.note,
    this.artisanLatitude,
    this.artisanLongitude,
    this.clientLatitude,
    this.clientLongitude,
    this.clientLocation,
    this.artisanLocation,
    this.status = 'Pending',
    this.paid,
    this.perHourRate,
    this.totalAmount,
    this.startTime,
    this.endTime,
    this.createdAt,
  });

  AppointmentModel copyWith({
    String? id,
    String? clientId,
    String? artisanId,
    String? artisanName,
    List<dynamic>? ids,
    String? artisanImage,
    String? artisanCategory,
    String? clientName,
    String? clientImage,
    String? clientPhone,
    String? clientAddress,
    String? clientEmail,
    String? artisanPhone,
    String? artisanAddress,
    String? artisanEmail,
    String? note,
    double? artisanLatitude,
    double? artisanLongitude,
    double? clientLatitude,
    double? clientLongitude,
    Map<String, dynamic>? clientLocation,
    Map<String, dynamic>? artisanLocation,
    String? status,
    bool? paid,
    double? perHourRate,
    double? totalAmount,
    int? startTime,
    int? endTime,
    int? createdAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      artisanId: artisanId ?? this.artisanId,
      artisanName: artisanName ?? this.artisanName,
      ids: ids ?? this.ids,
      artisanImage: artisanImage ?? this.artisanImage,
      artisanCategory: artisanCategory ?? this.artisanCategory,
      clientName: clientName ?? this.clientName,
      clientImage: clientImage ?? this.clientImage,
      clientPhone: clientPhone ?? this.clientPhone,
      clientAddress: clientAddress ?? this.clientAddress,
      clientEmail: clientEmail ?? this.clientEmail,
      artisanPhone: artisanPhone ?? this.artisanPhone,
      artisanAddress: artisanAddress ?? this.artisanAddress,
      artisanEmail: artisanEmail ?? this.artisanEmail,
      note: note ?? this.note,
      artisanLatitude: artisanLatitude ?? this.artisanLatitude,
      artisanLongitude: artisanLongitude ?? this.artisanLongitude,
      clientLatitude: clientLatitude ?? this.clientLatitude,
      clientLongitude: clientLongitude ?? this.clientLongitude,
      clientLocation: clientLocation ?? this.clientLocation,
      artisanLocation: artisanLocation ?? this.artisanLocation,
      status: status ?? this.status,
      paid: paid ?? this.paid,
      perHourRate: perHourRate ?? this.perHourRate,
      totalAmount: totalAmount ?? this.totalAmount,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clientId': clientId,
      'artisanId': artisanId,
      'artisanName': artisanName,
      'ids': ids,
      'artisanImage': artisanImage,
      'artisanCategory': artisanCategory,
      'clientName': clientName,
      'clientImage': clientImage,
      'clientPhone': clientPhone,
      'clientAddress': clientAddress,
      'clientEmail': clientEmail,
      'artisanPhone': artisanPhone,
      'artisanAddress': artisanAddress,
      'artisanEmail': artisanEmail,
      'note': note,
      'artisanLatitude': artisanLatitude,
      'artisanLongitude': artisanLongitude,
      'clientLatitude': clientLatitude,
      'clientLongitude': clientLongitude,
      'clientLocation': clientLocation,
      'artisanLocation': artisanLocation,
      'status': status,
      'paid': paid,
      'perHourRate': perHourRate,
      'totalAmount': totalAmount,
      'startTime': startTime,
      'endTime': endTime,
      'createdAt': createdAt,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] != null ? map['id'] as String : null,
      clientId: map['clientId'] != null ? map['clientId'] as String : null,
      artisanId: map['artisanId'] != null ? map['artisanId'] as String : null,
      artisanName:
          map['artisanName'] != null ? map['artisanName'] as String : null,
      ids: map['ids'] != null
          ? List<dynamic>.from((map['ids'] as List<dynamic>))
          : null,
      artisanImage:
          map['artisanImage'] != null ? map['artisanImage'] as String : null,
      artisanCategory: map['artisanCategory'] != null
          ? map['artisanCategory'] as String
          : null,
      clientName:
          map['clientName'] != null ? map['clientName'] as String : null,
      clientImage:
          map['clientImage'] != null ? map['clientImage'] as String : null,
      clientPhone:
          map['clientPhone'] != null ? map['clientPhone'] as String : null,
      clientAddress:
          map['clientAddress'] != null ? map['clientAddress'] as String : null,
      clientEmail:
          map['clientEmail'] != null ? map['clientEmail'] as String : null,
      artisanPhone:
          map['artisanPhone'] != null ? map['artisanPhone'] as String : null,
      artisanAddress: map['artisanAddress'] != null
          ? map['artisanAddress'] as String
          : null,
      artisanEmail:
          map['artisanEmail'] != null ? map['artisanEmail'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      artisanLatitude: map['artisanLatitude'] != null
          ? map['artisanLatitude'] as double
          : null,
      artisanLongitude: map['artisanLongitude'] != null
          ? map['artisanLongitude'] as double
          : null,
      clientLatitude: map['clientLatitude'] != null
          ? map['clientLatitude'] as double
          : null,
      clientLongitude: map['clientLongitude'] != null
          ? map['clientLongitude'] as double
          : null,
      clientLocation: map['clientLocation'] != null
          ? Map<String, dynamic>.from(
              (map['clientLocation'] as Map<String, dynamic>))
          : null,
      artisanLocation: map['artisanLocation'] != null
          ? Map<String, dynamic>.from(
              (map['artisanLocation'] as Map<String, dynamic>))
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      paid: map['paid'] != null ? map['paid'] as bool : null,
      perHourRate:
          map['perHourRate'] != null ? map['perHourRate'] as double : null,
      totalAmount:
          map['totalAmount'] != null ? map['totalAmount'] as double : null,
      startTime: map['startTime'] != null ? map['startTime'] as int : null,
      endTime: map['endTime'] != null ? map['endTime'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppointmentModel(id: $id, clientId: $clientId, artisanId: $artisanId, artisanName: $artisanName, ids: $ids, artisanImage: $artisanImage, artisanCategory: $artisanCategory, clientName: $clientName, clientImage: $clientImage, clientPhone: $clientPhone, clientAddress: $clientAddress, clientEmail: $clientEmail, artisanPhone: $artisanPhone, artisanAddress: $artisanAddress, artisanEmail: $artisanEmail, note: $note, artisanLatitude: $artisanLatitude, artisanLongitude: $artisanLongitude, clientLatitude: $clientLatitude, clientLongitude: $clientLongitude, clientLocation: $clientLocation, artisanLocation: $artisanLocation, status: $status, paid: $paid, perHourRate: $perHourRate, totalAmount: $totalAmount, startTime: $startTime, endTime: $endTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant AppointmentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.clientId == clientId &&
        other.artisanId == artisanId &&
        other.artisanName == artisanName &&
        listEquals(other.ids, ids) &&
        other.artisanImage == artisanImage &&
        other.artisanCategory == artisanCategory &&
        other.clientName == clientName &&
        other.clientImage == clientImage &&
        other.clientPhone == clientPhone &&
        other.clientAddress == clientAddress &&
        other.clientEmail == clientEmail &&
        other.artisanPhone == artisanPhone &&
        other.artisanAddress == artisanAddress &&
        other.artisanEmail == artisanEmail &&
        other.note == note &&
        other.artisanLatitude == artisanLatitude &&
        other.artisanLongitude == artisanLongitude &&
        other.clientLatitude == clientLatitude &&
        other.clientLongitude == clientLongitude &&
        mapEquals(other.clientLocation, clientLocation) &&
        mapEquals(other.artisanLocation, artisanLocation) &&
        other.status == status &&
        other.paid == paid &&
        other.perHourRate == perHourRate &&
        other.totalAmount == totalAmount &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientId.hashCode ^
        artisanId.hashCode ^
        artisanName.hashCode ^
        ids.hashCode ^
        artisanImage.hashCode ^
        artisanCategory.hashCode ^
        clientName.hashCode ^
        clientImage.hashCode ^
        clientPhone.hashCode ^
        clientAddress.hashCode ^
        clientEmail.hashCode ^
        artisanPhone.hashCode ^
        artisanAddress.hashCode ^
        artisanEmail.hashCode ^
        note.hashCode ^
        artisanLatitude.hashCode ^
        artisanLongitude.hashCode ^
        clientLatitude.hashCode ^
        clientLongitude.hashCode ^
        clientLocation.hashCode ^
        artisanLocation.hashCode ^
        status.hashCode ^
        paid.hashCode ^
        perHourRate.hashCode ^
        totalAmount.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        createdAt.hashCode;
  }
}
