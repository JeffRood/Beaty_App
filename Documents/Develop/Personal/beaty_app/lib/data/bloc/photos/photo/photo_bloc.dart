import 'package:beaty_app/data/base_api.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_event.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_state.dart';
import 'package:beaty_app/domain/models/photo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    final Photo post = (await _api.getHTTP('photo/${event.id}')) as Photo;
    emit(state.copyWith(status: PhotoStatus.success, photo: post));
  }
}
