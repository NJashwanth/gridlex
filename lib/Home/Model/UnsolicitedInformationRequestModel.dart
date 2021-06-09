import 'package:json_annotation/json_annotation.dart';

part 'UnsolicitedInformationRequestModel.g.dart';

@JsonSerializable()
class UnsolicitedInformationRequestModel {
  List<String> product;
  String requestDescription;
  String inquiry;
  String patientName;
  String dob;
  String gender;
  String dateOfRequest;
  List<String> preferredMethodOfResponse;

  UnsolicitedInformationRequestModel(
      this.product,
      this.requestDescription,
      this.inquiry,
      this.patientName,
      this.dob,
      this.gender,
      this.dateOfRequest,
      this.preferredMethodOfResponse);

  @override
  String toString() {
    return 'UnsolicitedInformationRequestModel{product: $product, requestDescription: $requestDescription, inquiry: $inquiry, patientName: $patientName, dob: $dob, gender: $gender, dateOfRequest: $dateOfRequest, preferredMethodOfResponse: $preferredMethodOfResponse}';
  }

  factory UnsolicitedInformationRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$UnsolicitedInformationRequestModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UnsolicitedInformationRequestModelToJson(this);
}
