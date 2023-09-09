// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_item_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilmItemTypeAdapter extends TypeAdapter<FilmItemType> {
  @override
  final int typeId = 0;

  @override
  FilmItemType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilmItemType(
      isWatched: fields[0] as bool,
      title: fields[1] as String,
      rate: fields[2] as int,
      createTime: fields[3] as DateTime?,
      watchedTime: fields[4] as DateTime?,
      comment: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FilmItemType obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isWatched)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.rate)
      ..writeByte(3)
      ..write(obj.createTime)
      ..writeByte(4)
      ..write(obj.watchedTime)
      ..writeByte(5)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserThemeDataTypeAdapter extends TypeAdapter<UserThemeDataType> {
  @override
  final int typeId = 1;

  @override
  UserThemeDataType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserThemeDataType(
      color: fields[0] as int,
      isDarkMode: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserThemeDataType obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.color)
      ..writeByte(1)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserThemeDataTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}