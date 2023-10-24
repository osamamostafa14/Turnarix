import 'package:turnarix/view/screens/auth/create_new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/screens/auth/steps/auth_first_screen.dart';

class VerificationScreen extends StatelessWidget {
  final String? emailAddress;
  final bool? fromSignUp;
  VerificationScreen({@required this.emailAddress, this.fromSignUp = false});

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Verifica Email', style: TextStyle(color: Theme.of(context!).primaryColor)),
        centerTitle: true,
        elevation: 0.2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          onPressed: () =>  Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: SizedBox(
                width: 1170,
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 55),
                      Center(
                        child: Icon(Icons.email, size: 100, color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                            child: Text(
                          'Inserisci il codice a 4 cifre  $emailAddress',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.headline2!.color),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                        child: PinCodeTextField(
                          textStyle: TextStyle(color: Colors.white),
                          length: 4,
                          appContext: context,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: 63,
                            fieldWidth: 55,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(10),
                            selectedColor: ColorResources.colorMap[200],
                            selectedFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            inactiveColor: ColorResources.colorMap[200],
                            activeColor: ColorResources.colorMap[400],
                            activeFillColor: ColorResources.getSearchBg(context),
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          onChanged: authProvider.updateVerificationCode,
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),
                      Center(
                          child: Text(
                        'Non ho ricevuto il codice',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Theme.of(context).textTheme.headline2!.color,
                            ),
                      )),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if(fromSignUp!) {
                              Provider.of<AuthProvider>(context, listen: false).checkEmail(emailAddress!, 'no').then((value) {
                                if (value.isSuccess) {
                                  showCustomSnackBar('Nuovo invio del codice riuscito', context, isError: false);
                                } else {
                                  showCustomSnackBar(value.message, context);
                                }
                              });
                            }else {
                              Provider.of<AuthProvider>(context, listen: false).forgetPassword(emailAddress!).then((value) {
                                if (value.isSuccess) {
                                  showCustomSnackBar('Nuovo invio del codice riuscito', context, isError: false);
                                } else {
                                  showCustomSnackBar(value.message, context);
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Text(
                              'Rimanda il codice',
                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                    color: ColorResources.getGreyBunkerColor(context),
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      authProvider.isEnableVerificationCode ? !authProvider.isverificationButtonLoading
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                              child: CustomButton(
                                btnTxt: 'Verifica',
                                onTap: () {
                                  if(fromSignUp!) {
                                    Provider.of<AuthProvider>(context, listen: false).verifyEmail(emailAddress!).then((value) {
                                      if(value.isSuccess) {
                                        authProvider.resetSignUpModel();
                                        authProvider.getEmployeeRoles(context);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                            AuthFirstScreen(email: emailAddress)));
                                      }else {
                                        showCustomSnackBar(value.message, context);
                                      }
                                    });
                                  }else {
                                    Provider.of<AuthProvider>(context, listen: false).verifyToken(emailAddress!).then((value) {
                                      if(value.isSuccess) {
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                            CreateNewPasswordScreen(
                                              email: emailAddress,
                                        )));
                                     //   Navigator.pushNamed(context, Routes.getNewPassRoute(emailAddress!, authProvider.verificationCode));
                                      }else {
                                        showCustomSnackBar(value.message, context);
                                      }
                                    });
                                  }
                                },
                              ),
                            ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
                          : SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
