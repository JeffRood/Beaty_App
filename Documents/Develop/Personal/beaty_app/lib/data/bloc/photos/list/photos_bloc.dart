import 'package:beaty_app/data/base_api.dart';
import 'package:beaty_app/data/bloc/photos/list/photos_event.dart';
import 'package:beaty_app/data/bloc/photos/list/photos_state.dart';
import 'package:beaty_app/domain/models/photo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  PhotosBloc() : super(const PhotosState()) {
    on<PhotosRequested>(_onPhotosRequested);
  }

  final BaseApi _api = BaseApi();

  Future<void> _onPhotosRequested(
    PhotosRequested event,
    Emitter<PhotosState> emit,
  ) async {
    emit(state.copyWith(status: PhotosStatus.loading));
    final List<Photo> photos = (await _api.getHTTP('photo')) as List<Photo>;
    emit(state.copyWith(status: PhotosStatus.success, photos: photos));
  }
}
