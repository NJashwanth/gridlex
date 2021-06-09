import 'package:flutter/material.dart';
import 'package:gridlex_assessment/Home/BLOC/HomeBloc.dart';
import 'package:gridlex_assessment/Home/Model/HealthCareContactInformationModel.dart';
import 'package:gridlex_assessment/Home/Model/StatesDropDown.dart';
import 'package:gridlex_assessment/Home/UI/Pages/UnsolicitedInformationRequest_B.dart';
import 'package:gridlex_assessment/Utils/Utils.dart';

class HealthCareContactInformationPage extends StatefulWidget {
  const HealthCareContactInformationPage({Key? key}) : super(key: key);

  @override
  _HealthCareContactInformationPageState createState() =>
      _HealthCareContactInformationPageState();
}

class _HealthCareContactInformationPageState
    extends State<HealthCareContactInformationPage> {
  final _formKey = GlobalKey<FormState>();
  HomeBloc? _bloc = HomeBloc.getInstance();

  TextEditingController requestorFirstNameController =
      new TextEditingController(text: "First Name");
  TextEditingController requestorLastNameController =
      new TextEditingController(text: "Last Name");
  TextEditingController institutionNameController =
      new TextEditingController(text: "Institute Name");
  TextEditingController departmentController =
      new TextEditingController(text: "Department Name");
  TextEditingController addressLine1Controller =
      new TextEditingController(text: "Address 1");
  TextEditingController addressLine2Controller =
      new TextEditingController(text: "Address 2");

  TextEditingController cityController =
      new TextEditingController(text: "City Name");
  TextEditingController zipController =
      new TextEditingController(text: "500560");
  TextEditingController phoneNumberController =
      new TextEditingController(text: "8186855985");
  TextEditingController faxNumberController =
      new TextEditingController(text: "Fax number");
  TextEditingController emailController =
      new TextEditingController(text: "Email@email.com");
  List<DropdownMenuItem<StatesDropDown>>? statesMenuList;
  StatesDropDown? selectedState;
  String designation = "MD";

  void initState() {
    super.initState();
    statesMenuList = buildDropDownMenuItems(statesListForDropDown);
    selectedState = statesMenuList![0].value;
  }

  List<DropdownMenuItem<StatesDropDown>> buildDropDownMenuItems(
      List<StatesDropDown> listItems) {
    List<DropdownMenuItem<StatesDropDown>> items = [];
    for (StatesDropDown listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.stateName),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      appBar: getAppBar(""),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getMainHeadingText("A.Healthcare Professional Contact Information :"),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: buildChildren(),
                  )),
            ),
          ),
          getSubmitButton(navigateToB)
        ],
      ),
    );
  }

  List<Widget> buildChildren() {
    return [
      getTextFormField(requestorFirstNameController, "Requestor First Name*",
          "Requestor First Name",
          validationType: 1),
      getTextFormField(requestorLastNameController, "Requestor Last Name*",
          "Requestor Last Name",
          validationType: 1),
      getDesignationWidget(),
      getTextFormField(
          institutionNameController, "Institute/Office*", "Institute/Office",
          validationType: 1),
      getTextFormField(departmentController, "Department*", "Department",
          validationType: 1),
      getTextFormField(
          addressLine1Controller,
          "Institution/Office Address Line*",
          "Institution/Office Address Line 1",
          validationType: 1),
      getTextFormField(
          addressLine2Controller,
          "Institution/Office Address Line 2",
          "Institution/Office Address Line 2",
          validationType: 6),
      getStateSelectionDropDown(),
      getTextFormField(cityController, "City*", "City", validationType: 1),
      getTextFormField(zipController, "Zip*", "Zip", validationType: 5),
      getTextFormField(phoneNumberController, "Phone Number", "Phone Number",
          validationType: 6),
      getTextFormField(faxNumberController, "Fax Number", "Fax Number",
          validationType: 6),
      getTextFormField(emailController, "Email", "Email", validationType: 6),
    ];
  }

  Widget getDesignationWidget() {
    return Column(
      children: [
        getHeadingText("Designation*"),
        radioButtonForDesignation("MD"),
        radioButtonForDesignation("DO"),
        radioButtonForDesignation("NP"),
        radioButtonForDesignation("PA"),
      ],
    );
  }

  Widget radioButtonForDesignation(String value) {
    return StreamBuilder<String>(
        stream: _bloc!.designationStream,
        initialData: "MD",
        builder: (context, snapshot) {
          return getRadioButton(value, snapshot.data!);
        });
  }

  Widget getRadioButton(String value, String groupValue) {
    return Row(
      children: [
        Radio<String>(
          onChanged: (value) {
            _bloc!.updateDesignation(value!);
            designation = value;
          },
          groupValue: groupValue,
          value: value,
        ),
        Text(value)
      ],
    );
  }

  void navigateToB() {
    if (selectedState!.stateName != "State") {
      if (_formKey.currentState!.validate()) {
        HealthCareContactInformationModel healthCareContactInformationModel =
            getHealthCareContactDetails();
        _bloc!.updateHealthCareValueInBloc(healthCareContactInformationModel);
        navigateTo(this.context, UnsolicitedInformationRequestPage());
      }
    } else
      getSnackBar(context, "Please select State to Continue");
  }

  Widget getStateSelectionDropDown() {
    return StreamBuilder<StatesDropDown?>(
        stream: _bloc!.selectedStateStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              getHeadingText("State*"),
              buildDroopDownWidget(context, snapshot),
            ],
          );
        });
  }

  Padding buildDroopDownWidget(
      BuildContext context, AsyncSnapshot<StatesDropDown?> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black12, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: buildDropdownButton(snapshot),
        ),
      ),
    );
  }

  DropdownButton<StatesDropDown> buildDropdownButton(
      AsyncSnapshot<StatesDropDown?> snapshot) {
    return DropdownButton<StatesDropDown>(
        isExpanded: true,
        hint:
            Text("Select State", style: TextStyle(fontWeight: FontWeight.bold)),
        value: snapshot.data,
        items: statesMenuList,
        icon: Icon(Icons.arrow_drop_down),
        underline: Container(
          color: Colors.white,
        ),
        iconSize: 24,
        elevation: 16,
        onChanged: (value) {
          _bloc!.setStateData(value!);
          selectedState = value;
        });
  }

  HealthCareContactInformationModel getHealthCareContactDetails() {
    return new HealthCareContactInformationModel(
        requestorFirstNameController.text,
        requestorLastNameController.text,
        designation,
        institutionNameController.text,
        departmentController.text,
        addressLine1Controller.text,
        addressLine2Controller.text,
        selectedState!.stateName,
        cityController.text,
        zipController.text,
        phoneNumberController.text,
        faxNumberController.text,
        emailController.text);
  }
}
