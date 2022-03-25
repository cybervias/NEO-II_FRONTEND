import 'dart:convert';

import 'package:neo_application/pages/clientes_grupos/entidades_gestoras/entidades_model.dart';

class GruposModel {
  int? idGrupo;
  String? Nome;
  String? DataFormacao;
  int? IDGestor;
  EntidadesModel? gestor;

  GruposModel({
    this.idGrupo,
    this.Nome,
    this.DataFormacao,
    this.IDGestor,
    this.gestor,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(idGrupo != null){
      result.addAll({'idGrupo': idGrupo});
    }
    if(Nome != null){
      result.addAll({'Nome': Nome});
    }
    if(DataFormacao != null){
      result.addAll({'DataFormacao': DataFormacao});
    }
    if(IDGestor != null){
      result.addAll({'IDGestor': IDGestor});
    }
    if(gestor != null){
      result.addAll({'gestor': gestor!.toMap()});
    }
  
    return result;
  }

  factory GruposModel.fromMap(Map<String, dynamic> map) {
    return GruposModel(
      idGrupo: map['idGrupo']?.toInt(),
      Nome: map['Nome'],
      DataFormacao: map['DataFormacao'],
      IDGestor: map['IDGestor']?.toInt(),
      gestor: map['gestor'] != null ? EntidadesModel.fromMap(map['gestor']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GruposModel.fromJson(String source) => GruposModel.fromMap(json.decode(source));
  }
