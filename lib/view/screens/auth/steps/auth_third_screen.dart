import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turnarix/data/model/response/signup_model.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/auth/login_screen.dart';
import 'package:turnarix/view/screens/auth/steps/auth_second_screen.dart';
import 'package:turnarix/view/screens/dashboard/dashboard_screen.dart';

class AuthThirdScreen extends StatefulWidget {
  final String? email;
  AuthThirdScreen({this.email});

  @override
  _AuthThirdScreenState createState() => _AuthThirdScreenState();
}

class _AuthThirdScreenState extends State<AuthThirdScreen> {

  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  GlobalKey<FormState>? _formKeyLogin;

  File? file;
  PickedFile? data;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
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
                return  Center(
                  child:Scrollbar(
                    child: SingleChildScrollView(
                      // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                      physics: BouncingScrollPhysics(),
                      child: Center(
                        child: SizedBox(
                            width: 1170,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),

                                Align(
                                  alignment: Alignment.center,
                                  child: Text('Iscrizione', style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  )),
                                ),
                                const SizedBox(height: 10),

                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      //border: Border.all(width: 2, color: Theme),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 50),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Password', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
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
                                const SizedBox(height: 15),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Conferma Password', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
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
                                        focusNode: _confirmPasswordFocus,
                                        controller: _confirmPasswordController,
                                        isIcon: true,
                                        isShowPrefixIcon: true,
                                        isShowSuffixIcon: true,
                                        prefixIconUrl: Images.lock_icon,

                                      ),
                                    )),
                                /// End Phone Number
                                const SizedBox(height: 20),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    authProvider.registrationErrorMessage.length > 0
                                        ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5)
                                        : SizedBox.shrink(),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        authProvider.registrationErrorMessage ?? "",
                                        style: Theme.of(context).textTheme.headline2!.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: authProvider.registrationErrorMessage.length > 0? 10 : 0),

                                authProvider.isLoading?
                                Center(
                                    child: CircularProgressIndicator(
                                      valueColor: new AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                    )):

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: CustomButton(btnTxt: 'Prossima',
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();

                                        String _password =
                                        _passwordController!.text.trim();

                                        String _confirmPassword =
                                        _confirmPasswordController!.text.trim();

                                        if (_password.isEmpty) {
                                        showCustomSnackBar(
                                        'Inserire la password',
                                        context);
                                        } else if (_password.length < 6) {
                                        showCustomSnackBar(
                                        'La password deve contenere più di 6 caratteri',
                                        context);
                                        } else if (_confirmPassword.isEmpty) {
                                        showCustomSnackBar(
                                        'Inserisci il campo di conferma della password',
                                        context);
                                        } else if (_password != _confirmPassword) {
                                        showCustomSnackBar(
                                        'La password non corrisponde',
                                        context);
                                        }
                                        else {
                                          SignUpModel signUpModel = SignUpModel(
                                            name: authProvider.name,
                                            surname: authProvider.surName,
                                            email: authProvider.email,
                                            password: _password,
                                            phone: authProvider.phoneNumber,
                                            roleId: authProvider.roleId,
                                            roleName: authProvider.roleName,
                                          );
                                          authProvider.registration(signUpModel).then((status) async {
                                            if (status.isSuccess) {
                                              Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context).then((value) {
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                                    DashboardScreen(pageIndex: 0)));
                                              });
                                            }
                                          });
                                        }
                                      }),
                                ),

                                const SizedBox(height: 30),

                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> LoginScreen()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already have an account?',
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),

                                      const SizedBox(width: 10),

                                      Text('Registrazione',
                                          style: TextStyle(color: Theme.of(context).primaryColor,
                                              fontSize: 16, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),


                                const SizedBox(height: 30),

                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                );
              })
      ),
    );
  }
}
