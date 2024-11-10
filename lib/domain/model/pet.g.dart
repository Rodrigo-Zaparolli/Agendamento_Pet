// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      id: json['id'] as String?,
      clientId: json['clientId'] as String,
      nome: json['nome'] as String,
      raca: json['raca'] as String,
      porte: json['porte'] as String,
      nascimento: DateTime.parse(json['nascimento'] as String),
      idade: json['idade'] as String,
      peso: json['peso'] as String,
      sexo: json['sexo'] as String,
      tipo: json['tipo'] as String,
      tutor: json['tutor'] as String,
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'nome': instance.nome,
      'raca': instance.raca,
      'porte': instance.porte,
      'nascimento': instance.nascimento.toIso8601String(),
      'idade': instance.idade,
      'peso': instance.peso,
      'sexo': instance.sexo,
      'tipo': instance.tipo,
      'tutor': instance.tutor,
    };
