import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,

      appBar: AppBar(
          title: Text('Contact us', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal)),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).primaryColor,
            onPressed: () =>  Navigator.pop(context),
          )),

      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          physics: BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: 1170,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Image.asset(Images.contact_us_icon),

                Text('We\'re here to help, so don\'t hesitate to contact us.',
                style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16, fontWeight: FontWeight.w500)),

                const SizedBox(height: 10),

                Divider(thickness: 2),

                SizedBox(height: 30),

                Row(children: [
                  Expanded(child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 1, color: Theme.of(context).primaryColor)),
                      minimumSize: Size(1, 50),
                    ),
                    onPressed: () {
                      launch('tel:${Provider.of<SplashProvider>(context, listen: false).configModel!.appPhone}');
                    },
                    child: Text('Call now', style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
                  )),

                  const SizedBox(width: 10),

                  Expanded(child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 1, color: Theme.of(context).primaryColor)),
                      minimumSize: Size(1, 50),
                    ),
                    onPressed: () {

                    },
                    child: Text('Message', style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
                  )),
                ]),

              ]),
            ),
          ),
        ),
      ),
    );
  }
}
