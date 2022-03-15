import 'dart:convert';

import 'package:neo_application/pages/clientes_grupos/adm_grupos/grupos_model.dart';
import 'package:neo_application/pages/clientes_grupos/controle_escopo/controle_model.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';
import 'package:neo_application/pages/clientes_grupos/fracao_propriedades/fracao_model.dart';
import 'package:neo_application/pages/clientes_grupos/propriedades/propriedades_model.dart';

class TodasTabelasModel {
  List<EntidadesModel>? entidades;
  List<GruposModel>? grupos;
  List<PropriedadesModel>? propriedades;
  List<FracaoPropModel>? fracaoPropriedades;
  List<ControleModel>? controleEscopos;

  TodasTabelasModel({
    this.entidades,
    this.grupos,
    this.propriedades,
    this.fracaoPropriedades,
    this.controleEscopos,
  });

  Map<String, dynamic> toMap() {
    return {
      'entidades': entidades,
      'grupos': grupos,
      'propriedades': propriedades,
      'fracaoPropriedades': fracaoPropriedades,
      'controleEscopos': controleEscopos,
    };
  }

  factory TodasTabelasModel.fromMap(Map<String, dynamic> map) {
    return TodasTabelasModel(
      entidades: map['entidades'], //?.toInt(),
      grupos: map['grupos'],
      propriedades: map['propriedades'],
      fracaoPropriedades: map['fracaoPropriedades'],
      controleEscopos: map['controleEscopos'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodasTabelasModel.fromJson(String source) =>
      TodasTabelasModel.fromMap(json.decode(source));
}
