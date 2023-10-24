import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/auth_provider.dart';
import 'package:turnarix/provider/shifts_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/utill/images.dart';
import 'package:turnarix/view/screens/shifts/add_shift_screen.dart';

class ShiftsScreen extends StatefulWidget {

  @override
  State<ShiftsScreen> createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorResources.COLOR_BACKGROUND,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black87,
          onPressed: () =>  Navigator.pop(context!),
        ),
      ),
      body: Consumer<ShiftsProvider>(
        builder: (context, shiftsProvider, child) => SafeArea(
          child: Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: SizedBox(
                  width: 1170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE),
                        child: Text('Sezione',  style: TextStyle(
                            color: Colors.black87,
                            fontSize: 40,
                            fontWeight: FontWeight.w500
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE, bottom: Dimensions.PADDING_SIZE_LARGE),
                        child: Text('Turni',  style: TextStyle(
                            color: Colors.black87,
                            fontSize: 40,
                            fontWeight: FontWeight.w500
                        )),
                      ),

                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 80),
                              Row(
                                children: [
                                  const SizedBox(width: 15),

                                  Image.asset(Images.day_icon, height: 32, color: Theme.of(context).primaryColor),

                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16, right: 30, bottom: 10),
                                        child: Container(
                                          height: 98,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(25),
                                            boxShadow: [BoxShadow(
                                              color: Colors.grey[200]!,
                                              blurRadius: 5, spreadRadius: 2,
                                            )],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('One day shift' ,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500
                                                )),

                                                const SizedBox(height: 10)
,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text('14 Oct 23' ,
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.normal
                                                        )),

                                                   const Spacer(),

                                                    Icon(CupertinoIcons.heart, size: 25),

                                                    const SizedBox(width: 18),

                                                    Icon(Icons.edit, size: 25),

                                                    const SizedBox(width: 18),

                                                    Icon(Icons.delete, size: 25)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        right: 30,
                        top: 0,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext? context)=>
                                AddShiftScreen()));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

