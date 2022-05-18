import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  final int maxRating;
  final Function(int) RatingSelected;

  Rating(this.RatingSelected, [this.maxRating = 5]);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int currentRating = 0;
  Widget _buildRatingStar(int index) {
    if(index < currentRating) {
      return Icon(Icons.star, color: Colors.redAccent);
    }else {
      return Icon(Icons.star_outline_sharp);
    }

  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(widget.maxRating, (index) {
      return GestureDetector(
        child: _buildRatingStar(index),
        onTap: () {
          setState(() {
            currentRating = index + 1;
          });
          this.widget.RatingSelected(currentRating);
        },
      );
    });

    return Row(
      children: stars,
      //mainAxisAlignment: MainAxisAlignment.start,

    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
