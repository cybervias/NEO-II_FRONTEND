import 'dart:convert';

class TipoFlorestaModel {
  int? ID;
  String? Descricao;
  TipoFlorestaModel({
    this.ID,
    this.Descricao,
  });

  TipoFlorestaModel copyWith({
    int? ID,
    String? Descricao,
  }) {
    return TipoFlorestaModel(
      ID: ID ?? this.ID,
      Descricao: Descricao ?? this.Descricao,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(ID != null){
      result.addAll({'ID': ID});
    }
    if(Descricao != null){
      result.addAll({'Descricao': Descricao});
    }
  
    return result;
  }

  factory TipoFlorestaModel.fromMap(Map<String, dynamic> map) {
    return TipoFlorestaModel(
      ID: map['ID']?.toInt(),
      Descricao: map['Descricao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoFlorestaModel.fromJson(String source) => TipoFlorestaModel.fromMap(json.decode(source));

  @override
  String toString() => 'TipoFlorestaModel(ID: $ID, Descricao: $Descricao)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TipoFlorestaModel &&
      other.ID == ID &&
      other.Descricao == Descricao;
  }

  @override
  int get hashCode => ID.hashCode ^ Descricao.hashCode;
}
