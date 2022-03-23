import 'package:flutter/cupertino.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propFloresta/propFloresta_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propManejo/propManejo_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoFloresta/tipoFlorestaModel.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoManejo/tipoManejoModel.dart';

class DropDownControllerFloresta extends ChangeNotifier {
  
  List<TipoFlorestaModel> listTipoFloresta = [];
  TipoFlorestaModel? selecionadoTipoFloresta;

  Future buscarTipoFloresta() async {
    listTipoFloresta = await PropFlorestaAPI().getListTipoFloresta();

    notifyListeners();
  }

  void setSelecionadoTipoFloresta(selTipo){
    selecionadoTipoFloresta = selTipo;
    notifyListeners();
  }


}