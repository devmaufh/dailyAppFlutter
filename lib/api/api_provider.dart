import 'dart:convert';

import 'package:daily_pick/bloc/foto_bloc.dart';
import 'package:daily_pick/models/NasaPic.dart';
import 'package:daily_pick/utils/consts.dart';
import 'package:http/http.dart' as http;
class ApiProvider {
  static final ApiProvider _apiProvider = new ApiProvider._internal();
  factory ApiProvider() {
    return _apiProvider;
  }
  ApiProvider._internal();
  Future<FotoModel> getDailyPick()async{
    var request = await http.get("${Consts.endPoing}${Consts.key}");
    if(request.statusCode == 200|| request.statusCode == 201){
      var response = json.decode(request.body);
      FotoBloc().insertIntoFoto(FotoModel.fromJson(response));
      return FotoModel.fromJson(response);
    }
    return null;
  }
}