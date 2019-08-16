import 'dart:async';

import 'package:daily_pick/db/db_provider.dart';
import 'package:daily_pick/models/NasaPic.dart';

class FotoBloc{
  static final FotoBloc _singleton= new FotoBloc._internal();
  factory FotoBloc(){
    return _singleton;
  }
  final _fotoController=StreamController<List<FotoModel>>.broadcast();

  Stream<List<FotoModel>> get fotoStream => _fotoController.stream;
  FotoBloc._internal(){
    getNasaFotos();
  }
  dispose(){
    _fotoController?.close();
  }

  getNasaFotos()async{
    _fotoController.sink.add( await DBProvider.db.getFotos() );
  }
  insertIntoFoto( FotoModel model )async{
    var res = await DBProvider.db.insertFoto(model);
    return res;
  }
  deleteFromFotoById( int claveFoto )async{
    var res = await DBProvider.db.deleteFoto(claveFoto);
    return res;
  }
  Future<List<FotoModel>> selectAllFotos()async{
    var res = await DBProvider.db.getFotos();
    return res;
  }

}