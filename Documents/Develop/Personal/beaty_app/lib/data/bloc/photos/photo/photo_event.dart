import 'package:flutter/material.dart';

@immutable
abstract class PhotoEvent {}

class PhotoRequested extends PhotoEvent {
  PhotoRequested({required this.id});
  final int id;
}
