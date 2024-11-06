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
  DateTime? cancelledAt;
  String hora;
  String motivoCancel;
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
    this.cancelledAt,
    required this.hora,
    required this.motivoCancel,
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
      'cancelledAt': cancelledAt?.toIso8601String(),
      'hora': hora,
      'motivoCancel': motivoCancel,
      'servico': servico.toJson(),
      'horariosOcupados': horariosOcupados,
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
      cancelledAt: data['cancelledAt'] != null
          ? DateTime.parse(data['cancelledAt'])
          : null,
      sexo: data['sexo'] ?? '',
      data: (data['data'] as Timestamp?)?.toDate() ?? DateTime.now(),
      hora: data['hora'] ?? '',
      motivoCancel: data['motivoCancel'] ?? '',
      servico: Servico.fromMap(data['servico'] ?? {}),
      horariosOcupados: List<String>.from(data['horariosOcupados'] ?? []),
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
      motivoCancel: data['motivoCancel'] ?? '',
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
