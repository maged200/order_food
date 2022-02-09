import 'package:flutter/material.dart';

class BottomShhetWidget extends StatefulWidget {
  final Function takePhotoByCamera, takePhotoByGallery, removePhoto;

  const BottomShhetWidget(
      {Key? key,
      required this.takePhotoByCamera,
      required this.takePhotoByGallery,
      required this.removePhoto})
      : super(key: key);
  @override
  _BottomShhetWidgetState createState() => _BottomShhetWidgetState();
}

class _BottomShhetWidgetState extends State<BottomShhetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 250.0,
      margin: EdgeInsets.only(left: 30.0, top: 25.0),
      child: Column(
        children: <Widget>[
          Text(
            "Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20.0, top: 20.0),
            child: Row(
              children: <Widget>[
                // ignore: deprecated_member_use
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: widget.takePhotoByCamera(),
                  label: Text("Camera"),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                ),
                // ignore: deprecated_member_use
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: widget.takePhotoByGallery(),
                  label: Text("Gallery"),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 40.0, top: 10.0),
            child: Row(
              children: <Widget>[
                // ignore: deprecated_member_use
                FlatButton.icon(
                  icon: Icon(Icons.delete),
                  onPressed: widget.removePhoto(),
                  label: Text("Remove"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
