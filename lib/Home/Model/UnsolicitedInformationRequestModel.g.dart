// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UnsolicitedInformationRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsolicitedInformationRequestModel _$UnsolicitedInformationRequestModelFromJson(
    Map<String, dynamic> json) {
  return UnsolicitedInformationRequestModel(
    (json['product'] as List<dynamic>).map((e) => e as String).toList(),
    json['requestDescription'] as String,
    json['inquiry'] as String,
    json['patientName'] as String,
    json['dob'] as String,
    json['gender'] as String,
    json['dateOfRequest'] as String,
    (json['preferredMethodOfResponse'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$UnsolicitedInformationRequestModelToJson(
        UnsolicitedInformationRequestModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'requestDescription': instance.requestDescription,
      'inquiry': instance.inquiry,
      'patientName': instance.patientName,
      'dob': instance.dob,
      'gender': instance.gender,
      'dateOfRequest': instance.dateOfRequest,
      'preferredMethodOfResponse': instance.preferredMethodOfResponse,
    };
