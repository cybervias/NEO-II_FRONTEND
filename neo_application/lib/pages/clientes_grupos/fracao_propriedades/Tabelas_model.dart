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
      'entidades': entidades?.map((x) => x.toMap()).toList(),
      'grupos': grupos?.map((x) => x.toMap()).toList(),
      'propriedades': propriedades?.map((x) => x.toMap()).toList(),
      'fracaoPropriedades': fracaoPropriedades?.map((x) => x.toMap()).toList(),
      'controleEscopos': controleEscopos?.map((x) => x.toMap()).toList(),
    };
  }

  factory TodasTabelasModel.fromMap(Map<String, dynamic> map) {
    return TodasTabelasModel(
      entidades: map['entidades'] != null
          ? List<EntidadesModel>.from(
              map['entidades']?.map((x) => EntidadesModel.fromMap(x)))
          : null,
      grupos: map['grupos'] != null
          ? List<GruposModel>.from(
              map['grupos']?.map((x) => GruposModel.fromMap(x)))
          : null,
      propriedades: map['propriedades'] != null
          ? List<PropriedadesModel>.from(
              map['propriedades']?.map((x) => PropriedadesModel.fromMap(x)))
          : null,
      fracaoPropriedades: map['fracaoPropriedades'] != null
          ? List<FracaoPropModel>.from(
              map['fracaoPropriedades']?.map((x) => FracaoPropModel.fromMap(x)))
          : null,
      controleEscopos: map['controleEscopos'] != null
          ? List<ControleModel>.from(
              map['controleEscopos']?.map((x) => ControleModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodasTabelasModel.fromJson(String source) =>
      TodasTabelasModel.fromMap(json.decode(source));
}