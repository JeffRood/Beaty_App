import 'package:beaty_app/domain/models/photo.dart';
import 'package:equatable/equatable.dart';

enum PhotoStatus { initial, loading, success, failed }

class PhotoState extends Equatable {
  const PhotoState({
    this.photo,
    this.id,
    this.status = PhotoStatus.initial,
  });

  PhotoState copyWith({
    Photo? photo,
    int? id,
    PhotoStatus? status,
  }) {
    return PhotoState(
      photo: photo,
      id: id,
      status: status ?? this.status,
    );
  }

  // Mark as nullable for some situation where a post
  // cannot be load
  final Photo? photo;
  final int? id;
  final PhotoStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [id, photo, status];
}
