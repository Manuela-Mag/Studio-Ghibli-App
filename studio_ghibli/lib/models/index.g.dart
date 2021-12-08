// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Movie$ _$$Movie$FromJson(Map<String, dynamic> json) => _$Movie$(
      id: json['id'] as String,
      title: json['title'] as String,
      release_date: json['release_date'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$Movie$ToJson(_$Movie$ instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'release_date': instance.release_date,
      'image': instance.image,
    };
