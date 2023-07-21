// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticketPostBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketPostBody _$TicketPostBodyFromJson(Map<String, dynamic> json) =>
    TicketPostBody(
      individual: (json['individual'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      combos: (json['combos'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
    );

Map<String, dynamic> _$TicketPostBodyToJson(TicketPostBody instance) =>
    <String, dynamic>{
      'individual': instance.individual,
      'combos': instance.combos,
    };
