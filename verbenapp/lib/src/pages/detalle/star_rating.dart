// import 'package:flutter/material.dart';

// typedef void RatingChangeCallback(double rating);

// class StarRating extends StatelessWidget {
//   final int starCount;
//   final double rating;
//   final RatingChangeCallback onRatingChanged;
//   final Color color;

//   StarRating(
//       {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

//   Widget buildStar(BuildContext context, int index) {
//     Icon icon;
//     if (index >= rating) {
//       icon = new Icon(
//         Icons.star_border,
//         color: Colors.black,
//       );
//     } else if (index > rating - 1 && index < rating) {
//       icon = new Icon(
//         Icons.star_half,
//         color: Colors.deepOrangeAccent,
//       );
//     } else {
//       icon = new Icon(Icons.star, color: Colors.deepOrangeAccent);
//     }
//     return new InkResponse(
//       onTap:
//           onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
//       child: icon,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 140,
//       child: new Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: new List.generate(
//               starCount, (index) => buildStar(context, index))),
//     );
//   }
// }
