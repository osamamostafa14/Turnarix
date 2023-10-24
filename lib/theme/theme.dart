// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:turnarix/Theme/light_theme.dart';
// import 'package:turnarix/Theme/styles/colors.dart';
//
// class AppTheme {
//   AppTheme._();
//
//   static light(BuildContext context) {
//     return lightTheme.copyWith(
//       textTheme: lightTextTheme(context),
//       appBarTheme: const AppBarTheme().copyWith(
//         color: kPrimaryLightTextColor, // original value kPrimaryColor + modified by hassan00942 + modificationHeader00942
//         iconTheme: const IconThemeData(color: Colors.black),// original value Colors.white + modified by hassan00942 + modificationHeader00942
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//         elevation: 1.7, // 1.3, 2 + old value was 0 + added by hassan00942 + appBarBottomElevation00942
//         centerTitle: true,
//         foregroundColor: kLightColor,
//         toolbarHeight: 64,
//         /* added by hassan00942 + appBarBottomBorder00942 */
//         shape: const Border(
//             bottom: BorderSide(
//               color:kPrimaryFadeTextColor,
//               width:0.05,
//             )
//         ),
//         shadowColor:kLightColor,
//         /*
//         commented appbar rounded to corner + hassan00942 + appBarCorner0Size00942
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//         ),*/
//
//         titleTextStyle: TextStyle(
//           fontSize: 16.0,
//           color: Colors.black, // original value Colors.white + modified by hassan00942 + modificationHeader00942
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   // added by hassan this has light headear
//   static dark(BuildContext context) {
//     return darkTheme.copyWith(
//       textTheme: darkTextTheme(context),
//       appBarTheme: const AppBarTheme().copyWith(
//         color: kPrimaryLightTextColor, // original value kPrimaryColor + modified by hassan00942 + modificationHeader00942
//         iconTheme: const IconThemeData(color: Colors.black),// original value Colors.white + modified by hassan00942 + modificationHeader00942
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//         elevation: 1.7, // 1.3, 2 + old value was 0 + added by hassan00942 + appBarBottomElevation00942
//         centerTitle: true,
//         foregroundColor: kLightColor,
//         toolbarHeight: 64,
//         /* added by hassan00942 + appBarBottomBorder00942 */
//         shape: const Border(
//           bottom: BorderSide(
//             color:kPrimaryFadeTextColor,
//             width:0.05,
//           )
//         ),
//         shadowColor:kLightColor,
//         /*
//         commented appbar rounded to corner + hassan00942 + appBarCorner0Size00942
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//           ),
//         ),*/
//         titleTextStyle: TextStyle(
//           fontFamily: 'Roboto',
//           fontSize: Theme.of(context).textTheme.headline6!.fontSize,
//           color: Colors.black,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//   //commented by hassan00942 + this has dark header
//   // static dark(BuildContext context) {
//   //   return darkTheme.copyWith(
//   //     textTheme: darkTextTheme(context),
//   //     appBarTheme: const AppBarTheme().copyWith(
//   //       color: kPrimaryColor,
//   //       iconTheme: const IconThemeData(color: kLightColor),
//   //       systemOverlayStyle: SystemUiOverlayStyle.light,
//   //       elevation: 1.7, // 1.3, 2 + old value was 0 + added by hassan00942 + appBarBottomElevation00942
//   //       centerTitle: true,
//   //       foregroundColor: kLightColor,
//   //       toolbarHeight: 64,
//   //       /*
//   //       commented appbar rounded to corner + hassan00942 + appBarCorner0Size00942
//   //       shape: const RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.only(
//   //           bottomLeft: Radius.circular(16),
//   //           bottomRight: Radius.circular(16),
//   //         ),
//   //       ),*/
//   //       titleTextStyle: GoogleFonts.roboto(
//   //         textStyle: Theme.of(context).textTheme.headline6,
//   //         color: Colors.white,
//   //         fontWeight: FontWeight.w600,
//   //       ),
//   //     ),
//   //   );
//   // }
// }
