import 'package:beaty_app/domain/models/photo.dart';
import 'package:equatable/equatable.dart';

enum PhotosStatus { initial, loading, success, failed }

class PhotosState extends Equatable {
  const PhotosState({
    this.photos = const <Photo>[],
    this.isMax = false,
    this.status = PhotosStatus.initial,
  });

  final List<Photo> photos;
  final bool isMax;
  final PhotosStatus status;

  PhotosState copyWith({
    List<Photo>? photos,
    bool? isMax,
    PhotosStatus? status,
  }) {
    return PhotosState(
      photos: photos ?? this.photos,
      isMax: isMax ?? this.isMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [photos, isMax, status];
}

class PostState extends Equatable {
  const PostState({
    this.photo,
    required this.id,
  });

  PostState copyWith({
    Photo? photo,
    int? id,
  }) {
    return PostState(
      photo: photo,
      id: id ?? this.id,
    );
  }

  final Photo? photo;
  final int id;

  @override
  List<Object?> get props => [id, photo];
}
