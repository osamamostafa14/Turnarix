import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/styles.dart';
import 'package:turnarix/view/base/custom_app_bar.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      appBar:
      AppBar(
        title: Text('Terms & Conditions', style: rubikMedium.copyWith(fontSize: 14,
            color: Theme.of(context).primaryColor)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          onPressed: () =>  Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
        elevation: 0.5,
      ),
      body:
      Consumer<AuthProvider>(
        builder: (context, authProvider, child){
          return  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                // Html(
                //   '${Provider.of<SplashProvider>(context!, listen: false)
                //       .configModel
                //   !.termsAndConditions}',
                //
                // ),

                Html(
                  data: '${Provider.of<SplashProvider>(context, listen: false)
                      .configModel!.termsAndConditions}',
                  style: {
                    "body": Style(
                        color: Theme.of(context).textTheme.headline2!.color
                    ),
                    "strong": Style(
                        color: Theme.of(context).textTheme.headline2!.color
                    ),
                    "span": Style(
                        color: Theme.of(context).textTheme.headline2!.color
                    ),
                  },
                ),
              ),

            ],
          );
        })

    );
  }
}
