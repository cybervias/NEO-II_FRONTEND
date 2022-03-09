import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:javascript/javascript.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';

class PropriedadesApi {
  List<PropriedadesModel> list = [];
  Future<List<PropriedadesModel>> getListPropriedades() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/propriedades");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((propriedades) => PropriedadesModel.fromMap(propriedades))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }

  Future updatePropriedade(PropriedadesModel oProp) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/propriedades/update");

      var body = {
        "idPropriedade": oProp.idPropriedade,
        "Nome": oProp.Nome,
        "CNPJ": oProp.CNPJ,
        "XCoord": oProp.XCoord,
        "yCoord": oProp.yCoord,
        "AreaPropriedade": oProp.AreaPropriedade,
        "AreaTotal": oProp.AreaTotal,
        "AreaPlantada": oProp.AreaPlantada,
        "AreaEstimaConservacao": oProp.AreaEstimaConservacao,
        "AreaInfraestrutura": oProp.AreaInfraestrutura,
        "AreaOutrosUsos": oProp.AreaOutrosUsos,
        "Localizacao": oProp.Localizacao,
        "UF": oProp.UF,
        "ID": oProp.ID
      };

      var response = await http.put(url,
          headers: <String, String>{"Content-type": "application/json"},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }
}
