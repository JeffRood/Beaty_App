import 'dart:developer';
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
    var response = await _api.getHTTP('photos');
    Iterable list = response.data;
    var resultRequest = list.map((model) => Photo.fromJson(model)).toList();
    emit(state.copyWith(status: PhotosStatus.success, photos: resultRequest));
  }
}
