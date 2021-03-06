import 'package:connectivity/connectivity.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class SmsService{

  Future<bool> _checkInternetConnection() async {
    var connection = await Connectivity().checkConnectivity();

    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> sendMessage(String time,String date)async{
    if(time.length==0 || date.length==0){
      return 'Please fill all the fields';
    }
    else if (await _checkInternetConnection()) {
      var url = Uri.parse('https://aws-pinpoint-service-aditi.herokuapp.com/?time=$time&date=$date');
      var response = await http.get(url);
      Map<String,dynamic> row1 = convert.jsonDecode(response.body);
      if (row1['error']!=null) {
        return 'Oops! error occurred';
      }else{
        return 'Message successfully sent';
      }
    }else{
      return 'Sorry! no internet connection';
    }
  }

}