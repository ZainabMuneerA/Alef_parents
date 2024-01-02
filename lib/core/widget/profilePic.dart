import 'package:flutter/material.dart';

// class ProfilePic extends StatelessWidget {
//   const ProfilePic({required this.imageUrl, this.radius = 50.0, Key? key})
//       : super(key: key);

//   final String? imageUrl;
//   final double radius;

//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: radius,
//       backgroundColor: imageUrl != null
//           ? const Color.fromARGB(255, 220, 215, 215)
//           : const Color.fromARGB(255, 238, 231, 231),
//       child: ClipOval(
//         child: imageUrl != null
//             ? Image.network(
//                 imageUrl!,
//                 fit: BoxFit.cover,
//               )
//             : Image.asset(
//                 'lib/assets/images/imageHolder.jpeg',
//                 fit: BoxFit.cover,
//               ),
//       ),
//     );
//   }
// }

class ProfilePic extends StatelessWidget {
  const ProfilePic(
      {required this.imageUrl, this.radius = 50.0, this.isAssets = false, this.assetImage = 'lib/assets/images/imageHolder.jpeg', Key? key})
      : super(key: key);

  final String? imageUrl;
  final double radius;
  final bool isAssets;
  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty && !isAssets
          ? NetworkImage(imageUrl!)
          : AssetImage(isAssets && assetImage.isNotEmpty ? assetImage : 'lib/assets/images/imageHolder.jpeg') as ImageProvider,
    );
  }
}

