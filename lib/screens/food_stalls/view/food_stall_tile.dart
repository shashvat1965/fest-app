import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/ui_utils.dart';

class FoodStallTile extends StatelessWidget {
  FoodStallTile({Key? key, required this.image, required this.foodStallName,required this.location})
      : super(key: key);
  String image;
  String foodStallName;
  String location;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: UIUtills().getProportionalWidth(width: 184),
          height: UIUtills().getProportionalHeight(height: 230),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: image,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: UIUtills().getProportionalHeight(height: 10),
              left: UIUtills().getProportionalWidth(width: 125)),
          child: Container(
            height: UIUtills().getProportionalHeight(height: 19),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(18, 18, 18, 1),
            ),
          ),
        ),
        Container(
          width: UIUtills().getProportionalWidth(width: 184),
          height: UIUtills().getProportionalHeight(height: 230),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(colors: <Color>[
                Color.fromRGBO(0, 0, 0, 0),
                Color.fromRGBO(27, 27, 26, 0.84),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              UIUtills().getProportionalWidth(width: 16),
              UIUtills().getProportionalHeight(height: 160),
              UIUtills().getProportionalWidth(width: 16),
              UIUtills().getProportionalHeight(height: 0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                foodStallName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                location,
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
