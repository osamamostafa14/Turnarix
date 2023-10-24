import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/auth/login_screen.dart';
import 'package:turnarix/view/screens/auth/steps/auth_second_screen.dart';

class AuthFirstScreen extends StatefulWidget {
  final String? email;
  AuthFirstScreen({this.email});

  @override
  _AuthFirstScreenState createState() => _AuthFirstScreenState();
}

class _AuthFirstScreenState extends State<AuthFirstScreen> {

  FocusNode _nameFocus = FocusNode();
  FocusNode _surNameFocus = FocusNode();

  TextEditingController? _nameController;
  TextEditingController? _surNameController;

  GlobalKey<FormState>? _formKeyLogin;

  File? file;
  PickedFile? data;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _surNameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    _surNameController!.dispose();
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
                                      child: Text('Come ti chiami?', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),

                                const SizedBox(height: 10),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child:  CustomTextField(
                                        hintText: '',
                                        isShowBorder: true,
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: _nameFocus,
                                        controller: _nameController,
                                      //  isIcon: true,
                                       // isShowPrefixIcon: true,
                                        prefixIconUrl: Images.user_icon,
                                      ),
                                    )),

                                const SizedBox(height: 20),
                                /// Phone Number

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Qual\'è il tuo Cognome?', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),

                                const SizedBox(height: 10),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                                  child:   CustomTextField(
                                    maxLength: 12,
                                    hintText: '',
                                    isShowBorder: true,
                                    inputType: TextInputType.text,
                                    inputAction: TextInputAction.next,
                                    focusNode: _surNameFocus,
                                    controller: _surNameController,
                                   // isIcon: true,
                                  ),
                                ),

                                /// End Phone Number
                                const SizedBox(height: 20),

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

                                        String _name =
                                        _nameController!.text.trim();

                                        String _surName =
                                        _surNameController!.text.trim();

                                        if (_name.isEmpty) {
                                          showCustomSnackBar('il campo del nome è vuoto', context);
                                        }
                                        else if (_surName.isEmpty) {
                                          showCustomSnackBar(
                                              'il campo cognome è vuoto',
                                              context);
                                        }
                                      else {
                                          authProvider.setFirstScreenValues(_name, _surName, widget.email!);
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                              AuthSecondScreen()));
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
