import 'package:flutter/cupertino.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';

class DropDownControllerPropriedades extends ChangeNotifier {
  
  List<PropriedadesModel> listPropriedades = [];
  PropriedadesModel? selecionadoPropriedades;

  Future buscarPropriedades() async {
    listPropriedades = await PropriedadesApi().getListPropriedades();

    notifyListeners();
  }

  void setSelecionadoPropriedades(selTipo){
    selecionadoPropriedades = selTipo;
    notifyListeners();
  }


}