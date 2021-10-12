import 'package:beaty_app/data/bloc/photos/photo/photo_bloc.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_event.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_state.dart';
import 'package:beaty_app/domain/models/photo.dart';
import 'package:beaty_app/ui/widgets/loading.dart';
import 'package:beaty_app/ui/widgets/title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beaty_app/ui/widgets/detail_card.dart';

class PhotoDetailScreen extends StatefulWidget {
  final Photo photo;
  const PhotoDetailScreen({Key? key, required this.photo}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<PhotoDetailScreen> {
  @override
  void initState() {
    super.initState();
    _loadPostDetail();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double statusBarHeight = mediaQuery.padding.top;
    double buttonsBarHeight = mediaQuery.padding.bottom;
    double screenHeight =
        (mediaQuery.size.height - statusBarHeight - buttonsBarHeight);
    String title = 'Photo Detail';

    return SafeArea(child: Scaffold(body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (BuildContext context, PhotoState state) {
      switch (state.status) {
        case PhotoStatus.loading:
          return Column(
            children: <Widget>[
              TitleComtainer(title, screenHeight * 0.1, context, true),
              loadingIndicator(),
            ],
          );
        case PhotoStatus.success:
          return Column(
            children: [
              TitleComtainer(title, screenHeight * 0.1, context, true),
              pictureContainer(screenHeight * 0.8, state.photo!),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _detailCard(Icons.confirmation_number, "ID",
                      state.photo!.id.toString(), screenHeight),
                  _detailCard(
                      Icons.title, "Title", state.photo!.title!, screenHeight),
                ],
              ),
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
    })));
  }

  Widget pictureContainer(double parentContainerHeight, Photo photo) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: parentContainerHeight * 0.3,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000.0),
        child: CachedNetworkImage(
            imageUrl: photo.url!,
            progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    backgroundColor: Colors.white,
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
            useOldImageOnUrlChange: true),
      ),
    );
  }

  Widget _detailCard(
    IconData iconData,
    String title,
    String text,
    double mainContainerHeight, {
    bool isPill = false,
    bool isRowSecond = false,
  }) {
    final double marginTop = 20;
    final double marginBottom = 20;
    final double marginRight = isPill ? 20 : (isRowSecond ? 20 : 10);
    final double marginLeft = isPill ? 20 : (isRowSecond ? 10 : 20);
    final EdgeInsets margin = EdgeInsets.only(
      top: marginTop,
      bottom: marginBottom,
      right: marginRight,
      left: marginLeft,
    );
    final marginHorizontal = (marginRight + marginLeft) * (isPill ? 1 : 2);
    final availableWidthSize =
        (MediaQuery.of(context).size.width - marginHorizontal);
    return Container(
      width: isPill ? availableWidthSize : availableWidthSize * 0.5,
      height: mainContainerHeight * 0.15,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Color(0xff021C38),
          ),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            fit: BoxFit.contain,
          ),
          Text(
            text,
            style: TextStyle(
              color: Color(0xff021C38),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey,
            spreadRadius: 1,
          )
        ],
      ),
    );
  }

  void _loadPostDetail() {
    BlocProvider.of<PhotoBloc>(context)
        .add(PhotoRequested(id: widget.photo.id!));
  }
}
