import 'package:flutter/material.dart';
import 'package:turnarix/data/helper/email_checker.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/auth/check_email_screen.dart';
import 'package:turnarix/view/screens/auth/signup_check_email.dart';
import 'package:turnarix/view/screens/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController!.text = Provider.of<AuthProvider>(context, listen: false).getUserNumber() ?? '';
    _passwordController!.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? '';
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child:
        Consumer<AuthProvider>(
          builder: (context, authProvider, child){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset(Images.main_logo, height: 100, color: Theme.of(context).primaryColor),
                //
                // Text('Sign In', style: TextStyle(
                //     color: Theme.of(context).primaryColor,
                //     fontWeight: FontWeight.w500,
                //     fontSize: 20
                // )),

                const SizedBox(height: 10),

                Center(
                  child:Scrollbar(
                    child: SingleChildScrollView(
                      // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                      physics: const BouncingScrollPhysics(),
                      child: Center(
                        child: SizedBox(
                            width: 1170,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Inserisci l\'indirizzo email',
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),
                                const SizedBox(height: 10),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child:  CustomTextField(
                                        hintText: 'example@gmail.com',
                                        isShowBorder: true,
                                        inputType: TextInputType.emailAddress,
                                        inputAction: TextInputAction.next,
                                        focusNode: _emailFocus,
                                        controller: _emailController,
                                        isIcon: true,
                                        isShowPrefixIcon: true,
                                        prefixIconUrl: Images.message_icon,
                                      ),
                                    )),
                                const SizedBox(height: 25),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Parola d\'ordine', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),
                                const SizedBox(height: 10),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child:  CustomTextField(
                                        hintText: '***********',
                                        isShowBorder: true,
                                        isPassword: true,
                                        inputAction: TextInputAction.done,
                                        focusNode: _passwordFocus,
                                        controller: _passwordController,
                                        isIcon: true,
                                        isShowPrefixIcon: true,
                                        isShowSuffixIcon: true,
                                        prefixIconUrl: Images.lock_icon,

                                      ),
                                    )),

                                const SizedBox(height: 8),

                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> CheckEmailScreen()));
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text('Ha dimenticato la password',
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2!.color,
                                              fontSize: 14, fontWeight: FontWeight.normal)),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    authProvider.loginErrorMessage.length > 0
                                        ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5)
                                        : SizedBox.shrink(),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        authProvider.loginErrorMessage ?? "",
                                        style: Theme.of(context).textTheme.headline2!.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: authProvider.loginErrorMessage.length > 0? 10 : 0),

                                authProvider.isLoading?
                                Center(
                                    child: CircularProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                    )):

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: CustomButton(btnTxt: 'Registrazione',
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        String _email = _emailController!.text.trim();
                                        String _password = _passwordController!.text.trim();
                                        if (_email.isEmpty) {
                                          showCustomSnackBar('Inserisci l\'indirizzo email', context);
                                        }else if (EmailChecker.isNotValid(_email)) {
                                          showCustomSnackBar('Inserire un\'email valida', context);
                                        }else if (_password.isEmpty) {
                                          showCustomSnackBar('Inserire la password', context);
                                        }else if (_password.length < 6) {
                                          showCustomSnackBar('La password deve contenere più di 6 caratteri', context);
                                        }else {
                                          authProvider.login(_email, _password).then((status) async {
                                            if (status.isSuccess) {
                                              Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context).then((value) {
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext? context)=> DashboardScreen(pageIndex: 0)));
                                              });

                                            }
                                          });
                                        }
                                      }),
                                ),

                                const SizedBox(height: 25),

                                InkWell(
                                  onTap: () {
                                    authProvider.resetMessages();
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=> SignUpCheckEmail()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Non hai un account?',
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),

                                      const SizedBox(width: 10),

                                      Text('Iscrizione',
                                          style: TextStyle(color: Theme.of(context).primaryColor,
                                              fontSize: 16, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          })
      ),
    );
  }
}
