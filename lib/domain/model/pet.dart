import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pet.g.dart';

@JsonSerializable()
class Pet {
  String? id;
  String clientId;
  String nome;
  String raca;
  String porte;
  DateTime nascimento;
  String idade;
  String peso;
  String sexo;
  String tipo;
  String tutor;

  Pet({
    this.id,
    required this.clientId,
    required this.nome,
    required this.raca,
    required this.porte,
    required this.nascimento,
    required this.idade,
    required this.peso,
    required this.sexo,
    required this.tipo,
    required this.tutor,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);
  Map<String, dynamic> toJson() => _$PetToJson(this);

  factory Pet.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pet(
      id: doc.id,
      nome: data['nome'] ?? '',
      sexo: data['sexo'] ?? '',
      nascimento: data['nascimento'] is String
          ? DateTime.parse(data['nascimento'])
          : (data['nascimento'] as Timestamp).toDate(),
      raca: data['raca'] ?? '',
      porte: data['porte'] ?? '',
      idade: data['idade'] ?? '',
      peso: data['peso'] ?? '',
      tipo: data['tipo'] ?? '',
      tutor: data['tutor'] ?? '',
      clientId: data['clientId'] ?? '',
    );
  }
}
