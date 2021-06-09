// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HealthCareContactInformationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthCareContactInformationModel _$HealthCareContactInformationModelFromJson(
    Map<String, dynamic> json) {
  return HealthCareContactInformationModel(
    json['requestorFirstName'] as String,
    json['requestorLastName'] as String,
    json['designation'] as String,
    json['institutionName'] as String,
    json['department'] as String,
    json['addressLine1'] as String,
    json['addressLine2'] as String,
    json['state'] as String,
    json['city'] as String,
    json['zip'] as String,
    json['phoneNumber'] as String,
    json['faxNumber'] as String,
    json['email'] as String,
  );
}

Map<String, dynamic> _$HealthCareContactInformationModelToJson(
        HealthCareContactInformationModel instance) =>
    <String, dynamic>{
      'requestorFirstName': instance.requestorFirstName,
      'requestorLastName': instance.requestorLastName,
      'designation': instance.designation,
      'institutionName': instance.institutionName,
      'department': instance.department,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'state': instance.state,
      'city': instance.city,
      'zip': instance.zip,
      'phoneNumber': instance.phoneNumber,
      'faxNumber': instance.faxNumber,
      'email': instance.email,
    };
