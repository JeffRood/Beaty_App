import 'package:beaty_app/data/bloc/photos/list/photos_bloc.dart';
import 'package:beaty_app/data/bloc/photos/photo/photo_bloc.dart';
import 'package:beaty_app/ui/screens/photos/photo_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhotosBloc>(
          create: (context) => PhotosBloc(),
        ),
        BlocProvider<PhotoBloc>(
          create: (context) => PhotoBloc(),
        ),
      ],
      child: const CupertinoApp(
        title: 'PhotoList',
        home: PhotoListScreen(),
      ),
    );
  }
}
