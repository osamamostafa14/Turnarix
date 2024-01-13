import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/chat_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/utill/styles.dart';
import 'package:turnarix/view/base/border_button.dart';
import 'package:turnarix/view/base/custom_app_bar.dart';

class SendImage extends StatefulWidget {
  final int? employeeId;
  SendImage({this.employeeId});

  @override
  _SendImageState createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {

  TextEditingController? _messageController;

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
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();
  bool? _isLoggedIn;


  @override
  void initState() {
    super.initState();

    _choose();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext? context) {

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorResources.BG_SECONDRY,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorResources.BG_SECONDRY,
          elevation: 0.0,
          title: Text('Invia immagine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () =>  Navigator.pop(context!),
          ),
        ),
        //appBar: CustomAppBar(title: 'Invia immagine'),
        body: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            return Column(
              children: [
                const SizedBox(height: 100),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      _choose();
                    },
                    child: Container(
                      width: 250,
                      height: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorResources.DARK_BLUE,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorResources
                                .COLOR_GREY_CHATEAU,
                            width: 3),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [

                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(10),
                            child: file != null
                                ? Image.file(file!,
                                width: 250,
                                height: 250,
                                fit: BoxFit.fill)

                                : SizedBox(),
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
                                    color: Colors.white,
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Container(
                      width: 260,
                      child:
                      TextField(
                        controller: _messageController,
                        textCapitalization: TextCapitalization.sentences,
                        style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Colors.white),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Scrivi il messaggio qui...',
                          hintStyle: rubikRegular.copyWith(color: Colors.white70, fontSize: Dimensions.FONT_SIZE_LARGE),
                        ),
                      ),
                    ),

                    chatProvider.sendImageLoading?
                    Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        )) :
                    InkWell(
                      onTap: () async {
                        if(file == null)
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext? context) {
                              return AlertDialog(
                                title: Text("Avvertimento!"),
                                content: Text(
                                    "Si prega di inserire l'immagine"),
                                actions: <Widget>[
                                  Center(
                                    child: BorderButton(
                                      btnTxt: 'Vicina',
                                      textColor: Colors.red,
                                      borderColor: Colors.red,
                                      onTap: (){
                                        Navigator.of(context!).pop();
                                      },
                                    ),
                                  ),
                                  // FlatButton(
                                  //   child: Text("Close"),
                                  //   onPressed: () {
                                  //     Navigator.of(context).pop();
                                  //   },
                                  // ),
                                ],
                              );
                            },
                          );
                        } else{
                          String _finalMessage;
                          String _message  =  _messageController!.text.toString();
                          if(_message.isEmpty){
                            _finalMessage = '';
                          } else {
                            _finalMessage = _messageController!.text.trim();
                          }

                          chatProvider.sendImage(
                            context,
                            file!,
                            Provider.of<AuthProvider>(context, listen: false).getUserToken(),
                            _finalMessage,
                            widget.employeeId!,
                          ).then((value) => Navigator.of(context).pop());
                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Image.asset(
                          Images.send,
                          width: 25, height: 25,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        )
    );
  }
}
