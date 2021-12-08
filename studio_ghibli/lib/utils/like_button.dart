import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter/cupertino.dart';

class LikeButtonWidget extends StatefulWidget{
  @override
  _LikeButtonWidgetState  createState()  => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final double size = 40;
    return LikeButton(
      size: size,
      isLiked: isLiked,
        likeBuilder: (isLiked){
        final color = isLiked ? Colors.redAccent : Colors.grey;
        return Icon(Icons.favorite, color : color, size : size);
    },
      onTap: (isLiked) async{
        return ! isLiked;
      },
    );
  }

}

