import 'package:flutter/material.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'dart:math';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';
import 'package:turnarix/view/screens/auth/login_screen.dart';
import 'package:turnarix/view/screens/auth/steps/auth_third_screen.dart';

class AuthSecondScreen extends StatefulWidget {

  @override
  _AuthSecondScreenState createState() => _AuthSecondScreenState();
}

class _AuthSecondScreenState extends State<AuthSecondScreen> {

  TextEditingController? _phoneController;
  final TextEditingController valueController = TextEditingController();
  List<String> _options = [];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController!.dispose();
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
                authProvider.employeeRoles.forEach((role) {
                  if(!_options.contains(role.name!)){
                    _options.add(role.name!);
                  }
                });
                return  Center(
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
                                      child: Text('Qual\'è il tuo ambito lavorativo?', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),

                                const SizedBox(height: 10),

                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext? context) {
                                            return AlertDialog(
                                              //title: Text("Hint", style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  for(int i = 0; i <  authProvider.employeeRoles.length ; i++)
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                            onTap : () {
                                                              authProvider.setRole(authProvider.employeeRoles[i].name!, authProvider.employeeRoles[i].id!);
                                                              Navigator.pop(context);
                                                            },
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Expanded(
                                                                  child: SizedBox(
                                                                    height: 30,
                                                                    child: Text("${authProvider.employeeRoles[i].name}",
                                                                        style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 16)),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        i!=authProvider.employeeRoles.length - 1?
                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom: 8),
                                                          child: const Divider(),
                                                        ): const SizedBox(),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(width: 1, color: Colors.blue.withOpacity(0.5))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${authProvider.roleName}', style: TextStyle(color: Colors.black54, fontSize: 16)),
                                            const SizedBox(width: 10),
                                            Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationZ(-90.0 * (pi / 180.0)),
                                              child: Icon(Icons.arrow_back_ios_sharp, size: 18, color: Colors.black54),
                                            ),
                                            const SizedBox(width: 15),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                                /// Phone Number

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Qual\'è il tuo numero di telefono?', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),

                                const SizedBox(height: 10),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                                  child:   CustomTextField(
                                    maxLength: 12,
                                    hintText: 'Ex: +393*********',
                                    isShowBorder: true,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.next,
                                    controller: _phoneController,
                                    // isIcon: true,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                authProvider.isLoading?
                                Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                    )):

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: CustomButton(btnTxt: 'Prossima',
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();

                                        String _phone =
                                        _phoneController!.text.trim();

                                        if (_phone.isEmpty) {
                                          showCustomSnackBar('il campo del numero di telefono è vuoto', context);
                                        }else if (_phone.length < 8) {
                                          showCustomSnackBar('Si prega di inserire il numero di telefono valido', context);
                                        }else if (authProvider.roleId == null) {
                                          showCustomSnackBar('seleziona il tuo spazio di lavoro', context);
                                        }
                                        else {
                                          authProvider.setSecondScreenValues(_phone);
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> AuthThirdScreen()));
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
