// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      avatarUrl: json['avatar_url'] as String,
      login: json['login'] as String,
      followersUrl: json['followers_url'] as String,
      followingUrl: json['following_url'] as String,
      followers: (json['followers'] as num?)?.toInt() ?? 0,
      following: (json['following'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
      'login': instance.login,
      'followers_url': instance.followersUrl,
      'following_url': instance.followingUrl,
      'followers': instance.followers,
      'following': instance.following,
    };
