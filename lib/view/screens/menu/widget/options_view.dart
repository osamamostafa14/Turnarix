import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/response/user_info_model.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/view/screens/auth/login_screen.dart';
import 'package:turnarix/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:turnarix/view/screens/profile/personal_info_screen.dart';
import 'package:turnarix/view/screens/terms/terms_screen.dart';

class OptionsView extends StatelessWidget {
  final Function? onTap;
  OptionsView({@required this.onTap});

  @override
  Widget build(BuildContext? context) {
    final bool _isLoggedIn =
        Provider.of<AuthProvider>(context!, listen: false).isLoggedIn;


    //Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
     UserInfoModel? _userInfo;
    if(_isLoggedIn){
       _userInfo =
          Provider.of<ProfileProvider>(context, listen: false).userInfoModel;
    }

    return
      Consumer<ProfileProvider>(
        builder: (context, profileProvider, child){
          return Scrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: SizedBox(
                  width: 1170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const SizedBox(height: 15),

                      ListTile(
                        onTap: () {
                          profileProvider.resetMenuItems();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                              TermsScreen()));

                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                          //     UrlViewerScreen(url: Provider.of<SplashProvider>(context!, listen: false).configModel!.termsAndConditions)));
                        },
                        leading: Icon(Icons.local_police_rounded, color: Colors.white70),
                        title: Text(
                            'Termini & Condizioni',
                            style:  Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white
                            )),
                      ),

                      ListTile(
                        onTap: () {
                          if (_isLoggedIn) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => SignOutConfirmationDialog());
                          } else {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext? context)=> LoginScreen()));
                          }
                        },
                        leading: Icon(Icons.logout, color: Colors.white70),
                        title: Text(
                            _isLoggedIn? 'Disconnettersi' : 'Login',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white
                            )),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
