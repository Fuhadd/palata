// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class ImageCard extends StatelessWidget {
//   const ImageCard({required this.imageName})
//
//    final String imageName;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 20.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: CachedNetworkImage(
//           height: 240,
//           width: 360,
//           imageUrl: imageName,
//           fit: BoxFit.fill,
//           placeholder: (context, url) => Shimmer.fromColors(
//             highlightColor: Colors.white,
//             baseColor: Colors.grey!![300],
//             child: Container(height: 240, width: 360),
//             period: Duration(milliseconds: 800),
//           ),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//       ),
//     );
//   }
// }
