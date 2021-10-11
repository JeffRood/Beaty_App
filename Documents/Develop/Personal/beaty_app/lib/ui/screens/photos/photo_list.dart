// ignore_for_file: prefer_const_constructors

import 'package:beaty_app/data/bloc/photos/list/photos_bloc.dart';
import 'package:beaty_app/data/bloc/photos/list/photos_event.dart';
import 'package:beaty_app/data/bloc/photos/list/photos_state.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_state.dart';
import 'package:beaty_app/domain/models/photo.dart';
import 'package:beaty_app/ui/widgets/loading.dart';
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
    // TODO: implement initState
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

    double sizeSmallContainer = screenHeight * 0.1;
    double sizeMediumContainer = screenHeight * 0.4;
    double sizeLargeContainer = screenHeight * 0.8;

    return SafeArea(child: Scaffold(
      body: BlocBuilder<PhotosBloc, PhotosState>(
        builder: (BuildContext context, PhotosState state) {
          switch (state.status) {
            case PhotosStatus.loading:
              return Column(
                children: <Widget>[
                  TitleComtaimer(sizeSmallContainer),
                  loadingIndicator(),
                ],
              );
            case PhotosStatus.success:
              return Column(
                children: [
                  TitleComtaimer(sizeSmallContainer),
                  _buildPhotoList(state.photos)
                ],
              );
            //  _buildPostList(state.photos);
            default:
              return Column(
                children: <Widget>[
                  TitleComtaimer(sizeSmallContainer),
                  loadingIndicator(),
                ],
              );
          }
        },
      ),
    ));
  }

  Widget TitleComtaimer(double containersize) {
    return Container(
      color: Colors.indigo[900],
      height: containersize,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Photos',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ],
      ),
    );
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
            return personRow(photo);
          }),
    );
  }

  Widget personRow(Photo photo) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.grey,
              spreadRadius: 1,
            )
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10000.0),
                  child: CachedNetworkImage(
                    imageUrl: photo.url!,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill,
                    useOldImageOnUrlChange: true,
                  ),
                ),
              ),
              Flexible(child: Text(photo.title!, textAlign: TextAlign.center))
            ],
          ),
        ),
      ),
    );
  }

  void _loadPhotos() {
    BlocProvider.of<PhotosBloc>(context).add(PhotosRequested());
  }
}
