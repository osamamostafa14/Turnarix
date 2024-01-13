import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turnarix/data/model/vacation_model.dart';
import 'package:turnarix/provider/vacation_provider.dart';
import 'package:turnarix/utill/color_resources.dart';
import 'package:turnarix/view/base/custom_button.dart';
import 'package:turnarix/view/base/custom_snackbar.dart';
import 'package:turnarix/view/screens/vacation/widget/vacation_sheet.dart';

class VacationsScreen extends StatefulWidget {

  @override
  State<VacationsScreen> createState() => _VacationsScreenState();
}

class _VacationsScreenState extends State<VacationsScreen> {


  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () {
      Provider.of<VacationProvider>(context, listen: false).clearOffset();
      Provider.of<VacationProvider>(context, listen: false).getVacationsList(context, '1');
    });
  }

  @override
  Widget build(BuildContext? context) {
    return Scaffold(
      backgroundColor: ColorResources.BG_SECONDRY,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorResources.BG_SECONDRY,
        elevation: 0.0,
        title: Text('Vacanze', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () =>  Navigator.pop(context!),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (con) {
              return VacationBottomSheet();
            },
          );
        },
        tooltip: 'Aggiungere',
        backgroundColor: Theme.of(context!).primaryColor,
        child:  Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<VacationProvider>(
        builder: (context, vacationProvider, child) {
          int? vacationsLength;
          int? totalSize;
          vacationsLength = vacationProvider.vacationsLists.length;
          totalSize = vacationProvider.totalVacationSize ?? 0;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
                          child: SizedBox(
                            width: 1170,
                            //height:  MediaQuery.of(context).size.height * 0.6,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),

                                ListView.builder(
                                  // padding: const EdgeInsets.all(6),
                                  itemCount: vacationProvider.vacationsLists.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    VacationModel _vacation = vacationProvider.vacationsLists[index];

                                    deleteVacation() async {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          backgroundColor: ColorResources.BG_SECONDRY,
                                          title: Text('Sei sicuro?', style: TextStyle(color: Colors.white)),
                                          content: Text('l\'eliminazione di questo elemento festivo rimuoverà anche tutte le festività correlate nel calendario, continuare?',style: TextStyle(color: Colors.white)),
                                          actions: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 12),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                      child: CustomButton(btnTxt: 'No',
                                                        backgroundColor: Colors.grey,
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                        },
                                                      )),
                                                  const SizedBox(width: 8),

                                                  Expanded(
                                                      child: CustomButton(btnTxt: 'SÌ',
                                                          onTap:(){
                                                            Navigator.pop(context);
                                                            vacationProvider.deleteVacation(context, _vacation.id!).then((value) {
                                                              if(value.isSuccess){
                                                                vacationProvider.clearOffset();
                                                                vacationProvider.getVacationsList(context, '1');
                                                                showCustomSnackBar('Vacanza aggiunta con successo', context, isError:false);
                                                              }else{
                                                                showCustomSnackBar('qualcosa è andato storto', context);
                                                              }
                                                            });
                                                          })),
                                                  const SizedBox(width: 8),
                                                ],
                                              ),
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            // Adjust the radius as needed
                                          ),
                                        ),
                                      );
                                    }
                                    return
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20, right: 20),
                                            child: InkWell(
                                              onTap:(){
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    backgroundColor: ColorResources.BG_SECONDRY,
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            showModalBottomSheet(
                                                              context: context,
                                                              isScrollControlled: true,
                                                              backgroundColor: Colors.transparent,
                                                              builder: (con) {
                                                                return VacationBottomSheet(vacation: _vacation);
                                                              },
                                                            );
                                                          },
                                                          child: const Row(
                                                            children: [
                                                              Text('Edit', style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500
                                                              )),

                                                              Spacer(),

                                                              Icon(Icons.edit, size: 20, color: Colors.white70)
                                                            ],
                                                          ),
                                                        ),

                                                        const Padding(
                                                          padding:  EdgeInsets.only(top: 7, bottom: 7),
                                                          child: Divider(),
                                                        ),

                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            deleteVacation();
                                                          },
                                                          child: const Row(
                                                            children: [
                                                              Text('Remove', style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500
                                                              )),

                                                              Spacer(),

                                                              Icon(Icons.delete, size: 20, color: Colors.white70)
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                                    ),
                                                  ),
                                                );

                                              },
                                              child: Row(
                                                children: [

                                                  const SizedBox(width: 30),

                                                  Text('${_vacation.name}',
                                                      style: TextStyle(color: Colors.white, fontSize: 17)),

                                                  const Spacer(),

                                                  Icon(Icons.menu, color: Colors.white70),
                                                ],
                                              ),
                                            ),
                                          ),

                                          const  Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child:  Divider(color: Colors.white),
                                          )
                                        ],
                                      );
                                  },
                                ),

                                vacationProvider.bottomVacationsLoading?
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                                  ],
                                ) :
                                vacationsLength < totalSize?
                                Center(child:
                                GestureDetector(
                                    onTap: () {
                                      String offset = vacationProvider.vacationsOffset ?? '';
                                      int offsetInt = int.parse(offset) + 1;
                                      print('$offset -- $offsetInt');
                                      vacationProvider.showBottomVacationLoader();
                                      vacationProvider.getVacationsList(context, offsetInt.toString());
                                    },
                                    child: Text('Load more',style:
                                    TextStyle(color: Theme.of(context).primaryColor)))) :

                                const SizedBox(),
                              ],
                            )

                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          );
        },
      ),
    );
  }

}

