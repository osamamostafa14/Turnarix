import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/helper/date_converter.dart';
import 'package:turnarix/data/model/chat_model.dart';
import 'package:turnarix/provider/splash_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/utill/styles.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel? chat;
  final bool? addDate;
  MessageBubble({@required this.chat, @required this.addDate});

  @override
  Widget build(BuildContext? context) {
    bool isMe = chat!.reply == null;


    String dateTime = DateConverter.isoStringToLocalTimeOnly(chat!.createdAt!);
    String _date = DateConverter.isoStringToLocalDateOnly(chat!.createdAt!) == DateConverter.estimatedDate(DateTime.now()) ? 'Oggi'
        : DateConverter.isoStringToLocalDateOnly(chat!.createdAt!) == DateConverter.estimatedDate(DateTime.now().subtract(Duration(days: 1)))
        ? 'Yesterday' : DateConverter.isoStringToLocalDateOnly(chat!.createdAt!);

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        addDate! ? Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Align(alignment: Alignment.center, child: Text(_date, style: TextStyle(
            color: Colors.white70
          ), textAlign: TextAlign.center)),
        ) : SizedBox(),
        Padding(
          padding: isMe ?  EdgeInsets.fromLTRB(50, 5, 10, 5) : EdgeInsets.fromLTRB(10, 5, 50, 5),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                            bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: isMe ? Theme.of(context!).primaryColor :ColorResources.BG_YELLOW,
                        ),
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,
                                  vertical: Dimensions.PADDING_SIZE_SMALL),
                              child: Text(isMe ? chat!.message! : chat!.reply!,
                                  style: rubikRegular.copyWith(color: isMe ? ColorResources.BG_SECONDRY
                                  : ColorResources.BG_SECONDRY)),
                            ),

                            chat!.image != null ? ClipRRect(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isMe ? 10 : 0), bottomRight: Radius.circular(isMe ? 0 : 10)),
                              child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder_rectangle,
                                image: '${Provider.of<SplashProvider>(context!, listen: false).baseUrls!.chatImageUrl}/${chat!.image}',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ) : const SizedBox(),
                          ],
                        ),
                    ),
                  ),
                ],
              ),

             const SizedBox(height: 4),

              Text(dateTime, style: rubikRegular.copyWith(fontSize: 8, color: ColorResources.COLOR_GREY_BUNKER)),
            ],
          ),
        ),
      ],
    );
  }
}
