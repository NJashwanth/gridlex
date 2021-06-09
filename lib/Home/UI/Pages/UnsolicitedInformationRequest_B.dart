import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:gridlex_assessment/Home/BLOC/HomeBloc.dart';
import 'package:gridlex_assessment/Home/Model/UnsolicitedInformationRequestModel.dart';
import 'package:gridlex_assessment/Home/UI/Pages/RepresentiveContactInformation_C.dart';
import 'package:gridlex_assessment/Utils/Utils.dart';

class UnsolicitedInformationRequestPage extends StatefulWidget {
  const UnsolicitedInformationRequestPage({Key? key}) : super(key: key);

  @override
  _UnsolicitedInformationRequestPageState createState() =>
      _UnsolicitedInformationRequestPageState();
}

class _UnsolicitedInformationRequestPageState
    extends State<UnsolicitedInformationRequestPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController requestDescriptionController =
      new TextEditingController();
  TextEditingController patientNameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController dateOfRequestController = new TextEditingController();
  final _sign = GlobalKey<SignatureState>();

  @override
  void dispose() {
    super.dispose();
    selectedProducts = null;
    selectedResponseMethods = null;
    disposeControllers();
    _bloc!.disposeBSectionRelatedStreamsInBloc();
  }

  void disposeControllers() {
    requestDescriptionController.dispose();
    patientNameController.dispose();
    dobController.dispose();
    dateOfRequestController.dispose();
  }

  List<String>? selectedProducts;
  List<String>? selectedResponseMethods;
  String selectedGender = "Male";
  String selectedInquiry = "";
  HomeBloc? _bloc = HomeBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      appBar: getAppBar(""),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getMainHeadingText("B.Unsolicited Information request :"),
            buildForm(),
            getSignaturePad(),
            getSubmitButton(navigateToC),
          ],
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: buildChildren(),
        ));
  }

  List<Widget> buildChildren() {
    return [
      buildProductsWidget(),
      getTextFormField(
          requestDescriptionController, "Request Description", "Description",
          validationType: 1),
      getInquiryWidget(),
      getTextFormField(patientNameController, "Patient Name*", "Patient Name",
          validationType: 1),
      getDateField(dobController, "DOB*"),
      getGenderWidget(),
      getDateField(
        dateOfRequestController,
        "Date of Request*",
      ),
      buildResponseMethodsWidget(),
    ];
  }

  Widget buildProductsWidget() {
    List<Widget> productsList = getProductsList();

    return Column(
      children: [
        getHeadingText("Choose Products*"),
        Row(children: productsList),
      ],
    );
  }

  List<Widget> getProductsList() {
    List<Widget> listToReturn = [];
    for (String product in products) {
      Widget widget = buildProductCheckBoxWidget(product);
      listToReturn.add(widget);
    }
    return listToReturn;
  }

  Widget buildProductCheckBoxWidget(String product) {
    return StreamBuilder<List<String>?>(
        stream: _bloc!.selectedProductsListStream,
        initialData: [],
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: buildRowForProductCheckBox(snapshot, product),
          );
        });
  }

  Row buildRowForProductCheckBox(
      AsyncSnapshot<List<String>?> snapshot, String product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [buildCheckbox(snapshot, product), Text(product)],
    );
  }

  Checkbox buildCheckbox(
      AsyncSnapshot<List<String>?> snapshot, String product) {
    return Checkbox(
      onChanged: (value) {
        onProductCheckBoxChanges(snapshot, value!, product);
      },
      value: snapshot.data!.contains(product),
    );
  }

  void onProductCheckBoxChanges(
      AsyncSnapshot<List<String>?> snapshot, bool value, String product) {
    selectedProducts = snapshot.data;

    !value ? selectedProducts!.remove(product) : selectedProducts!.add(product);
    print(selectedProducts);
    _bloc!.updateSelectedProductsStream(selectedProducts);
  }

  Widget getInquiryWidget() {
    return Column(
      children: [
        getHeadingText("Choose one"),
        radioButtonForInquiry(
            "This Inquiry does not represent an adverse event experienced by a patient"),
        radioButtonForInquiry(
            "This Inquiry represent an adverse event experienced by a patient"),
      ],
    );
  }

  Widget radioButtonForInquiry(String value) {
    return StreamBuilder<String>(
        stream: _bloc!.inquiryStream,
        initialData: "",
        builder: (context, snapshot) {
          return getRadioButtonForInquiry(value, snapshot.data!);
        });
  }

  Widget getRadioButtonForInquiry(String value, String groupValue) {
    return Row(
      children: [
        Radio<String>(
          onChanged: (value) {
            _bloc!.updateInquiry(value!);
            selectedInquiry = value;
          },
          groupValue: groupValue,
          value: value,
        ),
        Flexible(child: Text(value, softWrap: true))
      ],
    );
  }

  Widget getGenderWidget() {
    return Column(
      children: [
        getHeadingText("Gender*"),
        radioButtonForGender("Male"),
        radioButtonForGender("Female"),
        radioButtonForGender("Other"),
      ],
    );
  }

  Widget radioButtonForGender(String value) {
    return StreamBuilder<String>(
        stream: _bloc!.genderStream,
        initialData: "Male",
        builder: (context, snapshot) {
          return getRadioButtonForGender(value, snapshot.data!);
        });
  }

  Widget getRadioButtonForGender(String value, String groupValue) {
    return Row(
      children: [
        Radio<String>(
          onChanged: (value) {
            _bloc!.updateGender(value!);
            selectedGender = value;
          },
          groupValue: groupValue,
          value: value,
        ),
        Text(value)
      ],
    );
  }

  Widget buildResponseMethodsWidget() {
    List<Widget> responseMethodsList = getResponseMethodsList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHeadingText("Preferred Method of Response"),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: responseMethodsList),
      ],
    );
  }

  List<Widget> getResponseMethodsList() {
    List<Widget> listToReturn = [];
    for (String responseMethod in methodsOfResponse) {
      Widget widget = buildResponseCheckBoxWidget(responseMethod);
      listToReturn.add(widget);
    }
    return listToReturn;
  }

  Widget buildResponseCheckBoxWidget(String product) {
    return StreamBuilder<List<String>?>(
        stream: _bloc!.selectedResponseMethodsListStream,
        initialData: [],
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: buildRowForResponse(snapshot, product),
          );
        });
  }

  Row buildRowForResponse(
      AsyncSnapshot<List<String>?> snapshot, String product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildCheckboxForResponseMethods(snapshot, product),
        Text(product)
      ],
    );
  }

  Checkbox buildCheckboxForResponseMethods(
      AsyncSnapshot<List<String>?> snapshot, String product) {
    return Checkbox(
      onChanged: (value) {
        onResponseMethodCheckBoxChanges(snapshot, value!, product);
      },
      value: snapshot.data!.contains(product),
    );
  }

  void onResponseMethodCheckBoxChanges(
      AsyncSnapshot<List<String>?> snapshot, bool value, String product) {
    selectedResponseMethods = snapshot.data!;

    !value
        ? selectedResponseMethods!.remove(product)
        : selectedResponseMethods!.add(product);
    _bloc!.updateSelectedResponseMethods(selectedResponseMethods);
  }

  void navigateToC() {
    if (_sign.currentState!.points.length > 0 &&
        (selectedProducts != null && selectedProducts!.length > 0)) {
      if (_formKey.currentState!.validate()) {
        getImageFromSignature();
        UnsolicitedInformationRequestModel unsolicitedInformationRequestModel =
            getUnsolicitedInformationRequestModel();
        print(unsolicitedInformationRequestModel);
        _bloc!.updateUnsolicitedValueInBloc(unsolicitedInformationRequestModel);
        navigateTo(this.context, RepresentativeContactInformationPage());
      }
    } else
      getSnackBar(context, "Please Provide all mandatory fields to continue");
  }

  UnsolicitedInformationRequestModel getUnsolicitedInformationRequestModel() {
    print("Selected Products= $selectedProducts");
    print("Selected Inquiry= $selectedInquiry");
    print("Selected products= $selectedResponseMethods");
    return UnsolicitedInformationRequestModel(
        selectedProducts ?? [],
        requestDescriptionController.text,
        selectedInquiry,
        patientNameController.text,
        dobController.text,
        selectedGender,
        dateOfRequestController.text,
        selectedResponseMethods ?? []);
  }

  Widget getSignaturePad() {
    return Column(
      children: [
        getHeadingText("Health Care Professional's Signature*"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildSignCard(),
            ),
          ),
        ),
      ],
    );
  }

  Card buildSignCard() {
    return Card(
      child: Signature(
          color: Colors.black,
          strokeWidth: 5.0,
          onSign: () {
            final sign = _sign.currentState;
            debugPrint('${sign!.points.length} points in the signature');
          },
          key: _sign),
    );
  }

  Future<void> getImageFromSignature() async {
    final sign = _sign.currentState;
    final image = await sign!.getData();
    var data = await image.toByteData(format: ui.ImageByteFormat.png);
    sign.clear();
    final encoded = base64.encode(data!.buffer.asUint8List());
    _bloc!.imageBase64Data = encoded;
  }
}
