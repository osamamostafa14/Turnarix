import 'package:flutter/material.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/utill/app_constants.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';

class ReviewWidget extends StatelessWidget {
  final String? name;
  final int? rating;
  final String? comment;
  final String? time;
  final String? avatarUrl;

  ReviewWidget({@required this.name, @required this.rating,@required this.comment,@required this.time, @required this.avatarUrl});
  @override
  Widget build(BuildContext context) {
    String _originalDateTime = DateConverter.isoStringToLocalDateOnly(time!);
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          color: Colors.grey[300]!,
          blurRadius: 5, spreadRadius: 1,
        )],
      ),

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder_rectangle,
                    image: '$avatarUrl',
                    height: 40,
                    fit: BoxFit.cover,
                    width: 40,
                  ),
                )
            ),
            Text('${name}',
                style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black87
            ))
          ],
        ),

        const SizedBox(height: 10),

        Text(comment!, style: const TextStyle(
            color: Colors.black54,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          fontFamily: 'Roboto',
        )),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.star, size: 20, color: Colors.orange),
                const SizedBox(width: 5),
                Text('${rating.toString()}.0', style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                )),
                const Spacer(),

                Text(_originalDateTime, style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto',
                )),
              ],
            )
      ]),
    );
  }
}
