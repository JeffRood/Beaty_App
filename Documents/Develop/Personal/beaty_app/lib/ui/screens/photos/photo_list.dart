// ignore_for_file: prefer_const_constructors

import 'package:beaty_app/data/bloc/photos/list/photos_bloc.dart';
import 'package:beaty_app/data/bloc/photos/list/photos_event.dart';
import 'package:beaty_app/data/bloc/photos/list/photos_state.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_state.dart';
import 'package:beaty_app/domain/models/photo.dart';
import 'package:beaty_app/ui/widgets/Title.dart';
import 'package:beaty_app/ui/widgets/loading.dart';
import 'package:beaty_app/ui/widgets/photo_row.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<PhotoListScreen> {
  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double statusBarHeight = mediaQuery.padding.top;
    double buttonsBarHeight = mediaQuery.padding.bottom;
    double screenHeight =
        (mediaQuery.size.height - statusBarHeight - buttonsBarHeight);
    String title = 'Photos List';
    return SafeArea(child: Scaffold(
      body: BlocBuilder<PhotosBloc, PhotosState>(
        builder: (BuildContext context, PhotosState state) {
          switch (state.status) {
            case PhotosStatus.loading:
              return Column(
                children: <Widget>[
                  TitleComtainer(title, screenHeight * 0.1, context, false),
                  loadingIndicator(),
                ],
              );
            case PhotosStatus.success:
              return Column(
                children: [
                  TitleComtainer(title, screenHeight * 0.1, context, false),
                  _buildPhotoList(state.photos)
                ],
              );
            default:
              return Column(
                children: <Widget>[
                  TitleComtainer(title, screenHeight * 0.1, context, false),
                  loadingIndicator(),
                ],
              );
          }
        },
      ),
    ));
  }

  Widget _buildPhotoList(List<Photo> photosList) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemCount: photosList.length,
          itemBuilder: (BuildContext context, int index) {
            final Photo photo = photosList[index];
            return photoRow(photo, context);
          }),
    );
  }

  void _loadPhotos() {
    BlocProvider.of<PhotosBloc>(context).add(PhotosRequested());
  }
}
