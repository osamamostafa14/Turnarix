import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/chat_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/styles.dart';
import 'package:turnarix/view/screens/chat/chat_messages_list.dart';
import 'package:turnarix/view/screens/chat/chat_users_list_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  void _onTabTapped(int index) {
    print('${index}');
    if (index == 0) {
     // Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      Provider.of<ChatProvider>(context, listen: false).clearOffset();
      Provider.of<ChatProvider>(context, listen: false).getMainMessagesList(context, '1');
      Provider.of<ChatProvider>(context, listen: false).getUsersList(context, '1');
    }
  }

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: ColorResources.BG_SECONDRY,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorResources.BG_SECONDRY,
        title: Text(''),
        leading: SizedBox(),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, order, child) {
          return Column(children: [
            Center(
              child: Container(
                width: 1170,
                color: ColorResources.BG_SECONDRY,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  unselectedLabelStyle: rubikRegular.copyWith(color: ColorResources.COLOR_HINT,
                      fontSize: Dimensions.FONT_SIZE_SMALL),
                  labelStyle: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                  tabs: [
                    Tab(text: 'Messaggi'),
                    Tab(text: 'Utenti'),
                  ],
                  onTap: _onTabTapped,
                ),
              ),
            ),

            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                ChatMessagesList(), // i want to do function when i tab on this tab bar view
               ChatUsersListScreen(),
              ],
            )),
          ]);
        },
      ),
    );
  }
}