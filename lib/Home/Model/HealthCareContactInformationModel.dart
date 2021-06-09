import 'package:json_annotation/json_annotation.dart';

part 'HealthCareContactInformationModel.g.dart';

@JsonSerializable()
class HealthCareContactInformationModel {
  String requestorFirstName;
  String requestorLastName;
  String designation;
  String institutionName;
  String department;
  String addressLine1;
  String addressLine2;
  String state;
  String city;
  String zip;
  String phoneNumber;
  String faxNumber;
  String email;

  HealthCareContactInformationModel(
      this.requestorFirstName,
      this.requestorLastName,
      this.designation,
      this.institutionName,
      this.department,
      this.addressLine1,
      this.addressLine2,
      this.state,
      this.city,
      this.zip,
      this.phoneNumber,
      this.faxNumber,
      this.email);

  @override
  String toString() {
    return 'HealthCareContactInformationModel{requestorFirstName: $requestorFirstName, requestorLastName: $requestorLastName, designation: $designation, institutionName: $institutionName, department: $department, addressLine1: $addressLine1, addressLine2: $addressLine2, state: $state, city: $city, zip: $zip, phoneNumber: $phoneNumber, faxNumber: $faxNumber, email: $email}';
  }

  factory HealthCareContactInformationModel.fromJson(
          Map<String, dynamic> json) =>
      _$HealthCareContactInformationModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$HealthCareContactInformationModelToJson(this);
}
