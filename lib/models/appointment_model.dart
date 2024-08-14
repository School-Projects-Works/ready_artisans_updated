// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AppointmentModel {
  String id;
  String clientId;
  String artisanId;
  String artisanName;
  List<dynamic> ids;
  String artisanImage;
  String artisanCategory;
  String clientName;
  String clientImage;
  String clientPhone;
  String clientAddress;
  String clientEmail;
  String artisanPhone;
  String artisanAddress;
  String artisanEmail;
  String note;
  double artisanLatitude;
  double artisanLongitude;
  double clientLatitude;
  double clientLongitude;
  Map<String, dynamic> clientLocation;
  Map<String, dynamic> artisanLocation;
  String status;
  bool paid;
  double perHourRate;
  double totalAmount;
  int startTime;
  int endTime;
  int createdAt;
  AppointmentModel({
    required this.id,
    required this.clientId,
    required this.artisanId,
    required this.artisanName,
     this.ids=const [],
    required this.artisanImage,
    required this.artisanCategory,
    required this.clientName,
    required this.clientImage,
    required this.clientPhone,
    required this.clientAddress,
    required this.clientEmail,
    required this.artisanPhone,
    required this.artisanAddress,
    required this.artisanEmail,
     this.note='',
     this.artisanLatitude = 0.0,
     this.artisanLongitude = 0.0,
     this.clientLatitude = 0.0,
     this.clientLongitude = 0.0,
     this.clientLocation = const {},
     this.artisanLocation=const {},
     this.status='Pending',
     this.paid=false,
    required this.perHourRate,
    required this.totalAmount,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
  });
  

  static AppointmentModel empty(){
    return AppointmentModel(
      id: '',
      clientId: '',
      artisanId: '',
      artisanName: '',
      ids: [],
      artisanImage: '',
      artisanCategory: '',
      clientName: '',
      clientImage: '',
      clientPhone: '',
      clientAddress: '',
      clientEmail: '',
      artisanPhone: '',
      artisanAddress: '',
      artisanEmail: '',
      note: '',
      artisanLatitude: 0.0,
      artisanLongitude: 0.0,
      clientLatitude: 0.0,
      clientLongitude: 0.0,
      clientLocation: {},
      artisanLocation: {},
      status: 'Pending',
      paid: false,
      perHourRate: 0.0,
      totalAmount: 0.0,
      startTime: 0,
      endTime: 0,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

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
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'clientId': clientId});
    result.addAll({'artisanId': artisanId});
    result.addAll({'artisanName': artisanName});
    result.addAll({'ids': ids});
    result.addAll({'artisanImage': artisanImage});
    result.addAll({'artisanCategory': artisanCategory});
    result.addAll({'clientName': clientName});
    result.addAll({'clientImage': clientImage});
    result.addAll({'clientPhone': clientPhone});
    result.addAll({'clientAddress': clientAddress});
    result.addAll({'clientEmail': clientEmail});
    result.addAll({'artisanPhone': artisanPhone});
    result.addAll({'artisanAddress': artisanAddress});
    result.addAll({'artisanEmail': artisanEmail});
    result.addAll({'note': note});
    result.addAll({'artisanLatitude': artisanLatitude});
    result.addAll({'artisanLongitude': artisanLongitude});
    result.addAll({'clientLatitude': clientLatitude});
    result.addAll({'clientLongitude': clientLongitude});
    result.addAll({'clientLocation': clientLocation});
    result.addAll({'artisanLocation': artisanLocation});
    result.addAll({'status': status});
    result.addAll({'paid': paid});
    result.addAll({'perHourRate': perHourRate});
    result.addAll({'totalAmount': totalAmount});
    result.addAll({'startTime': startTime});
    result.addAll({'endTime': endTime});
    result.addAll({'createdAt': createdAt});
  
    return result;
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] ?? '',
      clientId: map['clientId'] ?? '',
      artisanId: map['artisanId'] ?? '',
      artisanName: map['artisanName'] ?? '',
      ids: List<dynamic>.from(map['ids']),
      artisanImage: map['artisanImage'] ?? '',
      artisanCategory: map['artisanCategory'] ?? '',
      clientName: map['clientName'] ?? '',
      clientImage: map['clientImage'] ?? '',
      clientPhone: map['clientPhone'] ?? '',
      clientAddress: map['clientAddress'] ?? '',
      clientEmail: map['clientEmail'] ?? '',
      artisanPhone: map['artisanPhone'] ?? '',
      artisanAddress: map['artisanAddress'] ?? '',
      artisanEmail: map['artisanEmail'] ?? '',
      note: map['note'] ?? '',
      artisanLatitude: map['artisanLatitude']?.toDouble() ?? 0.0,
      artisanLongitude: map['artisanLongitude']?.toDouble() ?? 0.0,
      clientLatitude: map['clientLatitude']?.toDouble() ?? 0.0,
      clientLongitude: map['clientLongitude']?.toDouble() ?? 0.0,
      clientLocation: Map<String, dynamic>.from(map['clientLocation']),
      artisanLocation: Map<String, dynamic>.from(map['artisanLocation']),
      status: map['status'] ?? '',
      paid: map['paid'] ?? false,
      perHourRate: map['perHourRate']?.toDouble() ?? 0.0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      startTime: map['startTime']?.toInt() ?? 0,
      endTime: map['endTime']?.toInt() ?? 0,
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) => AppointmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppointmentModel(id: $id, clientId: $clientId, artisanId: $artisanId, artisanName: $artisanName, ids: $ids, artisanImage: $artisanImage, artisanCategory: $artisanCategory, clientName: $clientName, clientImage: $clientImage, clientPhone: $clientPhone, clientAddress: $clientAddress, clientEmail: $clientEmail, artisanPhone: $artisanPhone, artisanAddress: $artisanAddress, artisanEmail: $artisanEmail, note: $note, artisanLatitude: $artisanLatitude, artisanLongitude: $artisanLongitude, clientLatitude: $clientLatitude, clientLongitude: $clientLongitude, clientLocation: $clientLocation, artisanLocation: $artisanLocation, status: $status, paid: $paid, perHourRate: $perHourRate, totalAmount: $totalAmount, startTime: $startTime, endTime: $endTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppointmentModel &&
      other.id == id &&
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
