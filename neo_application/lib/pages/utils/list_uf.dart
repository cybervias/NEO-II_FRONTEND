import 'package:flutter/cupertino.dart';

class Uf extends ChangeNotifier{
  String ufSelecionada = ""; 
  String? sigla;
  late List<Uf>? ufs;
  Uf({this.sigla, this.ufs});

  void setSelecionadoUf(selTipo){
    ufSelecionada = selTipo;
    notifyListeners();
  }

  listUfs() {
    List<String> ufs = [
      "",
      "AC",
      "AL",
      "AP",
      "AM",
      "BA",
      "CE",
      "DF",
      "ES",
      "GO",
      "MA",
      "MT",
      "MS",
      "MG",
      "PA",
      "PB",
      "PR",
      "PE",
      "PI",
      "RJ",
      "RN",
      "RS",
      "RO",
      "RR",
      "SC",
      "SP",
      "SE",
      "TO",
    ];
    return ufs;
  }
}
