import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gridlex_assessment/Home/BLOC/HomeBloc.dart';
import 'package:gridlex_assessment/Utils/Utils.dart';

import 'Pages/HealthCareProfessionalContactInformation_A.dart';
import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Connectivity _connectivity = Connectivity();
  HomeBloc? _bloc = HomeBloc.getInstance();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  Widget build(BuildContext context) {
    return HealthCareContactInformationPage();
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult event) {
    switch (event) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        getSnackBar(context, "Detected Network change");
        getSnackBar(context, "Checking for Data in local Storage");
        checkStatus();
        break;

      default:
        print("No connection");
        break;
    }
  }

  Future<void> checkStatus() async {
    Map<String, dynamic> mapFromServer =
        await _bloc!.checkForDataInLocalServer();
    getSnackBar(context, mapFromServer['message']);
  }
}
