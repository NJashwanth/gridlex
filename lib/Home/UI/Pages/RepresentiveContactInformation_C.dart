import 'package:flutter/material.dart';
import 'package:gridlex_assessment/Home/BLOC/HomeBloc.dart';
import 'package:gridlex_assessment/Home/Model/RepresentativeContactInformationModel.dart';
import 'package:gridlex_assessment/Home/UI/Screens/ActionsSuccessfullScreen.dart';
import 'package:gridlex_assessment/Utils/Packages/Progress_Dialog.dart';
import 'package:gridlex_assessment/Utils/Utils.dart';

class RepresentativeContactInformationPage extends StatefulWidget {
  const RepresentativeContactInformationPage({Key? key}) : super(key: key);

  @override
  _RepresentativeContactInformationPageState createState() =>
      _RepresentativeContactInformationPageState();
}

class _RepresentativeContactInformationPageState
    extends State<RepresentativeContactInformationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController representativeNameController =
      new TextEditingController(text: "Representative Name");
  TextEditingController representativeTypeController =
      new TextEditingController(text: "Representative Type");
  TextEditingController representativeTerritoryController =
      new TextEditingController(text: "Representative Territory");
  TextEditingController countryCodeController =
      new TextEditingController(text: "+91");
  TextEditingController primaryNumberController =
      new TextEditingController(text: "8178563334");
  HomeBloc? _bloc = HomeBloc.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      appBar: getAppBar(""),
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  void disposeControllers() {
    representativeNameController.dispose();
    representativeTypeController.dispose();
    representativeTerritoryController.dispose();
    countryCodeController.dispose();
    primaryNumberController.dispose();
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          getMainHeadingText("C.Representative Contact Information :"),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: buildChildren(),
                  )),
            ),
          ),
          getSubmitButton(submit),
        ],
      ),
    );
  }

  List<Widget> buildChildren() {
    return [
      getTextForDeclaration(),
      getTextFormField(representativeNameController, "Representative Name*",
          "Representative Name",
          validationType: 1),
      getTextFormField(representativeTypeController, "Representative Type*",
          "Representative Type",
          validationType: 1),
      getTextFormField(representativeTerritoryController,
          "Representative Territory Number*", "Representative Territory Number",
          validationType: 1),
      getTextFormField(countryCodeController, "Country Code", "Country Code",
          validationType: 6),
      getTextFormField(primaryNumberController, "Primary Telephone Number",
          "Telephone Number",
          validationType: 6, length: 10),
    ];
  }

  Widget getTextForDeclaration() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
          "By Submitting this form, I certify that is request for Information was initiated by Health Care Professional stated above, and was not solicited by me in any manner.",
          style: TextStyle(fontSize: 18)),
    );
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      RepresentativeContactInformationModel
          representativeContactInformationModel =
          getRepresentativeContactInformationModel();
      ProgressDialog dialog = new ProgressDialog(
        context,
        isDismissible: false,
        customBody: LinearProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          backgroundColor: Colors.white,
        ),
      );
      dialog.style(message: 'Please wait...');
      await dialog.show();

      Map<String, dynamic> mapFromServer = await _bloc!
          .updateRepresentativeValueInBloc(
              representativeContactInformationModel);
      await dialog.hide();
      if (mapFromServer['isSuccess']) {
        navigateToSuccess(mapFromServer);
      }
    }
  }

  RepresentativeContactInformationModel
      getRepresentativeContactInformationModel() {
    return RepresentativeContactInformationModel(
        representativeNameController.text,
        representativeTypeController.text,
        representativeTerritoryController.text,
        countryCodeController.text,
        primaryNumberController.text);
  }

  void navigateToSuccess(Map<String, dynamic> mapFromServer) {
    if (mapFromServer['directory'] == "remote") {
      navigateToSuccessScreen("Data Successfully Saved to Remote Server");
    } else
      navigateToSuccessScreen("Data Successfully Saved to Local Server");
  }

  void navigateToSuccessScreen(String message) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ActionSuccessful(message),
        ),
        (route) => false);
  }
}
