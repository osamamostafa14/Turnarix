import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/calendar_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/dashboard/dashboard_screen.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final String? email;
  CreateNewPasswordScreen({ @required this.email});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Crea una nuova password', style: TextStyle(color: Theme.of(context).primaryColor)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: SizedBox(
                  width: 1170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 55),
                      Center(
                        child: Icon(Icons.lock_open, size: 100, color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 40),
                      Center(
                          child: Text(
                            'Inserire una nuova password',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.headline2!.color),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // for password section

                            SizedBox(height: 60),

                            Text(
                              'Nuova password',
                              style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.headline2!.color),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            CustomTextField(
                              hintText: '',
                              isShowBorder: true,
                              isPassword: true,
                              focusNode: _passwordFocus,
                              nextFocus: _confirmPasswordFocus,
                              isShowSuffixIcon: true,
                              inputAction: TextInputAction.next,
                              controller: _passwordController,
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            // for confirm password section
                            Text(
                              'Conferma password',
                              style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.headline2!.color),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            CustomTextField(
                              hintText: '',
                              isShowBorder: true,
                              isPassword: true,
                              isShowSuffixIcon: true,
                              focusNode: _confirmPasswordFocus,
                              controller: _confirmPasswordController,
                              inputAction: TextInputAction.done,
                            ),

                            const SizedBox(height: 24),

                            !auth.isForgotPasswordLoading ? CustomButton(
                              btnTxt: 'Salva',
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (_passwordController.text.isEmpty) {
                                  showCustomSnackBar('Inserire una nuova password', context);
                                }else if (_passwordController.text.length < 6) {
                                  showCustomSnackBar('La password deve contenere più di 6 caratteri', context);
                                }else if (_confirmPasswordController.text.isEmpty) {
                                  showCustomSnackBar('Accedere alla schermata di conferma della password', context);
                                }else if(_passwordController.text != _confirmPasswordController.text) {
                                  showCustomSnackBar('La password non corrisponde', context);
                                }else {
                                  auth.resetPassword(email!, _passwordController.text, _confirmPasswordController.text).then((value) {
                                    if(value.isSuccess) {
                                      auth.login(email!, _passwordController.text).then((value) async {
                                        Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context).then((value) {
                                          Provider.of<CalendarProvider>(context, listen: false).getCalendarShifts(context);
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext? context)=> DashboardScreen(pageIndex: 0)));
                                        });
                                      });
                                    }else {
                                      showCustomSnackBar('Impossibile reimpostare la password', context);
                                    }
                                  });
                                }
                              },
                            ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
