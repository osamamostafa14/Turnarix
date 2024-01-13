import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/model/chat/main_message_model.dart';
import 'package:turnarix/data/model/chat_model.dart';
import 'package:turnarix/data/model/response/user_info_model.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/chat_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:turnarix/provider/theme_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/screens/chat/chat_screen.dart';

class ChatMessagesList extends StatefulWidget {

  @override
  _ChatMessagesListState createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();

  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext? context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorResources.BG_SECONDRY,

        body: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            int? ordersLength;
            int? totalSize;
            if(chatProvider.mainMessagesList != null){
              ordersLength = chatProvider.mainMessagesList!.length;
              totalSize = chatProvider.totalMainMessagesSize ?? 0;
            }

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
                          child: chatProvider.mainMessagesLoading || chatProvider.mainMessagesList == null?
                          Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))):

                          chatProvider.mainMessagesList!.length > 0 ?
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                itemCount: chatProvider.mainMessagesList!.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  ConversationModel _mainConv = chatProvider.mainMessagesList![index];
                                  ChatModel _lastMessage = _mainConv.lastMessage!;

                                  UserInfoModel? _employee;
                                  if(_mainConv.senderId == Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.id){
                                    _employee = _mainConv.receiver;
                                  }else{
                                    _employee = _mainConv.sender;
                                  }
                                  return
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              chatProvider.resetChatList();
                                              chatProvider.getChatList(context, _employee!.id!);
                                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                                  ChatScreen(employeeId: _employee!.id, employeeName: _employee.name)));
                                            },
                                            child: Row(
                                              children: [
                                                _employee!.image != null?
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
                                                        image: '${Provider.of<SplashProvider>(context,).baseUrls!.customerImageUrl}/${_employee.image}',
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

                                                    child: const Icon(Icons.person, color: ColorResources.BG_YELLOW,)
                                                ),

                                                const SizedBox(width: 20),

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width * 0.5,
                                                          child: Text('${_employee.name!} ${_employee.surname!}',
                                                              style: const TextStyle(color: Colors.white,
                                                              fontSize: 15, fontWeight: FontWeight.bold)),
                                                        ),

                                                       // const Spacer(),

                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('${DateConverter.formatTimeString(_lastMessage.createdAt!)}',
                                                                style: const TextStyle(color: Colors.white,
                                                                    fontSize: 13, fontWeight: FontWeight.normal)),

                                                            Text('${DateConverter.monthYear(_lastMessage.createdAt!)}',
                                                                style: const TextStyle(color: Colors.white60,
                                                                fontSize: 11, fontWeight: FontWeight.normal)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    const SizedBox(height: 3),

                                                    Text('${_lastMessage.message!=null? _lastMessage.message: _lastMessage.reply}',
                                                        style:
                                                    TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 14, fontWeight: FontWeight.normal
                                                    ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          const Divider()
                                        ],
                                      );

                                    // Container(
                                    //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                    //   margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     boxShadow: [BoxShadow(
                                    //       color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300]!,
                                    //       spreadRadius: 1, blurRadius: 5,
                                    //     )],
                                    //     borderRadius: BorderRadius.circular(10),
                                    //   ),
                                    //   child: Column(children: [
                                    //    Text('Hello')
                                    //   ]),
                                    // );
                                },
                              ),
                              // Text('$ordersLength $totalSize'),

                              chatProvider.bottomMainMessagesLoading?
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                                ],
                              ) :
                              ordersLength !< totalSize!?
                              Center(child:
                              GestureDetector(
                                  onTap: () {
                                    String offset = chatProvider.mainMessagesOffset ?? '';
                                    int offsetInt = int.parse(offset) + 1;
                                    print('$offset -- $offsetInt');
                                    chatProvider.showBottomMainMessagesLoader();
                                    chatProvider.getMainMessagesList(context, offsetInt.toString());
                                  },
                                  child: Text('Carica di più...',style: TextStyle(color: Theme.of(context).primaryColor)))) : SizedBox(),
                            ],
                          ) :
                          Center(child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text('Nessuna conversazione ancora..', style: TextStyle(color: Colors.white)),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

              ],
            );
          },
        )
    );
  }
}

