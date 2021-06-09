import 'package:gridlex_assessment/Home/Model/HealthCareContactInformationModel.dart';
import 'package:gridlex_assessment/Home/Model/RepresentativeContactInformationModel.dart';
import 'package:gridlex_assessment/Home/Model/UnsolicitedInformationRequestModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MedicalFormModel.g.dart';

@JsonSerializable(explicitToJson: true)
class MedicalFormModel {
  HealthCareContactInformationModel healthCareContactInformationModel;
  UnsolicitedInformationRequestModel unsolicitedInformationRequestModel;
  RepresentativeContactInformationModel representativeContactInformationModel;
  String url;
  MedicalFormModel(
      this.healthCareContactInformationModel,
      this.unsolicitedInformationRequestModel,
      this.representativeContactInformationModel,
      this.url);

  @override
  String toString() {
    return 'MedicalFormModel{healthCareContactInformationModel: $healthCareContactInformationModel, unsolicitedInformationRequestModel: $unsolicitedInformationRequestModel, representativeContactInformationModel: $representativeContactInformationModel}';
  }

  factory MedicalFormModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalFormModelFromJson(json);
  Map<String, dynamic> toJson() => _$MedicalFormModelToJson(this);
}
