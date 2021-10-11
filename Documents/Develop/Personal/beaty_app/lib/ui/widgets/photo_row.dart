import 'package:beaty_app/domain/models/photo.dart';
import 'package:beaty_app/ui/screens/photos/photo_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget photoRow(Photo photo, BuildContext context) {
  return GestureDetector(
    onTap: () => {},
    child: Container(
      margin: const EdgeInsets.all(10),
      // ignore: prefer_const_constructors
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
        child: OutlinedButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return PhotoDetailScreen(photo: photo);
            })),
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.1,
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
    ),
  );
}
