import 'package:beaty_app/data/base_api.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_event.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_state.dart';
import 'package:beaty_app/domain/models/photo.dart';
import 'package:bloc/bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(const PhotoState()) {
    on<PhotoRequested>(_onPhotoRequested);
  }
  final BaseApi _api = BaseApi();

  Future<void> _onPhotoRequested(
    PhotoRequested event,
    Emitter<PhotoState> emit,
  ) async {
    emit(state.copyWith(status: PhotoStatus.loading));
    var response = await _api.getHTTP('photos/${event.id}');
    Photo post = Photo.fromJson(response.data);
    emit(state.copyWith(status: PhotoStatus.success, photo: post));
  }
}
