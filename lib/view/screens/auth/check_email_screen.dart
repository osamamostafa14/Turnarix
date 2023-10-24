import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/utill/styles.dart';
import 'package:turnarix/view/base/custom_app_bar.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/auth/email_verification_screen.dart';

class CheckEmailScreen extends StatefulWidget {
  @override
  _CheckEmailScreenState createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext? context) {
    TextEditingController _emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Ha dimenticato la password', style: rubikMedium.copyWith(fontSize: 14,
            color: Theme.of(context).primaryColor)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          onPressed: () =>  Navigator.pop(context),
        ),
        elevation: 0.2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: 1170,
              child: Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 55),

                      Center(child: Icon(Icons.mail, size: 100, color: Theme.of(context).primaryColor)),

                      SizedBox(height: 40),
                      Center(
                          child: Text(
                            'Per favore inserisci la tua email',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.headline2!.color, fontSize: 14),
                          )),
                      Padding(
                        padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'Email',
                              style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.headline2!.color),
                            ),

                           const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            CustomTextField(
                              hintText: 'example@gmail.com',
                              isShowBorder: true,
                              controller: _emailController,
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.done,
                            ),

                            const SizedBox(height: 24),

                            !auth.checkEmailLoading ? CustomButton(
                              btnTxt: 'Inviare',
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (_emailController.text.isEmpty) {
                                  showCustomSnackBar('Inserisci l\'indirizzo email', context);
                                }else if (!_emailController.text.contains('@')) {
                                  showCustomSnackBar('Inserire un\'email valida', context);
                                }else {
                                  Provider.of<AuthProvider>(context, listen: false).checkEmail(_emailController.text, 'yes').then((value) {
                                    if (value.isSuccess) {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=> EmailVerificationScreen(
                                          forgotPassword: true,
                                          emailAddress: _emailController.text)));
                                    } else {
                                      showCustomSnackBar(value.message, context);
                                    }
                                  });
                                }
                              },
                            ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
