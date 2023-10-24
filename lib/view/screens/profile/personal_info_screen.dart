import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turnarix/data/helper/email_checker.dart';
import 'package:turnarix/data/model/response/signup_model.dart';
import 'package:provider/provider.dart';
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

  FocusNode _fullNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneNumberAFocus = FocusNode();
  FocusNode _phoneNumberBFocus = FocusNode();
  FocusNode _phoneNumberCFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  FocusNode _ssnAFocus = FocusNode();
  FocusNode _ssnBFocus = FocusNode();
  FocusNode _ssnCFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  TextEditingController? _fullNameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneNumberAController;
  TextEditingController? _phoneCodeController;
  TextEditingController? _phoneNumberBController;
  TextEditingController? _phoneNumberCController;
  TextEditingController? _addressController;
  TextEditingController? _ssnFieldAController;
  TextEditingController? _ssnFieldBController;
  TextEditingController? _ssnFieldCController;
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
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberAController = TextEditingController();
    _phoneNumberBController = TextEditingController();
    _phoneNumberCController = TextEditingController();
    _phoneCodeController = TextEditingController();
    _addressController = TextEditingController();
    _ssnFieldAController = TextEditingController();
    _ssnFieldBController = TextEditingController();
    _ssnFieldCController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null){
      _fullNameController!.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.name!;
      _emailController!.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.email!;


      _addressController!.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.address!;
      String phoneValue = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.phone!;
      _phoneNumberAController!.text = phoneValue.substring(0, 3);
      _phoneNumberBController!.text = phoneValue.substring(3, 6);
      _phoneNumberCController!.text = phoneValue.substring(6);
    }

    _phoneCodeController!.text = '+1';
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _fullNameController!.dispose();
    _phoneNumberAController!.dispose();
    _phoneNumberBController!.dispose();
    _phoneNumberCController!.dispose();
    _addressController!.dispose();
    _ssnFieldAController!.dispose();
    _ssnFieldBController!.dispose();
    _ssnFieldCController!.dispose();
    _passwordController!.dispose();
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Personal info', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context!).primaryColor,
        elevation: 0.2,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SafeArea(
          child:
          Consumer<ProfileProvider>(
              builder: (context, profileProvider, child){
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
                                              : FadeInImage.assetNetwork(
                                            placeholder: Images.profile_icon,
                                            image: '${Provider.of<SplashProvider>(context,).baseUrls!.customerImageUrl}/${profileProvider.userInfoModel!.image}',
                                            height: 80, width: 80, fit: BoxFit.cover,
                                          ),
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
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Enter Full name',
                                          style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),

                                const SizedBox(height: 10),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child:  CustomTextField(
                                        hintText: 'Mr. John',
                                        isShowBorder: true,
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: _fullNameFocus,
                                        controller: _fullNameController,
                                        isIcon: true,
                                        isShowPrefixIcon: true,
                                        prefixIconUrl: Images.user_icon,
                                        isEnabled: false,
                                      ),
                                    )),

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
                                        isEnabled: false,
                                      ),
                                    )),

                                /// Phone Number
                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Phone Number', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),
                                const SizedBox(height: 10),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Expanded(
                                        child: CustomTextField(
                                          maxLength: 3,
                                          hintText: '',
                                          isShowBorder: true,
                                          inputType: TextInputType.number,
                                          inputAction: TextInputAction.next,
                                          controller: _phoneCodeController,
                                          isIcon: true,
                                          isEnabled: false,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Expanded(
                                        child: CustomTextField(
                                          maxLength: 3,
                                          hintText: '',
                                          isShowBorder: true,
                                          inputType: TextInputType.number,
                                          inputAction: TextInputAction.next,
                                          focusNode: _phoneNumberAFocus,
                                          controller: _phoneNumberAController,
                                          isIcon: true,
                                          nextFocus: _phoneNumberBFocus,
                                          isEnabled: false,
                                        ),
                                      ),

                                      const SizedBox(width: 7),

                                      Expanded(
                                        child: CustomTextField(
                                          maxLength: 3,
                                          hintText: '',
                                          isShowBorder: true,
                                          inputType: TextInputType.number,
                                          inputAction: TextInputAction.next,
                                          focusNode: _phoneNumberBFocus,
                                          controller: _phoneNumberBController,
                                          isIcon: true,
                                          nextFocus: _phoneNumberCFocus,
                                          isEnabled: false,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Expanded(
                                        child: CustomTextField(
                                          maxLength: 4,
                                          hintText: '',
                                          isShowBorder: true,
                                          inputType: TextInputType.number,
                                          inputAction: TextInputAction.next,
                                          focusNode: _phoneNumberCFocus,
                                          controller: _phoneNumberCController,
                                          isIcon: true,
                                          nextFocus: _phoneNumberCFocus,
                                          isEnabled: false,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                /// End Phone Number

                                const SizedBox(height: 20),
                                /// Address
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Address', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
                                    )),
                                const SizedBox(height: 10),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child:  CustomTextField(
                                        hintText: 'EX: MONTREAL QC H3Z 2Y7',
                                        isShowBorder: true,
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.next,
                                        focusNode: _addressFocus,
                                        controller: _addressController,
                                        isIcon: true,
                                      //  isShowPrefixIcon: true,
                                       // prefixIconUrl: Images.location_icon,
                                        nextFocus: _ssnAFocus,
                                      ),
                                    )),
                                // End Address

                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text('Password ', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),

                                          const SizedBox(width: 7),

                                          Text('(Fill only if you want to change it) ',
                                              style: TextStyle(color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.7), fontSize: 14)),
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

                                      ),
                                    )),

                                const SizedBox(height: 20),

                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text('Conferma password', style: TextStyle(color: Theme.of(context).textTheme.headline2!.color, fontSize: 16)),
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

                                const SizedBox(height: 30),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: CustomButton(btnTxt: 'Update',
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();

                                        String _fullName =
                                        _fullNameController!.text.trim();

                                        String _email =
                                        _emailController!.text.trim();

                                        String _phone =
                                            '${_phoneNumberAController!.text.trim()}${_phoneNumberBController!.text.trim()}${_phoneNumberCController!.text.trim()}';


                                        String _address =
                                        _addressController!.text.trim();

                                        String _socialSecurityNumber =
                                            '${_ssnFieldAController!.text.trim()}${_ssnFieldBController!.text.trim()}${_ssnFieldCController!.text.trim()}';


                                        String _password =
                                        _passwordController!.text.trim();

                                        String _confirmPassword =
                                        _confirmPasswordController!.text.trim();

                                        if (_email.isEmpty) {
                                          showCustomSnackBar('Inserisci l\'indirizzo email', context);
                                        }else if (EmailChecker.isNotValid(_email)) {
                                          showCustomSnackBar('Inserire un\'email valida', context);
                                        }
                                        else if (_fullName.isEmpty) {
                                          showCustomSnackBar(
                                              'Enter full name',
                                              context);
                                        }
                                        else if (_socialSecurityNumber.isEmpty) {
                                          showCustomSnackBar(
                                              'Enter social security number',
                                              context);
                                        }
                                        else if (_phone.length < 10) {
                                          showCustomSnackBar(
                                              'Enter valid phone number',
                                              context);
                                        }
                                        else if (_address.isEmpty) {
                                          showCustomSnackBar(
                                              'Enter your address',
                                              context);
                                        }
                                      else {
                                          SignUpModel signUpModel = SignUpModel(
                                              name: _fullName,
                                              email: _email,
                                              password: _password,
                                              phone: _phone,
                                              address: _address,
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
