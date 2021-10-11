import 'package:flutter/material.dart';

@immutable
abstract class PhotosEvent {}

class PhotosRequested extends PhotosEvent {}
