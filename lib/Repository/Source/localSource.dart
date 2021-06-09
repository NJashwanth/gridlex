import 'package:gridlex_assessment/Home/Model/MedicalFormModel.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class LocalSource {
  static LocalSource? instance;

  static LocalSource? getInstance() {
    if (instance == null) {
      instance = new LocalSource();
    }
    return instance;
  }

  LocalSource() {
    print("Constructor for Local Storage");
  }

  Future<List> getDataFromLocal() async {
    return getFormDataInLocal();
  }

  List getFormDataInLocal() {
    print("getFormDataInLocal");
    return Hive.box("tempFormData").values.toList();
  }

  Future<Map<String, dynamic>> addFormData(
      MedicalFormModel medicalFormModel) async {
    try {
      int result =
          await Hive.box("tempFormData").add(medicalFormModel.toJson());
      return result != -1
          ? {"isSuccess": true, "directory": "local"}
          : {"isSuccess": false};
    } catch (e) {
      print("Error in addFormData to local = $e");
      return {"isSuccess": false};
    }
  }

  void clearData() {
    print("Clear Data");
    Hive.box('tempFormData').clear();
  }
}