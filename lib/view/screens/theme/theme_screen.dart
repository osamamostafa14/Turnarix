import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/provider/theme_provider.dart';
import 'package:turnarix/utill/dimensions.dart';
import 'package:turnarix/view/base/custom_dropdownfield.dart';

class ThemeScreen extends StatefulWidget {

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  final TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: Theme.of(context!).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Themes', style: Theme.of(context).textTheme.bodyText1!
            .copyWith(color: Theme.of(context).primaryColor)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          onPressed: () =>  Navigator.pop(context),
        ),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          List<String> _optionList = [
            'Small',
            'Medium',
            'Large'
          ];



          return SafeArea(
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  themeProvider.setPrimaryColor('red');
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 2, color: themeProvider.primaryColor == 'red'? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                                  ),
                                  child: Center(child: Text('Red',
                                      style: Theme.of(context).textTheme.bodyText1!
                                          .copyWith(color: themeProvider.primaryColor == 'red'? Theme.of(context).primaryColor :
                                      Theme.of(context).textTheme.headline2!.color))),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  themeProvider.setPrimaryColor('blue');
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 2, color: themeProvider.primaryColor == 'blue'? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                                  ),
                                  child: Center(child: Text('Blue',
                                      style: Theme.of(context).textTheme.bodyText1!
                                          .copyWith(color: themeProvider.primaryColor == 'blue'? Theme.of(context).primaryColor :
                                      Theme.of(context).textTheme.headline2!.color))),
                                ),
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  themeProvider.setPrimaryColor('yellow');
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 2,
                                        color: themeProvider.primaryColor == 'yellow'? Theme.of(context).primaryColor :
                                        Theme.of(context).hintColor),
                                  ),
                                  child: Center(child: Text('Yellow',
                                      style: Theme.of(context).textTheme.bodyText1!
                                          .copyWith(color: themeProvider.primaryColor == 'yellow'? Theme.of(context).primaryColor :
                                      Theme.of(context).textTheme.headline2!.color))),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 50),

                        CustomDropDownField(
                          title: 'Select Font Size',
                          optionsList: _optionList,
                          isCallback: true,
                          controller: valueController,
                          callbackFunction: (int valueIndex) {
                            if(valueIndex == 0){
                              themeProvider.setFontSize('small');
                            }else if(valueIndex == 1){
                              themeProvider.setFontSize('medium');
                            }else if(valueIndex == 2){
                              themeProvider.setFontSize('large');
                            }
                            print('hey: ${valueIndex}');
                          },
                          hintText: 'Select Font Size',
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

