import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/constants.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageSrc,
    this.proLableText = "Pro",
    this.press,
  });

  final String name, email, imageSrc;
  final String proLableText;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      // leading: CircleAvatar(
      //   radius: 28.r,
      //   child: NetworkImageWithLoader(
      //     imageSrc,
      //   ),
      // ),
      title: Row(
        children: [
          Text(
            "$name" ,
            style: const TextStyle(fontWeight: FontWeight.w500 , color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
           SizedBox(width: defaultPadding / 2),
        ],
      ),
      subtitle: Text(email),
      trailing: Icon(Icons.arrow_forward_ios_outlined, color: Theme.of(context).iconTheme.color!.withOpacity(0.4), size: 15,)
    );
  }
}
