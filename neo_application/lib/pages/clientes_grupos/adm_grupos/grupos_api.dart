import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:javascript/javascript.dart';
import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_model.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';

class EntidadesApi {
  List<EntidadesModel> list = [];
  Future<List<EntidadesModel>> getListEntidades() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/entidades");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((entidades) => EntidadesModel.fromMap(entidades))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }
}


class GruposApi {
  List<GruposModel> list = [];
  Future<List<GruposModel>> getListGrupos() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/grupos");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((grupos) => GruposModel.fromMap(grupos))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }

  /* late List<GruposApi>? listEntidades;
  Future<List<EntidadesModel>> getListEntidades() async {
    try {
      var url =
          Uri.parse("https://neo-ii-back-end.azurewebsites.net/entidades");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body) as List;

        return responseMap
            .map((entidades) => EntidadesModel.fromMap(entidades))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    throw "Erro ao carregar os dados";
  }*/

  Future updateGrupo(GruposModel oGrupo) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/grupos/update");

      var body = {
        "idGrupo": oGrupo.idGrupo,
        "Nome": oGrupo.Nome,
        "DataFormacao": oGrupo.DataFormacao,
        "IDGestor": oGrupo.IDGestor,
      };

      var response = await http.put(url,
          headers: <String, String>{"Content-type": "application/json"},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        Map<String, dynamic> map = {
          "type": res["type"],
          "message": res["message"]
        };
        return map;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  Future createGrupo(GruposModel oGrupo) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/grupos/create");

      var body = {
        "Nome": oGrupo.Nome,
        "DataFormacao": oGrupo.DataFormacao,
        "IDGestor": oGrupo.IDGestor,
      };

      var response = await http.post(url,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        Map<String, dynamic> map = {
          "type": res["type"],
          "message": res["message"]
        };
        return map;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  Future deleteGrupo(int idProp) async {
    try {
      var url = Uri.parse(
          "https://neo-ii-back-end.azurewebsites.net/grupos/delete/$idProp");

      var response = await http.delete(url);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        Map<String, dynamic> map = {
          "type": res["type"],
          "message": res["message"]
        };
        return map;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }
}
