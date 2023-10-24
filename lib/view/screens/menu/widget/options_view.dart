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

                      InkWell(
                        onTap: () {
                          profileProvider.setSelectedMenuItem('profile');
                        },
                        child: Container(
                          color: profileProvider.profileSelected? Theme.of(context).backgroundColor : Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Icon(Icons.person, color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)),
                                //     const SizedBox(width: 30),
                                //     Text(
                                //         'Profile',
                                //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                //             color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)
                                //         )),
                                //
                                //     const Spacer(),
                                //
                                //     profileProvider.profileSelected?
                                //     Transform.rotate(
                                //       angle: 90 * 3.14159265359 / 180, // 90 degrees in radians
                                //       child: Icon(
                                //         Icons.arrow_forward_ios_outlined,
                                //         color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8),
                                //         size: 20,
                                //       ),
                                //     ):
                                //     Icon(Icons.arrow_forward_ios_outlined,
                                //         color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8), size: 20),
                                //   ],
                                // ),

                                profileProvider.profileSelected?
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> PersonalInfoScreen()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 52, right: 52, top: 25),
                                    child: Text('Personal Info', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)
                                    )),
                                  ),
                                ): SizedBox(),


                                profileProvider.profileSelected?
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 52, right: 52, top: 25, bottom: 14),
                                    child: Text('Bank details', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                        color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)
                                    )),
                                  ),
                                ): SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ListTile(
                        onTap: () {
                          profileProvider.resetMenuItems();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                              TermsScreen()));

                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                          //     UrlViewerScreen(url: Provider.of<SplashProvider>(context!, listen: false).configModel!.termsAndConditions)));
                        },
                        leading: Icon(Icons.local_police_rounded, color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)),
                        title: Text(
                            'Termini & Condizioni',
                            style:  Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)
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
                        leading: Icon(Icons.logout, color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)),
                        title: Text(
                            _isLoggedIn? 'Disconnettersi' : 'Login',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).textTheme.headline2!.color!.withOpacity(0.8)
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
