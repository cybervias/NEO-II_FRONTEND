import 'package:flutter/cupertino.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propManejo/propManejo_api.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/tipoManejo/tipoManejoModel.dart';

class DropDownController extends ChangeNotifier {
  
  List<TipoManejoModel> listTipoManejo = [];
  TipoManejoModel? selecionadoTipoManejo;

  Future buscarTipoManejo() async {
    listTipoManejo = await PropManejoApi().getListTipoManejo();

    notifyListeners();
  }

  void setSelecionadoTipoManejo(selTipo){
    selecionadoTipoManejo = selTipo;
    notifyListeners();
  }


}