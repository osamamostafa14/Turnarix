import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turnarix/data/helper/email_checker.dart';
import 'package:turnarix/data/model/response/signup_model.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:turnarix/utill/app_constants.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/base/custom_text_field.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {

  FocusNode _nameFocus = FocusNode();
  FocusNode _surNameFocus = FocusNode();

  TextEditingController? _nameController;
  TextEditingController? _surNameController;

  TextEditingController? _phoneController;
  final TextEditingController valueController = TextEditingController();
  List<String> _options = [];

  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  GlobalKey<FormState>? _formKeyLogin;

  File? file;
  PickedFile? data;
  final picker = ImagePicker();

  String? _roleName;
  int? _roleId;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _surNameController = TextEditingController();
    _phoneController = TextEditingController();

    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameController!.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.name!;
    _surNameController!.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.surname!;
    _phoneController!.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.phone!;


    _roleName = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.roleName;
    _roleId = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.roleId;
    Provider.of<ProfileProvider>(context, listen: false).setRole(_roleName!, _roleId!);

    Timer(Duration(seconds: 2), () {
      Provider.of<ProfileProvider>(context, listen: false).getEmployeeRoles(context);
    });

  }

  @override
  void dispose() {
    _nameController!.dispose();
    _surNameController!.dispose();
    _phoneController!.dispose();
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
    super.dispose();
  }

  void _choose() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        Provider.of<ProfileProvider>(context, listen: false).setProfileImage(file!);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BG_SECONDRY,
      appBar: AppBar(
        title: Text('Informazioni personali', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: ColorResources.BG_SECONDRY,
        elevation: 0.2,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: Icon(Icons.arrow_back, color: Colors.white),
        // ),
      ),
      body: SafeArea(
          child:
          Consumer<ProfileProvider>(
              builder: (context, profileProvider, child){
                Provider.of<AuthProvider>(context, listen: false).employeeRoles.forEach((role) {
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

                                const SizedBox(height: 30),

                                // Profile Image

                                Container(
                                  height: 80,
                                  margin: EdgeInsets.symmetric(
                                      vertical: Dimensions
                                          .PADDING_SIZE_LARGE),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ColorResources.OFF_WHITE,
                                    border: Border.all(
                                        color: ColorResources
                                            .COLOR_GREY_CHATEAU,
                                        width: 3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap:
                                    _choose,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          child: file != null
                                              ? Image.file(file!,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.fill)
                                              : data != null
                                              ? Image.network(
                                              data!.path,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.fill)
                                              :
                                          profileProvider.userInfoModel!.image !=null?
                                          FadeInImage.assetNetwork(
                                            placeholder: Images.profile_icon,
                                            image: '${Provider.of<SplashProvider>(context,).baseUrls!.customerImageUrl}/${profileProvider.userInfoModel!.image}',
                                            height: 80, width: 80, fit: BoxFit.cover,
                                          ): SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: Icon(Icons.person)),
                                        ),
                                        Positioned(
                                          bottom: 15,
                                          right: -10,
                                          child: InkWell(
                                              onTap: _choose,
                                              child: Container(
                                                alignment:
                                                Alignment.center,
                                                padding:
                                                EdgeInsets.all(2),
                                                decoration:
                                                BoxDecoration(
                                                  shape:
                                                  BoxShape.circle,
                                                  color: ColorResources
                                                      .BORDER_COLOR,
                                                  border: Border.all(
                                                      width: 2,
                                                      color: ColorResources
                                                          .COLOR_GREY_CHATEAU),
                                                ),
                                                child: Icon(Icons.edit,
                                                    size: 13),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Align(
                                    alignment: Alignment.center,
                                    child: Text('${profileProvider.userInfoModel!.email}', style: TextStyle(color: Colors.white70))),

                                const SizedBox(height: 20),


                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Nome',
                                          style: TextStyle(color: Colors.white60, fontSize: 16)),
                                    )),

                                const SizedBox(height: 10),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child:  CustomTextField(
                                        hintText: '',
                                        isShowBorder: true,
                                        inputColor: Colors.white,
                                        fillColor: ColorResources.BG_SECONDRY,
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: _nameFocus,
                                        controller: _nameController,
                                        isIcon: true,
                                        isShowPrefixIcon: true,
                                        prefixIconUrl: Images.user_icon,
                                      ),
                                    )),

                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Cognome',
                                          style: TextStyle(color: Colors.white60, fontSize: 16)),
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
                                        focusNode: _surNameFocus,
                                        controller: _surNameController,
                                        inputColor: Colors.white,
                                        fillColor: ColorResources.BG_SECONDRY,
                                        isIcon: true,
                                        isShowPrefixIcon: true,
                                        prefixIconUrl: Images.user_icon,
                                      ),
                                    )),

                                // Align(
                                //     alignment: Alignment.topLeft,
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(left: 20),
                                //       child: Text('Inserisci l\'indirizzo email',
                                //           style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                //     )),
                                // const SizedBox(height: 10),
                                // Align(
                                //     alignment: Alignment.topLeft,
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(left: 20, right: 20),
                                //       child:  CustomTextField(
                                //         hintText: 'example@gmail.com',
                                //         isShowBorder: true,
                                //         inputType: TextInputType.emailAddress,
                                //         inputAction: TextInputAction.next,
                                //         focusNode: _emailFocus,
                                //         controller: _emailController,
                                //         isIcon: true,
                                //         isShowPrefixIcon: true,
                                //         prefixIconUrl: Images.message_icon,
                                //         isEnabled: false,
                                //       ),
                                //     )),


                                /// roles
                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Qual\'è il tuo ambito lavorativo?',
                                          style: TextStyle(color: Colors.white60, fontSize: 16)),
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
                                              backgroundColor: ColorResources.BG_SECONDRY,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),

                                              ),
                                              //title: Text("Hint", style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  for(int i = 0; i <  profileProvider.employeeRoles.length ; i++)
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                            onTap : () {
                                                              profileProvider.setRole(
                                                                  profileProvider.employeeRoles[i].name!,
                                                                  profileProvider.employeeRoles[i].id!);
                                                              Navigator.pop(context!);
                                                            },
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Expanded(
                                                                  child: SizedBox(
                                                                    height: 30,
                                                                    child: Text("${profileProvider.employeeRoles[i].name}",
                                                                        style: TextStyle(color:
                                                                        Colors.white, fontSize: 16)),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        i!=profileProvider.employeeRoles.length - 1?
                                                        const Padding(
                                                          padding:  EdgeInsets.only(bottom: 8),
                                                          child:  Divider(color: Colors.white60),
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
                                            color: ColorResources.BG_SECONDRY,
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(width: 1, color: Theme.of(context).primaryColor)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${profileProvider.roleName}', style:
                                            TextStyle(color: Colors.white, fontSize: 16)),
                                            const SizedBox(width: 10),
                                            Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationZ(-90.0 * (pi / 180.0)),
                                              child: Icon(Icons.arrow_back_ios_sharp, size: 18, color: Colors.white60),
                                            ),
                                            const SizedBox(width: 15),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ///end roles

                                /// Phone Number
                                const SizedBox(height: 20),


                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Qual\'è il tuo numero di telefono?',
                                          style: TextStyle(color: Colors.white60, fontSize: 16)),
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
                                    inputColor: Colors.white,
                                    fillColor: ColorResources.BG_SECONDRY,
                                    // isIcon: true,
                                  ),
                                ),
                                /// End Phone Number


                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text('Password ', style: TextStyle(color: Colors.white60, fontSize: 16)),

                                          const SizedBox(width: 7),

                                          Text('(Compila solo se vuoi modificarlo) ',
                                              style: TextStyle(color: Colors.white60, fontSize: 14)),
                                        ],
                                      ),
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
                                        inputColor: Colors.white,
                                        fillColor: ColorResources.BG_SECONDRY,

                                      ),
                                    )),

                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Conferma password', style: TextStyle(color: Colors.white60, fontSize: 16)),
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
                                        inputColor: Colors.white,
                                        fillColor: ColorResources.BG_SECONDRY,
                                      ),
                                    )),

                                const SizedBox(height: 30),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: CustomButton(btnTxt: 'Aggiornamento',
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();

                                        String _name =
                                        _nameController!.text.trim();

                                        String _surName =
                                        _surNameController!.text.trim();

                                        String _phone =
                                        _phoneController!.text.trim();

                                        String _password =
                                        _passwordController!.text.trim();

                                        String _confirmPassword =
                                        _confirmPasswordController!.text.trim();

                                        if (_name.isEmpty) {
                                          showCustomSnackBar(
                                              'il campo del nome è vuoto',
                                              context);
                                        }
                                        else if (_surName.isEmpty) {
                                          showCustomSnackBar(
                                              'il campo cognome è vuoto',
                                              context);
                                        }
                                        else if (profileProvider.roleId == null) {
                                          showCustomSnackBar('seleziona il tuo spazio di lavoro', context);
                                        }
                                        else if (_phone.isEmpty) {
                                          showCustomSnackBar('il campo del numero di telefono è vuoto', context);
                                        }else if (_phone.length < 8) {
                                          showCustomSnackBar('Si prega di inserire il numero di telefono valido', context);
                                        }
                                        else if ((_password.isNotEmpty &&
                                            _password.length < 6) ||
                                            (_confirmPassword.isNotEmpty &&
                                                _confirmPassword.length < 6)) {
                                          showCustomSnackBar(
                                              'La password deve contenere più di 6 caratteri',
                                              context);
                                        } else if (_password !=
                                            _confirmPassword) {
                                          showCustomSnackBar(
                                              'La password non corrisponde',
                                              context);
                                        }
                                      else {
                                          SignUpModel signUpModel = SignUpModel(
                                              name: _name,
                                              surname: _surName,
                                              roleName: profileProvider.roleName,
                                              roleId: profileProvider.roleId,
                                              password: _password,
                                              phone: _phone,
                                          );

                                          var box = Hive.box('myBox');
                                          String token = box.get(AppConstants.TOKEN);
                                          profileProvider.updatePersonalInfo(token, signUpModel).then((value) {
                                            profileProvider.getUserInfo(context);
                                            showCustomSnackBar('Profile Updated!', context, isError:false);
                                          });
                                         //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=> VehicleInfoScreen()));

                                        }
                                      }),
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
