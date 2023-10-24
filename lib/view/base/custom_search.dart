import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomSearch({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset:const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.search_outlined,
                      color: Colors.black54,
                      size: 25,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'What service are you looking for?',
                      style:  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500,
                          fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
