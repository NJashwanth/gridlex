// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepresentativeContactInformationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepresentativeContactInformationModel
    _$RepresentativeContactInformationModelFromJson(Map<String, dynamic> json) {
  return RepresentativeContactInformationModel(
    json['representativeName'] as String,
    json['representativeType'] as String,
    json['territoryNumber'] as String,
    json['countryCode'] as String,
    json['telephoneNumber'] as String,
  );
}

Map<String, dynamic> _$RepresentativeContactInformationModelToJson(
        RepresentativeContactInformationModel instance) =>
    <String, dynamic>{
      'representativeName': instance.representativeName,
      'representativeType': instance.representativeType,
      'territoryNumber': instance.territoryNumber,
      'countryCode': instance.countryCode,
      'telephoneNumber': instance.telephoneNumber,
    };
