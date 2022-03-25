import 'package:flutter/cupertino.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_api.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';

class DropDownControllerEntidades extends ChangeNotifier {
  
  List<EntidadesModel> listEntidades = [];
  EntidadesModel? selecionadoEntidades;

  Future buscarEntidades() async {
    listEntidades = await EntidadesApi().getListEntidades();

    notifyListeners();
  }

  void setSelecionadoEntidades(selTipo){
    selecionadoEntidades = selTipo;
    notifyListeners();
  }


}