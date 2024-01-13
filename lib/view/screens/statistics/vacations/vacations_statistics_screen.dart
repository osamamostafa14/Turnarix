// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:turnarix/provider/vacation_provider.dart';
// import 'package:turnarix/utill/dimensions.dart';
//
// class VacationStatisticsScreen extends StatefulWidget {
//
//   @override
//   _VacationStatisticsScreenState createState() => _VacationStatisticsScreenState();
// }
//
// class _VacationStatisticsScreenState extends State<VacationStatisticsScreen> {
//   final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
//   GlobalKey<ScaffoldMessengerState>();
//
//   ScrollController scrollController =  ScrollController();
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext? context) {
//
//     return Scaffold(
//         key: _scaffoldKey,
//
//         body: Consumer<VacationProvider>(
//           builder: (context, vacationProvider, child) {
//             int? ordersLength;
//             int? totalSize;
//             if(ordersProvider.runningOrdersList != null){
//               ordersLength = ordersProvider.runningOrdersList!.length;
//               totalSize = ordersProvider.totalRunningOrdersSize ?? 0;
//             }
//
//             return Column(
//               children: [
//                 Expanded(
//                   child: Scrollbar(
//                     child: SingleChildScrollView(
//                       controller: scrollController,
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                       child: Center(
//                         child: SizedBox(
//                           width: 1170,
//                           child: ordersProvider.runningOrdersIsLoading?
//                           Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))):
//
//                           ordersProvider.runningOrdersList!.length > 0 ?
//                           Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               ListView.builder(
//                                 padding: const EdgeInsets.all(6),
//                                 itemCount: ordersProvider.runningOrdersList!.length,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   OrderModel _order = ordersProvider.runningOrdersList![index];
//                                   double _percentageAmount = 0.0;
//                                   if(_order.additionalPercentage != null && _order.price!=null){
//                                     _percentageAmount = (_order.additionalPercentage !* _order.price!) / 100;
//                                   }
//
//                                   String? orderType;
//                                   if(_order.orderStatus == 'pending' || _order.orderStatus == 'on_the_way'){
//                                     orderType = 'pickup';
//                                   }else{
//                                     orderType = 'dropoff';
//                                   }
//                                   FocusNode _messageFocus = FocusNode();
//                                   TextEditingController? _messageController = TextEditingController();
//
//                                   void _sendMessage() async {
//                                     ResponseModel _response = await ordersProvider.sendMessage(
//                                         context, _messageController.text.trim(), _order.id);
//                                     if(_response.isSuccess){
//                                       showCustomSnackBar('Message sent!', context, isError: false);
//                                       ordersProvider.clearOffset();
//                                       ordersProvider.getRunningOrdersList(context, '1');
//                                     }
//                                   }
//
//                                   Color _statusColor = Colors.black54;
//                                   if(_order.orderStatus == 'pending'){
//                                     _statusColor = Colors.orange;
//                                   }else if(_order.orderStatus == 'Confirmared'){
//                                     _statusColor = Colors.blueAccent;
//                                   }else if(_order.orderStatus == 'on_the_way'){
//                                     _statusColor = Colors.orange;
//                                   }
//                                   else if(_order.orderStatus == 'delivered'){
//                                     _statusColor = Colors.green;
//                                   }
//                                   else if(_order.orderStatus == 'canceled'){
//                                     _statusColor = Colors.red;
//                                   }
//                                   else if(_order.orderStatus == 'pickup_loaded'){
//                                     _statusColor = Colors.orange;
//                                   }
//                                   else if(_order.orderStatus == 'arrived_to_pickup'){
//                                     _statusColor = Colors.cyan;
//                                   }else if(_order.orderStatus == 'arrived_to_dropoff'){
//                                     _statusColor = Colors.cyan;
//                                   }else if(_order.orderStatus == 'delivery_in_progress'){
//                                     _statusColor = Colors.orange;
//                                   }else if(_order.orderStatus == 'finished'){
//                                     _statusColor = Colors.green;
//                                   }
//
//                                   return
//                                     Stack(
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                                           margin: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             boxShadow: [BoxShadow(
//                                               color: Colors.grey[300]!,
//                                               spreadRadius: 1, blurRadius: 5,
//                                             )],
//                                             borderRadius: BorderRadius.circular(15),
//                                           ),
//                                           child: Column(children: [
//                                             Row(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//
//                                                 const SizedBox(width: 10),
//
//                                                 Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     SizedBox(
//                                                       width: MediaQuery.of(context).size.width * 0.36,
//                                                       child: Text('Elementos',
//                                                           maxLines: 2, overflow: TextOverflow.ellipsis,
//                                                           style: TextStyle(fontSize: 18,
//                                                               fontWeight: FontWeight.w500, color: Colors.black87)),
//                                                     ),
//
//                                                     const SizedBox(height: 6),
//
//                                                     InkWell(
//                                                       onTap: () {
//                                                         ordersProvider.updateSelectedOrders(_order.id!);
//                                                       },
//                                                       child: Row(
//                                                         children: [
//                                                           SizedBox(
//                                                             width: MediaQuery.of(context).size.width * 0.7,
//                                                             child: Row(
//                                                               children: [
//                                                                 Text('Estado:',
//                                                                     maxLines: 2, overflow: TextOverflow.ellipsis,
//                                                                     style: TextStyle(fontSize: 15,
//                                                                         fontWeight: FontWeight.normal, color: Colors.black87)),
//
//                                                                 Text(' ${Helpers.statusConverter(_order.orderStatus!)}',
//                                                                     overflow: TextOverflow.ellipsis,
//                                                                     style: TextStyle(fontSize: 15,
//                                                                         fontWeight: FontWeight.w500, color: _statusColor)),
//                                                               ],
//                                                             ),
//                                                           ),
//
//                                                           ordersProvider.selectedOrders.contains(_order.id)?
//                                                           Icon(Icons.arrow_drop_up, size: 30):
//                                                           Icon(Icons.arrow_drop_down, size: 30)
//                                                         ],
//                                                       ),
//                                                     ),
//
//                                                     ordersProvider.selectedOrders.contains(_order.id)?
//                                                     Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           children: [
//                                                             const Text('Precio total:',
//                                                                 style: TextStyle(fontSize: 16,
//                                                                     fontWeight: FontWeight.normal, color: Colors.black54)),
//
//                                                             const SizedBox(width: 10),
//
//                                                             Text(_order.price!=null? '\$${_order.price !+ _percentageAmount}': 'No establecido',
//                                                                 style: const TextStyle(
//                                                                     fontSize: 16,
//                                                                     fontWeight: FontWeight.w500,
//                                                                     color: Colors.black87)),
//                                                           ],
//                                                         ),
//
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 8, bottom: 8),
//                                                           child: Container(
//                                                             height: 0.7,
//                                                             width: MediaQuery.of(context).size.width * 0.8,
//                                                             decoration: BoxDecoration(
//                                                                 color: Colors.black26
//                                                             ),
//                                                           ),
//                                                         ),
//
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 90,
//                                                               child: const Text('Conductora:',
//                                                                   style: TextStyle(fontSize: 16,
//                                                                       fontWeight: FontWeight.normal, color: Colors.black54)),
//                                                             ),
//
//
//                                                             Text(_order.driver!=null? '${_order.driver!.fullName}': 'Aún no asignado',
//                                                                 style: const TextStyle(
//                                                                     fontSize: 16,
//                                                                     fontWeight: FontWeight.w500,
//                                                                     color: Colors.black87)),
//                                                           ],
//                                                         ),
//
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 8, bottom: 8),
//                                                           child: Container(
//                                                             height: 0.7,
//                                                             width: MediaQuery.of(context).size.width * 0.8,
//                                                             decoration: BoxDecoration(
//                                                                 color: Colors.black26
//                                                             ),
//                                                           ),
//                                                         ),
//
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 90,
//                                                               child: const Text('Levantar:',
//                                                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54)),
//                                                             ),
//
//                                                             SizedBox(
//                                                               width: 230,
//                                                               child: Text('${_order.pickupAddress}',
//                                                                   style: const TextStyle(fontSize: 16,
//                                                                       fontWeight: FontWeight.w500, color: Colors.black87)),
//                                                             ),
//                                                           ],
//                                                         ),
//
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 8, bottom: 8),
//                                                           child: Container(
//                                                             height: 0.7,
//                                                             width: MediaQuery.of(context).size.width * 0.8,
//                                                             decoration: BoxDecoration(
//                                                                 color: Colors.black26
//                                                             ),
//                                                           ),
//                                                         ),
//
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 80,
//                                                               child: const Text('Dejar:',
//                                                                   style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal,
//                                                                       color: Colors.black54)),
//                                                             ),
//
//                                                             const SizedBox(width: 10),
//
//                                                             SizedBox(
//                                                               width: 230,
//                                                               child: Text('${_order.dropOffAddress}',
//                                                                   style: const TextStyle(fontSize: 16,
//                                                                       fontWeight: FontWeight.w500, color: Colors.black87)),
//                                                             ),
//                                                           ],
//                                                         ),
//
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 8, bottom: 8),
//                                                           child: Container(
//                                                             height: 0.7,
//                                                             width: MediaQuery.of(context).size.width * 0.8,
//                                                             decoration: BoxDecoration(
//                                                                 color: Colors.black26
//                                                             ),
//                                                           ),
//                                                         ),
//
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 80,
//                                                               child: const Text('Cita agendada:',
//                                                                   style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal,
//                                                                       color: Colors.black54)),
//                                                             ),
//
//                                                             const SizedBox(width: 10),
//
//                                                             SizedBox(
//                                                               width: 230,
//                                                               child: Text('${DateConverter.monthYear(_order.scheduledDate!)}',
//                                                                   style: const TextStyle(fontSize: 16,
//                                                                       fontWeight: FontWeight.w500, color: Colors.black87)),
//                                                             ),
//                                                           ],
//                                                         ),
//
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 8, bottom: 8),
//                                                           child: Container(
//                                                             height: 0.7,
//                                                             width: MediaQuery.of(context).size.width * 0.8,
//                                                             decoration: const BoxDecoration(
//                                                                 color: Colors.black26
//                                                             ),
//                                                           ),
//                                                         ),
//
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: 80,
//                                                               child: const Text('Elementos',
//                                                                   style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal,
//                                                                       color: Colors.black54)),
//                                                             ),
//
//                                                             const SizedBox(width: 10),
//
//                                                             InkWell(
//                                                               onTap:(){
//                                                                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                                                                     OrderItemsScreen(items: _order.itemsDetails)));
//                                                               },
//                                                               child: SizedBox(
//                                                                 width: 230,
//                                                                 child: Row(
//                                                                   children: [
//                                                                     Text('Mostrar elementos',
//                                                                         style: TextStyle(fontSize: 16,
//                                                                             fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
//
//                                                                     Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor, size: 18)
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//
//                                                         Padding(
//                                                           padding: const EdgeInsets.only(top: 8, bottom: 8),
//                                                           child: Container(
//                                                             height: 0.7,
//                                                             width: MediaQuery.of(context).size.width * 0.8,
//                                                             decoration: const BoxDecoration(
//                                                                 color: Colors.black26
//                                                             ),
//                                                           ),
//                                                         ),
//
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           children: [
//                                                             Text('${_order.distance} - ',
//                                                                 style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal,
//                                                                     color: Colors.black54)),
//
//                                                             Text('${_order.duration}',
//                                                                 style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal,
//                                                                     color: Colors.black54))
//                                                           ],
//                                                         ),
//                                                         const SizedBox(height: 15)
//                                                       ],
//                                                     ): const SizedBox()
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                             ordersProvider.selectedOrders.contains(_order.id)?
//                                             const SizedBox(height: 0): const SizedBox(height: 20),
//
//                                             _order.orderStatus!='delivered'?
//                                             SizedBox(
//                                               height: 50,
//                                               child: Row(children: [
//                                                 Expanded(child: TextButton(
//                                                   style: TextButton.styleFrom(
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(10),
//                                                       side: BorderSide(width: 1, color: ColorResources.DISABLE_COLOR),
//                                                     ),
//                                                     minimumSize: Size(1, 50),
//                                                     padding: EdgeInsets.all(0),
//                                                   ),
//                                                   onPressed: () {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (BuildContext? context) {
//                                                         return AlertDialog(
//                                                           title: Text('Estas segura?',
//                                                               style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
//                                                           content: Text('cancelar orden',
//                                                               style: const TextStyle(fontSize: 13)),
//                                                           actions: [
//                                                             Row(
//                                                               mainAxisAlignment: MainAxisAlignment.center,
//                                                               children: [
//                                                                 BorderButton(
//                                                                   onTap: () {
//                                                                     Navigator.pop(context);
//                                                                   },
//                                                                   btnTxt: 'No',
//                                                                   borderColor: Colors.black26,
//                                                                 ),
//
//                                                                 const SizedBox(width: 10),
//
//                                                                 BorderButton(
//                                                                   onTap: () {
//                                                                     Navigator.pop(context);
//                                                                     ordersProvider.updateOrderStatus('canceled', _order.id!).then((value) {
//                                                                       ordersProvider.clearOffset();
//                                                                       ordersProvider.getRunningOrdersList(context, '1');
//                                                                       ordersProvider.getHistoryOrdersList(context, '1');
//                                                                       showCustomSnackBar('Orden cancelada', _scaffoldKey.currentContext!, isError: false);
//                                                                     });
//                                                                   },
//                                                                   btnTxt: 'Sí',
//                                                                   borderColor: Colors.black26,
//                                                                 ),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         );
//                                                       },
//                                                     );
//                                                   },
//                                                   child: Text('Cancelar',
//                                                       style: Theme.of(context).textTheme.headline3!.copyWith(
//                                                         color: ColorResources.DISABLE_COLOR,
//                                                         fontSize: Dimensions.FONT_SIZE_LARGE,
//                                                       )),
//                                                 )),
//
//                                                 const SizedBox(width: 10),
//
//                                                 _order.driverId!=null && _order.orderStatus!='delivered'?
//                                                 Expanded(child: TextButton(
//                                                   style: TextButton.styleFrom(
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(10),
//                                                       side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
//                                                     ),
//                                                     minimumSize: const Size(1, 50),
//                                                     padding: const EdgeInsets.all(0),
//                                                   ),
//                                                   onPressed: () {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (context) {
//                                                         return StatefulBuilder(
//                                                           builder: (context, setState) {
//                                                             return AlertDialog(
//                                                               shape: RoundedRectangleBorder(
//                                                                 borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
//                                                               ),
//                                                               //title: Text("Hint", style: TextStyle(color: Theme.of(context!).primaryColor, fontSize: 15)),
//                                                               content: Column(
//                                                                 mainAxisSize: MainAxisSize.min,
//                                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                                 children: [
//                                                                   const Text('Enviar mensaje a la conductora', style: TextStyle(fontSize: 17)),
//
//                                                                   const SizedBox(height: 8),
//
//                                                                   CustomTextField(
//                                                                     maxLength: 200,
//                                                                     hintText: 'Escribe mensaje aquí',
//                                                                     isShowBorder: true,
//                                                                     inputType: TextInputType.text,
//                                                                     inputAction: TextInputAction.next,
//                                                                     focusNode: _messageFocus,
//                                                                     controller: _messageController,
//                                                                     // isIcon: true,
//                                                                   ),
//
//                                                                   const SizedBox(height: 15),
//
//                                                                   ordersProvider.sendMessageLoading?
//                                                                   Center(
//                                                                       child: CircularProgressIndicator(
//                                                                         valueColor: AlwaysStoppedAnimation<Color>(
//                                                                             Theme.of(context).primaryColor),
//                                                                       )):
//                                                                   CustomButton(btnTxt: 'Confirmar',
//                                                                     onTap: () async {
//                                                                       if(_messageController.text.trim().isEmpty){
//                                                                         showCustomSnackBar('El campo está vacío', context);
//                                                                       }else{
//                                                                         _sendMessage();
//                                                                         Navigator.pop(context);
//                                                                       }
//                                                                     },
//                                                                   ),
//
//                                                                   _order.messages!.length > 0?
//                                                                   const SizedBox(height: 20): const SizedBox(height: 0),
//
//                                                                   _order.messages!.length > 0?
//                                                                   InkWell(
//                                                                     onTap: () {
//                                                                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                                                                           MessagesScreen(messages: _order.messages)));
//                                                                     },
//                                                                     child: Row(
//                                                                       mainAxisAlignment: MainAxisAlignment.end,
//                                                                       children: [
//                                                                         Text('Mensajes enviados', style: TextStyle(
//                                                                             color: Theme.of(context).primaryColor,
//                                                                             fontSize: 15,
//                                                                             fontWeight: FontWeight.normal
//                                                                         )),
//
//                                                                         const SizedBox(width: 5),
//
//                                                                         Icon(Icons.message,
//                                                                             color: Theme.of(context).primaryColor,
//                                                                             size: 14)
//                                                                       ],
//                                                                     ),
//                                                                   ): const SizedBox()
//                                                                 ],
//                                                               ),
//                                                             );
//                                                           },
//                                                         );
//                                                       },
//                                                     );
//                                                   },
//                                                   child: Text('Mensaje',
//                                                       style: Theme.of(context).textTheme.headline3!.copyWith(
//                                                         color: Theme.of(context).primaryColor,
//                                                         fontSize: Dimensions.FONT_SIZE_LARGE,
//                                                       )),
//                                                 )): const SizedBox(),
//
//                                                 const SizedBox(width: 10),
//
//                                                 _order.driverId!=null && _order.orderStatus!='delivered'?
//                                                 Expanded(child: TextButton(
//                                                   style: TextButton.styleFrom(
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(10),
//                                                       side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
//                                                     ),
//                                                     minimumSize: const Size(1, 50),
//                                                     padding: const EdgeInsets.all(0),
//                                                   ),
//                                                   onPressed: () {
//                                                     Provider.of<TrackingProvider>(context, listen: false).addOriginMarker(
//                                                         LatLng(double.parse(_order.pickupLatitude!), double.parse(_order.pickupLongitude!))
//                                                     );
//                                                     Provider.of<TrackingProvider>(context, listen: false).getDriverLocation(
//                                                         context, _order.driverId!, _order.id!, orderType!).then((value) {
//                                                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                                                           OrderTrackingScreen(order: _order)));
//                                                     });
//                                                   },
//                                                   child: Text('Pista',
//                                                       style: Theme.of(context).textTheme.headline3!.copyWith(
//                                                         color: Theme.of(context).primaryColor,
//                                                         fontSize: Dimensions.FONT_SIZE_LARGE,
//                                                       )),
//                                                 )): const SizedBox(),
//
//
//                                               ]),
//                                             ): const SizedBox(),
//
//                                             _order.orderStatus! == 'pending'?
//                                             const SizedBox(height: 14): const SizedBox(),
//
//                                             _order.orderStatus! == 'pending'?
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.end,
//                                               children: [
//                                                 InkWell(
//                                                     onTap:(){
//                                                       ordersProvider.getDriverRequestsList(context, _order.id!, true, true);
//                                                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                                                           DriversOffersScreen(order: _order)));
//                                                     },
//                                                     child: Text('Solicitudes de conductores',
//                                                         style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16))),
//
//                                                 const SizedBox(width: 8),
//
//                                                 InkWell(
//                                                     onTap:(){
//                                                       ordersProvider.getDriverRequestsList(context, _order.id!, true, true);
//                                                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                                                           DriversOffersScreen(order: _order)));
//                                                     },
//                                                     child: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor, size: 18))
//                                               ],
//                                             ): const SizedBox(),
//
//                                             _order.orderStatus == 'delivered' && _order.paymentStatus == 'unpaid'
//                                                 && _order.paymentAgainstDelivery == 0?
//                                             CustomButton(btnTxt: 'Pagar',
//                                                 onTap: (){
//                                                   String paymentLink = '${AppConstants.BASE_URL}/${Provider.of<SplashProvider>(context, listen: false).baseUrls!.paymentUrl}?ref_code=${_order.referenceCode}';
//
//                                                   print('paymentLink=> ${paymentLink}');
//
//                                                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
//                                                       EpaycoPaymentScreen(orderReference: _order.referenceCode, url: paymentLink)));
//
//
//                                                 }): const SizedBox(),
//
//                                             const SizedBox(height: 8),
//                                           ]),
//                                         ),
//
//                                         Positioned(
//                                           top: 0,
//                                           right: 0,
//                                           child: Container(
//                                             width: 60,
//                                             height: 25,
//                                             decoration: BoxDecoration(
//                                               color: Theme.of(context).primaryColor,
//                                               borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(15),
//                                                 bottomLeft: Radius.circular(5),
//                                               ),),
//
//                                             child: Center(
//                                               child: Text(
//                                                 'ID: #${_order.id.toString()}',
//                                                 style: rubikMedium.copyWith(color: ColorResources.COLOR_WHITE, fontSize: 14),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     );
//                                 },
//                               ),
//                               // Text('$ordersLength $totalSize'),
//
//                               ordersProvider.bottomRunningOrdersLoading?
//                               Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
//                                 ],
//                               ) :
//                               ordersLength !< totalSize!?
//                               Center(child:
//                               GestureDetector(
//                                   onTap: () {
//                                     String offset = ordersProvider.runningOrdersOffset ?? '';
//                                     int offsetInt = int.parse(offset) + 1;
//                                     print('$offset -- $offsetInt');
//                                     ordersProvider.showBottomRunningOrdersLoader();
//                                     ordersProvider.getRunningOrdersList(context, offsetInt.toString());
//                                   },
//                                   child: Text('carga más',style:
//                                   TextStyle(color: Theme.of(context).primaryColor)))) :
//
//                               const SizedBox(),
//                             ],
//                           ) :
//                           Padding(
//                             padding: const EdgeInsets.only(top: 30),
//                             child: Center(child: Text('Aún no hay pedidos')),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//               ],
//             );
//           },
//         )
//     );
//   }
//
//
// }
//
