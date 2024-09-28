// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedModelAdapter extends TypeAdapter<FeedModel> {
  @override
  final int typeId = 0;

  @override
  FeedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedModel(
      id: fields[0] as int,
      title: fields[1] as String,
      body: fields[2] as String,
      userId: fields[3] as int,
      userImage: fields[4] as String?,
      feedImage: fields[5] as String?,
      isLike: fields[6] as bool?,
      comments: (fields[7] as List?)?.cast<CommentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FeedModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.userImage)
      ..writeByte(5)
      ..write(obj.feedImage)
      ..writeByte(6)
      ..write(obj.isLike)
      ..writeByte(7)
      ..write(obj.comments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedModelImpl _$$FeedModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      userId: (json['userId'] as num).toInt(),
      userImage: json['userImage'] as String?,
      feedImage: json['feedImage'] as String?,
      isLike: json['isLike'] as bool?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FeedModelImplToJson(_$FeedModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'userId': instance.userId,
      'userImage': instance.userImage,
      'feedImage': instance.feedImage,
      'isLike': instance.isLike,
      'comments': instance.comments,
    };
