import 'package:agendamento_pet/domain/model/servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Agendamento {
  String? id;
  String petId;
  String userId;
  String petNome;
  String raca;
  String idade;
  String peso;
  String sexo;
  DateTime data;
  String hora;
  Servico servico;
  List<String> horariosOcupados;

  Agendamento({
    this.id,
    required this.petId,
    required this.userId,
    required this.petNome,
    required this.raca,
    required this.idade,
    required this.peso,
    required this.sexo,
    required this.data,
    required this.hora,
    required this.servico,
    List<String>? horariosOcupados,
  }) : horariosOcupados = horariosOcupados ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'petId': petId,
      'userId': userId,
      'petNome': petNome,
      'raca': raca,
      'idade': idade,
      'peso': peso,
      'sexo': sexo,
      'data': Timestamp.fromDate(data),
      'hora': hora,
      'servico': servico.toJson(),
      'horariosOcupados': horariosOcupados, // Inclui a nova lista no JSON
    };
  }

  factory Agendamento.fromMap(Map<String, dynamic> data) {
    return Agendamento(
      id: data['id'],
      petId: data['petId'] ?? '',
      userId: data['userId'] ?? '',
      petNome: data['petNome'] ?? '',
      raca: data['raca'] ?? '',
      idade: data['idade'] ?? '',
      peso: data['peso'] ?? '',
      sexo: data['sexo'] ?? '',
      data: (data['data'] as Timestamp?)?.toDate() ?? DateTime.now(),
      hora: data['hora'] ?? '',
      servico: Servico.fromMap(data['servico'] ?? {}),
      horariosOcupados: List<String>.from(data['horariosOcupados'] ??
          []), // Converte a lista de horários ocupados do JSON
    );
  }

  factory Agendamento.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Agendamento(
      id: doc.id,
      petId: data['petId'] ?? '',
      userId: data['userId'] ?? '',
      petNome: data['petNome'] ?? '',
      raca: data['raca'] ?? '',
      idade: data['idade'] ?? '',
      peso: data['peso'] ?? '',
      sexo: data['sexo'] ?? '',
      data: (data['data'] as Timestamp?)?.toDate() ?? DateTime.now(),
      hora: data['hora'] ?? '',
      servico: Servico.fromMap(data['servico'] ?? {}),
      horariosOcupados: List<String>.from(data['horariosOcupados'] ?? []),
    );
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
