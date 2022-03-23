import 'dart:convert';

class TipoManejoModel {
  int? ID;
  String? Descricao;
  TipoManejoModel({
    this.ID,
    this.Descricao,
  });

  TipoManejoModel copyWith({
    int? ID,
    String? Descricao,
  }) {
    return TipoManejoModel(
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

  factory TipoManejoModel.fromMap(Map<String, dynamic> map) {
    return TipoManejoModel(
      ID: map['ID']?.toInt(),
      Descricao: map['Descricao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoManejoModel.fromJson(String source) => TipoManejoModel.fromMap(json.decode(source));

  @override
  String toString() => 'TipoManejoModel(ID: $ID, Descricao: $Descricao)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TipoManejoModel &&
      other.ID == ID &&
      other.Descricao == Descricao;
  }

  @override
  int get hashCode => ID.hashCode ^ Descricao.hashCode;
}
