import 'package:beaty_app/data/bloc/photos/photo/photo_bloc.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_event.dart';
import 'package:beaty_app/domain/models/photo.dart';
import 'package:beaty_app/ui/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoDetailScreen extends StatefulWidget {
  final Photo photo;
  const PhotoDetailScreen({Key? key, required this.photo}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<PhotoDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
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
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        TitleComtainer('Photo Detail', screenHeight * 0.1, context, true)
      ],
    )));
  }

  void _loadPostDetail() {
    BlocProvider.of<PhotoBloc>(context)
        .add(PhotoRequested(id: widget.photo.id!));
  }
}
