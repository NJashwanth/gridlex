// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MedicalFormModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalFormModel _$MedicalFormModelFromJson(Map<String, dynamic> json) {
  return MedicalFormModel(
    HealthCareContactInformationModel.fromJson(
        json['healthCareContactInformationModel'] as Map<String, dynamic>),
    UnsolicitedInformationRequestModel.fromJson(
        json['unsolicitedInformationRequestModel'] as Map<String, dynamic>),
    RepresentativeContactInformationModel.fromJson(
        json['representativeContactInformationModel'] as Map<String, dynamic>),
    json['url'] as String,

  );
}

Map<String, dynamic> _$MedicalFormModelToJson(MedicalFormModel instance) =>
    <String, dynamic>{
      'healthCareContactInformationModel':
          instance.healthCareContactInformationModel.toJson(),
      'unsolicitedInformationRequestModel':
          instance.unsolicitedInformationRequestModel.toJson(),
      'representativeContactInformationModel':
          instance.representativeContactInformationModel.toJson(),
      'url': instance.url,

    };
