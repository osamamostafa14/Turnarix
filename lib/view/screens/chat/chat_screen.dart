import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/chat_provider.dart';
import 'package:turnarix/provider/profile_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/utill/styles.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/screens/calendar/employee/employee_calendar_screen.dart';
import 'package:turnarix/view/screens/chat/widget/message_bubble.dart';
import 'package:turnarix/view/screens/chat/widget/send_image.dart';

class ChatScreen extends StatefulWidget {
  final int? employeeId;
  final String? employeeName;
  ChatScreen({@required this.employeeId, @required this.employeeName});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ImagePicker picker = ImagePicker();

  final TextEditingController _controller = TextEditingController();
  Timer? timer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
     timer = Timer.periodic(Duration(seconds: 5), (Timer t) => newMessage());
    newMessage();
  }
  Future<void> newMessage(){
    return Provider.of<ChatProvider>(context, listen: false)
        .getChatList(context, widget.employeeId!);
  }

  @override
  void dispose() {
    timer?.cancel();
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
        Provider.of<ChatProvider>(context, listen: false).setImage(file!);
      } else {
        print('No image selected.');
      }
    });
  }

  File? file;
  PickedFile? data;

  @override
  Widget build(BuildContext? context) {

    return Scaffold(
      backgroundColor: ColorResources.BG_SECONDRY,
      appBar: AppBar(
        title: Text('${widget.employeeName}', style: rubikMedium.copyWith(fontSize: 14,
            color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () =>  Navigator.pop(context!),
        ),
        elevation: 0.2,
        backgroundColor: ColorResources.BG_SECONDRY,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
                onTap: () {
                  Navigator.push(context!, MaterialPageRoute(builder: (BuildContext context)=>
                      EmployeeCalendarScreen(employeeId: widget.employeeId)));
                },
                child: Icon(Icons.calendar_month)),
          ),

        ],

      ),

      body:Consumer<ChatProvider>(
        builder: (context, chat, child) {
          return Column(children: [
            // chat.status!?
            // SizedBox() :
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Center(child: Text(getTranslated('status_offline', context), style: TextStyle(color: Colors.red, fontSize: 14))),
            // ),
            Expanded(
              child: RefreshIndicator(
                child: chat.chatList != null ? chat.chatList!.length > 0 ? Scrollbar(
                  child: SingleChildScrollView(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    child: Center(
                      child: SizedBox(
                        width: 1170,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          itemCount: chat.chatList!.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return MessageBubble(chat: chat.chatList![index], addDate: chat.showDate![index]);
                          },
                        ),
                      ),
                    ),
                  ),
                ) : SizedBox() : SingleChildScrollView(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  child: Center(
                    child: SizedBox(
                      width: 1170,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        itemCount: chat.savedChatList!.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return MessageBubble(chat: chat.savedChatList![index], addDate: chat.showDate![index]);
                        },
                      ),
                    ),
                  ),
                ),
                key: _refreshIndicatorKey,
                displacement: 0,
                color: ColorResources.COLOR_WHITE,
                backgroundColor: Theme.of(context).primaryColor,
                onRefresh: () {
                  return chat.getChatList(context, widget.employeeId!);
                },
              ),
            ),

            // Bottom TextField
            Center(
              child: SizedBox(
                width: 1170,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  // Provider.of<ChatProvider>(context).imageFile != null ? Padding(
                  //   padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  //   child: Stack(
                  //     clipBehavior: Clip.none, children: [
                  //    Image.file(Provider.of<ChatProvider>(context).imageFile!, height: 70, width: 70, fit: BoxFit.cover),
                  //     Positioned(
                  //       top: -2, right: -2,
                  //       child: InkWell(
                  //         onTap: () => Provider.of<ChatProvider>(context, listen: false).resetImage(),
                  //         child: const Icon(Icons.cancel, color: ColorResources.COLOR_WHITE),
                  //       ),
                  //     ),
                  //   ],
                  //   ),
                  // ) : SizedBox.shrink(),

                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 100),
                    child: Ink(
                      color: ColorResources.ULTRA_DARK_BLUE_COLOR,
                      child: Row(children: [
                        InkWell(
                          onTap: () async {
                          //  _choose();
                         //  Provider.of<ChatProvider>(context, listen: false).setImage(null);
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context) =>
                                SendImage(
                                  employeeId: widget.employeeId,
                                )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                            child: Image.asset(Images.image, width: 25, height: 25, color: ColorResources.getGreyBunkerColor(context)),
                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          height: 25,
                          child: VerticalDivider(width: 0, thickness: 1, color: ColorResources.getGreyBunkerColor(context)),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                        Expanded(
                          child: TextField(
                            controller: _controller,
                            textCapitalization: TextCapitalization.sentences,
                            style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Colors.white),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Scrivi il messaggio qui...',
                              hintStyle: rubikRegular.copyWith(color:
                              ColorResources.getGreyBunkerColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                            onChanged: (String newText) {
                              if(newText.isNotEmpty && !Provider.of<ChatProvider>(context, listen: false).isSendButtonActive!) {
                                Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                              }else if(newText.isEmpty && Provider.of<ChatProvider>(context, listen: false).isSendButtonActive!) {
                                Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                              }
                            },
                          ),
                        ),

                        InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if(Provider.of<ChatProvider>(context, listen: false).isSendButtonActive!){
                              Provider.of<ChatProvider>(context, listen: false).sendMessage(
                                _controller.text, Provider.of<AuthProvider>(context, listen: false).getUserToken(),
                                Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.id.toString(),
                                widget.employeeId!,
                                context,
                              );
                              _controller.text = '';
                            }else {
                              showCustomSnackBar('Scrivi qualcosa...', context);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                            child: Image.asset(
                              Images.send,
                              width: 25, height: 25,
                              color: Provider.of<ChatProvider>(context).isSendButtonActive! ? Theme.of(context).primaryColor : ColorResources.getGreyBunkerColor(context),
                            ),
                          ),
                        ),

                      ]),
                    ),
                  ),
                ]),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
