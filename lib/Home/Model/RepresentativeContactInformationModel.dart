import 'package:json_annotation/json_annotation.dart';

part 'RepresentativeContactInformationModel.g.dart';

@JsonSerializable()
class RepresentativeContactInformationModel {
  String representativeName;
  String representativeType;
  String territoryNumber;
  String countryCode;
  String telephoneNumber;

  RepresentativeContactInformationModel(
      this.representativeName,
      this.representativeType,
      this.territoryNumber,
      this.countryCode,
      this.telephoneNumber);

  @override
  String toString() {
    return 'RepresentativeContactInformationModel{representativeName: $representativeName, representativeType: $representativeType, territoryNumber: $territoryNumber, countryCode: $countryCode, telephoneNumber: $telephoneNumber}';
  }

  factory RepresentativeContactInformationModel.fromJson(
          Map<String, dynamic> json) =>
      _$RepresentativeContactInformationModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RepresentativeContactInformationModelToJson(this);
}
