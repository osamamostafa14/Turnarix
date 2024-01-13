import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/response/user_info_model.dart';
import 'package:turnarix/provider/chat_provider.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/screens/chat/chat_screen.dart';

class ChatUsersListScreen extends StatefulWidget {

  @override
  _ChatUsersListScreenState createState() => _ChatUsersListScreenState();
}

class _ChatUsersListScreenState extends State<ChatUsersListScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();

  ScrollController scrollController =  ScrollController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorResources.BG_SECONDRY,
        body: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            int usersLength = chatProvider.usersList != null? chatProvider.usersList!.length : 0;
            int usersTotalSize = chatProvider.totalUsersSize ?? 0;

            return Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Center(
                        child: SizedBox(
                          width: 1170,
                          child: chatProvider.usersLoading || chatProvider.usersList == null?
                          Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))):
                          chatProvider.usersList!.length == 0?
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text('Nessun utente..', style: TextStyle(color: Colors.white)),
                            ),
                          ):
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                itemCount: chatProvider.usersList!.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  UserInfoModel _user = chatProvider.usersList![index];

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          chatProvider.resetChatList();
                                          chatProvider.getChatList(context, _user.id!);
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                              ChatScreen(employeeId: _user.id, employeeName: _user.name)));
                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            _user.image != null?
                                            Container(
                                                height: 50,
                                                width: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: Images.placeholder_rectangle,
                                                    image: '${Provider.of<SplashProvider>(context,).baseUrls!.customerImageUrl}/${_user.image}',
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                    width: 50,
                                                  ),
                                                )
                                            ) :
                                            Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.black12,
                                                ),
                                                child: const Icon(Icons.person, color: ColorResources.BG_YELLOW)
                                            ),
                                            const SizedBox(width: 20),
                                            Text('${_user.name!} ${_user.surname!}', style: const TextStyle(color: Colors.white,
                                                fontSize: 14, fontWeight: FontWeight.bold)),

                                            const Spacer(),
                                            const Icon(Icons.send, color: Colors.white60)
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                                        child: Divider(color: Colors.white60),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              // Text('$ordersLength $totalSize'),

                              chatProvider.bottomUsersLoading?
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                                ],
                              ) :
                              usersLength < usersTotalSize?
                              Center(child:
                              GestureDetector(
                                  onTap: () {
                                    String offset = chatProvider.usersOffset ?? '';
                                    int offsetInt = int.parse(offset) + 1;
                                    print('$offset -- $offsetInt');
                                    chatProvider.showBottomUsersLoader();
                                    chatProvider.getUsersList(context, offsetInt.toString());
                                  },
                                  child: Text('Load more...',style: TextStyle(color: Colors.white60)))) : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),

              ],
            );
          },
        )
    );
  }
}
