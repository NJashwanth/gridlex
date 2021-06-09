import 'dart:io';

import 'package:gridlex_assessment/Home/Model/HealthCareContactInformationModel.dart';
import 'package:gridlex_assessment/Home/Model/MedicalFormModel.dart';
import 'package:gridlex_assessment/Home/Model/RepresentativeContactInformationModel.dart';
import 'package:gridlex_assessment/Home/Model/StatesDropDown.dart';
import 'package:gridlex_assessment/Home/Model/UnsolicitedInformationRequestModel.dart';
import 'package:gridlex_assessment/Repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  Repository? _repo = Repository.getInstance();
  static HomeBloc? _instance;

  String? imageBase64Data;

  File? image;

  static HomeBloc? getInstance() {
    if (_instance == null) _instance = new HomeBloc();
    return _instance;
  }

  // ignore: unused_field
  HealthCareContactInformationModel? _contactInformationModel;
  RepresentativeContactInformationModel? _representativeContactInformationModel;
  UnsolicitedInformationRequestModel? _unsolicitedInformationRequestModel;

  // ignore: close_sinks
  BehaviorSubject<String> _designationController =
      new BehaviorSubject<String>();
  Stream<String> get designationStream => _designationController.stream;

  // ignore: close_sinks
  BehaviorSubject<String> _inquiryController = new BehaviorSubject<String>();
  Stream<String> get inquiryStream => _inquiryController.stream;

  // ignore: close_sinks
  BehaviorSubject<String> _genderController = new BehaviorSubject<String>();
  Stream<String> get genderStream => _genderController.stream;

  BehaviorSubject<List<String>?> _selectedProductListController =
      new BehaviorSubject<List<String>?>();

  Stream<List<String>?> get selectedProductsListStream =>
      _selectedProductListController.stream;

  // ignore: close_sinks
  BehaviorSubject<List<String>?> _selectedResponseMethodsListController =
      new BehaviorSubject<List<String>?>();

  Stream<List<String>?> get selectedResponseMethodsListStream =>
      _selectedResponseMethodsListController.stream;

  BehaviorSubject<StatesDropDown?> _selectedStateController =
      new BehaviorSubject<StatesDropDown?>();

  Stream<StatesDropDown?> get selectedStateStream =>
      _selectedStateController.stream;

  void updateDesignation(String value) {
    _designationController.add(value);
  }

  void updateSelectedProductsStream(List<String>? selectedProducts) {
    _selectedProductListController.add(selectedProducts);
  }

  void updateSelectedResponseMethods(List<String>? selectedResponseMethods) {
    _selectedResponseMethodsListController.add(selectedResponseMethods);
  }

  void updateInquiry(String value) {
    _inquiryController.add(value);
  }

  void updateGender(String value) {
    _genderController.add(value);
  }

  void setStateData(StatesDropDown value) {
    _selectedStateController.add(value);
  }

  void updateHealthCareValueInBloc(
      HealthCareContactInformationModel healthCareContactInformationModel) {
    _contactInformationModel = healthCareContactInformationModel;
  }

  void updateUnsolicitedValueInBloc(
      UnsolicitedInformationRequestModel unsolicitedInformationRequestModel) {
    _unsolicitedInformationRequestModel = unsolicitedInformationRequestModel;
  }

  Future<Map<String, dynamic>> updateRepresentativeValueInBloc(
      RepresentativeContactInformationModel
          representativeContactInformationModel) async {
    this._representativeContactInformationModel =
        representativeContactInformationModel;
    return await sendDataToServer();
  }

  Future<Map<String, dynamic>> sendDataToServer() async {
    MedicalFormModel model = MedicalFormModel(
        this._contactInformationModel!,
        this._unsolicitedInformationRequestModel!,
        this._representativeContactInformationModel!,
        imageBase64Data ?? "NA");
    return await _repo!.sendDataToServer(model);
  }

  Future<Map<String, dynamic>> checkForDataInLocalServer() async {
    return await _repo!.getDataFromServer();
  }

  void disposeASectionRelatedStreamsInBloc() {
    _designationController.close();
    _selectedStateController.close();
  }

  void disposeBSectionRelatedStreamsInBloc() {
    _selectedProductListController.close();
    _inquiryController.close();
    _genderController.close();
    _selectedResponseMethodsListController.close();
  }
}
