import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({Key? key}) : super(key: key);

  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPosts();
  }