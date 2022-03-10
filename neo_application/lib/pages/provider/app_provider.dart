import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';
import 'package:neo_application/pages/default_page.dart';

class AppModel extends ChangeNotifier {
  late Widget page;
  List<PropriedadesModel> _listPropri = [];

  List<PropriedadesModel> get listProp => _listPropri;

  AppModel() {
    page = DefaultPage();
  }

  addItemList(List<PropriedadesModel> listProp) {
    listProp.forEach((item) {
      listProp.add(item);
    });
    notifyListeners();
  }

  setPage(Widget page) {
    this.page = page;

    notifyListeners();
  }

  setSelectedUf(String uf) {
    this.page = page;

    notifyListeners();
  }
}
