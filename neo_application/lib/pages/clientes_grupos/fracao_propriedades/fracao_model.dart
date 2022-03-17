import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:javascript/javascript.dart';
import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';

class FracaoPropModel {
  int? ID;
  int? IDEntidade;
  var entidades;
  int? IDPropriedade;
  var propriedades;
  int? Fracao;

  FracaoPropModel({
    this.ID,
    this.IDEntidade,
    this.entidades,
    this.IDPropriedade,
    this.propriedades,
    this.Fracao,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'IDEntidade': IDEntidade,
      'entidades': entidades,
      'IDPropriedade': IDPropriedade,
      'propriedades': propriedades,
      'Fracao': Fracao,
    };
  }

  factory FracaoPropModel.fromMap(Map<String, dynamic> map) {
    return FracaoPropModel(
      ID: map['ID']?.toInt(),
      IDEntidade: map['IDEntidade']?.toInt(),
      entidades: map['entidades'],
      IDPropriedade: map['IDPropriedade']?.toInt(),
      propriedades: map['propriedades'],
      Fracao: map['Fracao']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FracaoPropModel.fromJson(String source) =>
      FracaoPropModel.fromMap(json.decode(source));
}
