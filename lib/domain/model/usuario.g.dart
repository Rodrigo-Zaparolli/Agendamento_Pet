// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoURL: json['photoURL'] as String?,
      cpf: json['cpf'] as String?,
      birthDate: json['birthDate'] as String?,
      phone: json['phone'] as String?,
      cep: json['cep'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoURL': instance.photoURL,
      'cpf': instance.cpf,
      'birthDate': instance.birthDate,
      'phone': instance.phone,
      'cep': instance.cep,
      'state': instance.state,
      'city': instance.city,
    };
