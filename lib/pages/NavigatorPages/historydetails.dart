import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tagxiuser/functions/functions.dart';
import 'package:tagxiuser/pages/NavigatorPages/history.dart';
import 'package:tagxiuser/pages/NavigatorPages/makecomplaint.dart';
import 'package:tagxiuser/styles/styles.dart';
import 'package:tagxiuser/translations/translation.dart';
import 'package:tagxiuser/widgets/widgets.dart';
import 'dart:ui' as ui;

import '../onTripPage/map_page.dart';

class HistoryDetails extends StatefulWidget {
  const HistoryDetails({Key? key}) : super(key: key);

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  dynamic mapPadding = 0.0;
  List myMarker = [];
  LatLng center = const LatLng(41.4219057, -102.0840772);

  dynamic pickicon;
  dynamic dropicon;

  // GlobalKey iconKey = GlobalKey();
  // GlobalKey iconDropKey = GlobalKey();

  getLocs() async {
    final Uint8List pickicon1 =
        await getBytesFromAsset('assets/images/userloc.png', 40);
    final Uint8List dropicon1 =
        await getBytesFromAsset('assets/images/droploc.png', 40);

    // if (mounted) {
    setState(() {
      pickicon = BitmapDescriptor.fromBytes(pickicon1);
      dropicon = BitmapDescriptor.fromBytes(dropicon1);
    });
    // }
    addPickDropMarker();
  }

  addPickDropMarker() async {
    setState(() {
      myMarker.add(Marker(
          markerId: const MarkerId('pointpick'),
          icon: pickicon,
          position: LatLng(myHistory[selectedHistory]['pick_lat'],
              myHistory[selectedHistory]['pick_lng'])));
    });

    setState(() {
      myMarker.add(Marker(
          markerId: const MarkerId('pointdrop'),
          icon: dropicon,
          position: LatLng(myHistory[selectedHistory]['drop_lat'],
              myHistory[selectedHistory]['drop_lng'])));
    });

    LatLngBounds bound;
    if (myHistory.isNotEmpty) {
      if (myHistory[selectedHistory]['pick_lat'] >
              myHistory[selectedHistory]['drop_lat'] &&
          myHistory[selectedHistory]['pick_lng'] >
              myHistory[selectedHistory]['drop_lng']) {
        bound = LatLngBounds(
            southwest: LatLng(myHistory[selectedHistory]['drop_lat'],
                myHistory[selectedHistory]['drop_lng']),
            northeast: LatLng(myHistory[selectedHistory]['pick_lat'],
                myHistory[selectedHistory]['pick_lng']));
      } else if (myHistory[selectedHistory]['pick_lng'] >
          myHistory[selectedHistory]['drop_lng']) {
        bound = LatLngBounds(
            southwest: LatLng(myHistory[selectedHistory]['pick_lat'],
                myHistory[selectedHistory]['drop_lng']),
            northeast: LatLng(myHistory[selectedHistory]['drop_lat'],
                myHistory[selectedHistory]['pick_lng']));
      } else if (myHistory[selectedHistory]['pick_lat'] >
          myHistory[selectedHistory]['drop_lat']) {
        bound = LatLngBounds(
            southwest: LatLng(myHistory[selectedHistory]['drop_lat'],
                myHistory[selectedHistory]['pick_lng']),
            northeast: LatLng(myHistory[selectedHistory]['pick_lat'],
                myHistory[selectedHistory]['drop_lng']));
      } else {
        bound = LatLngBounds(
            southwest: LatLng(myHistory[selectedHistory]['pick_lat'],
                myHistory[selectedHistory]['pick_lng']),
            northeast: LatLng(myHistory[selectedHistory]['drop_lat'],
                myHistory[selectedHistory]['drop_lng']));
      }
    } else {
      if (myHistory.firstWhere((element) => element.id == 'pickup').LatLng(myHistory[selectedHistory]['pick_lat'], myHistory[selectedHistory]['pick_lng']).myHistory[selectedHistory]
                  ['pick_lat'] >
              myHistory.firstWhere((element) => element.id == 'drop').LatLng(myHistory[selectedHistory]['drop_lat'], myHistory[selectedHistory]['drop_lng']).myHistory[selectedHistory]
                  ['drop_lat'] &&
          myHistory.firstWhere((element) => element.id == 'pickup').LatLng(myHistory[selectedHistory]['pick_lat'], myHistory[selectedHistory]['pick_lng']).myHistory[selectedHistory]
                  ['pick_lng'] >
              myHistory.firstWhere((element) => element.id == 'drop').LatLng(myHistory[selectedHistory]['drop_lat'], myHistory[selectedHistory]['drop_lng']).myHistory[selectedHistory]
                  ['drop_lng']) {
        bound = LatLngBounds(
            southwest: myHistory
                .firstWhere((element) => element.id == 'drop')
                .LatLng(myHistory[selectedHistory]['drop_lat'],
                    myHistory[selectedHistory]['drop_lng']),
            northeast: myHistory
                .firstWhere((element) => element.id == 'pickup')
                .LatLng(myHistory[selectedHistory]['pick_lat'],
                    myHistory[selectedHistory]['pick_lng']));
      } else if (myHistory
              .firstWhere((element) => element.id == 'pickup')
              .LatLng(myHistory[selectedHistory]['pick_lat'],
                  myHistory[selectedHistory]['pick_lng'])
              .myHistory[selectedHistory]['pick_lng'] >
          myHistory.firstWhere((element) => element.id == 'drop').LatLng(myHistory[selectedHistory]['drop_lat'], myHistory[selectedHistory]['drop_lng']).myHistory[selectedHistory]
              ['drop_lng']) {
        bound = LatLngBounds(
            southwest: LatLng(
                myHistory
                    .firstWhere((element) => element.id == 'pickup')
                    .LatLng(myHistory[selectedHistory]['pick_lat'],
                        myHistory[selectedHistory]['pick_lng'])
                    .myHistory[selectedHistory]['pick_lat'],
                myHistory
                    .firstWhere((element) => element.id == 'drop')
                    .LatLng(myHistory[selectedHistory]['drop_lat'],
                        myHistory[selectedHistory]['drop_lng'])
                    .myHistory[selectedHistory]['drop_lng']),
            northeast: LatLng(
                myHistory
                    .firstWhere((element) => element.id == 'drop')
                    .LatLng(myHistory[selectedHistory]['drop_lat'],
                        myHistory[selectedHistory]['drop_lng'])
                    .myHistory[selectedHistory]['drop_lat'],
                myHistory
                    .firstWhere((element) => element.id == 'pickup')
                    .LatLng(myHistory[selectedHistory]['pick_lat'],
                        myHistory[selectedHistory]['pick_lng'])
                    .myHistory[selectedHistory]['pick_lng']));
      } else if (myHistory
              .firstWhere((element) => element.id == 'pickup')
              .LatLng(myHistory[selectedHistory]['pick_lat'],
                  myHistory[selectedHistory]['pick_lng'])
              .myHistory[selectedHistory]['pick_lat'] >
          myHistory
              .firstWhere((element) => element.id == 'drop')
              .LatLng(myHistory[selectedHistory]['drop_lat'], myHistory[selectedHistory]['drop_lng'])
              .myHistory[selectedHistory]['drop_lat']) {
        bound = LatLngBounds(
            southwest: LatLng(
                myHistory
                    .firstWhere((element) => element.id == 'drop')
                    .LatLng(myHistory[selectedHistory]['drop_lat'],
                        myHistory[selectedHistory]['drop_lng'])
                    .myHistory[selectedHistory]['drop_lat'],
                myHistory
                    .firstWhere((element) => element.id == 'pickup')
                    .LatLng(myHistory[selectedHistory]['pick_lat'],
                        myHistory[selectedHistory]['pick_lng'])
                    .myHistory[selectedHistory]['pick_lng']),
            northeast: LatLng(
                myHistory
                    .firstWhere((element) => element.id == 'pickup')
                    .LatLng(myHistory[selectedHistory]['pick_lat'],
                        myHistory[selectedHistory]['pick_lng'])
                    .myHistory[selectedHistory]['pick_lat'],
                myHistory
                    .firstWhere((element) => element.id == 'drop')
                    .LatLng(myHistory[selectedHistory]['drop_lat'],
                        myHistory[selectedHistory]['drop_lng'])
                    .myHistory[selectedHistory]['drop_lng']));
      } else {
        bound = LatLngBounds(
            southwest: myHistory
                .firstWhere((element) => element.id == 'pickup')
                .LatLng(myHistory[selectedHistory]['pick_lat'],
                    myHistory[selectedHistory]['pick_lng']),
            northeast: myHistory
                .firstWhere((element) => element.id == 'drop')
                .LatLng(myHistory[selectedHistory]['drop_lat'],
                    myHistory[selectedHistory]['drop_lng']));
      }
    }
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bound, 50);
    _controller!.moveCamera(cameraUpdate);
    // await getPolylineshistory(
    //     pickLat: myHistory[selectedHistory]['pick_lat'],
    //     pickLng: myHistory[selectedHistory]['pick_lng'],
    //     dropLat: myHistory[selectedHistory]['drop_lat'],
    //     dropLng: myHistory[selectedHistory]['drop_lng']);
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  dynamic _controller;

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller = controller;
      _controller?.setMapStyle(mapStyle);
    });
    getLocs();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              media.width * 0.05,
              MediaQuery.of(context).padding.top + media.width * 0.05,
              media.width * 0.05,
              0),
          height: media.height * 1,
          width: media.width * 1,
          color: page,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: media.width * 0.05),
                    width: media.width * 0.9,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: textColor,
                            )),
                        SizedBox(
                          width: media.width * 0.05,
                        ),
                        Text(
                          languages[choosenLanguage]['text_tripsummary'],
                          style: GoogleFonts.roboto(
                              color: textColor,
                              fontSize: media.width * sixteen,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  //history details
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Stack(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: media.width * 0.1,
                              width: media.width * 0.2,
                              decoration: BoxDecoration(
                                  color: const Color(0xfffff7e2),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: const Color(0xffd8ad38),
                                  ),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_assigned'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * ten,
                                            color: const Color(0xffd8ad38)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.01,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: Text(
                                        '${myHistory[selectedHistory]['accepted_at'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['accepted_at'].toString().split(' ').toList()[3]}',
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * 0.032,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffd8ad38)),
                                      ),
                                    )
                                  ]),
                            ),
                            DottedLine(
                              direction: Axis.horizontal,
                              lineLength: media.width * 0.15,
                              lineThickness: 1.0,
                              dashLength: 2.0,
                              dashColor: const Color(0xffd8ad38),
                              dashRadius: 0.0,
                              dashGapLength: 1.0,
                              dashGapColor: Colors.transparent,
                              dashGapRadius: 0.0,
                            ),
                            Container(
                              height: media.width * 0.1,
                              width: media.width * 0.2,
                              decoration: BoxDecoration(
                                  color: const Color(0xfffff7e2),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: const Color(0xffd8ad38),
                                  ),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_started'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * ten,
                                            color: const Color(0xffd8ad38)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.01,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: Text(
                                        '${myHistory[selectedHistory]['trip_start_time'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['trip_start_time'].toString().split(' ').toList()[3]}',
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * 0.032,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffd8ad38)),
                                      ),
                                    )
                                  ]),
                            ),
                            DottedLine(
                              direction: Axis.horizontal,
                              lineLength: media.width * 0.15,
                              lineThickness: 1.0,
                              dashLength: 2.0,
                              dashColor: const Color(0xffd8ad38),
                              dashRadius: 0.0,
                              dashGapLength: 1.0,
                              dashGapColor: Colors.transparent,
                              dashGapRadius: 0.0,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: media.width * 0.1,
                              width: media.width * 0.2,
                              decoration: BoxDecoration(
                                  color: const Color(0xfffff7e2),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: const Color(0xffd8ad38),
                                  ),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_completed'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * ten,
                                            color: const Color(0xffd8ad38)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.01,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: Text(
                                        '${myHistory[selectedHistory]['completed_at'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['completed_at'].toString().split(' ').toList()[3]}',
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * 0.032,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffd8ad38)),
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        Positioned(
                            top: media.width * 0.029,
                            left: media.width * 0.178,
                            child: Row(children: [
                              Image.asset(
                                'assets/images/right.png',
                                height: 15,
                              ),
                              SizedBox(
                                width: media.width * 0.31,
                              ),
                              Image.asset(
                                'assets/images/right.png',
                                height: 15,
                              ),
                              SizedBox(
                                width: media.width * 0.11,
                              ),
                              Image.asset(
                                'assets/images/right.png',
                                height: 15,
                              ),
                            ]))
                      ]),
                      SizedBox(
                        height: media.width * 0.06,
                      ),

                      Container(
                        width: media.width * 0.9,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          languages[choosenLanguage]['text_location'],
                          style: GoogleFonts.roboto(
                              fontSize: media.width * sixteen,
                              color: textColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.all(media.width * 0.034),
                        height: media.width * 0.5,
                        width: media.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe4e7f4), //New
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                        // color: Colors.black,
                        child: GoogleMap(
                          padding: const EdgeInsets.all(5),
                          onMapCreated: onMapCreated,
                          compassEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: center,
                            // zoom: 0.0,
                          ),
                          markers: Set<Marker>.from(myMarker),
                          scrollGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          polylines: polylineHistory,
                          myLocationButtonEnabled: false,
                          buildingsEnabled: false,
                          zoomControlsEnabled: false,
                        ),
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.all(media.width * 0.034),
                        margin: EdgeInsets.only(
                          bottom: media.height * 0.03,
                        ),
                        height: media.width * 0.35,
                        width: media.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffe4e7f4), //New
                              blurRadius: 25.0,
                            )
                          ],
                          border: Border.all(
                            color: borderLines,
                            width: 0.7,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: media.width * 0.025,
                                  width: media.width * 0.025,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xffd8ad38)
                                          .withOpacity(0.3)),
                                  child: Container(
                                    height: media.width * 0.01,
                                    width: media.width * 0.01,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffd8ad38)),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.002,
                                    ),
                                    Container(
                                      height: media.width * 0.01,
                                      width: media.width * 0.0035,
                                      color: const Color(0xffe4e7f4),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: media.width * 0.04,
                                  width: media.width * 0.025,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xffFF0000)
                                          .withOpacity(0.3)),
                                  child: Container(
                                    height: media.width * 0.01,
                                    width: media.width * 0.01,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFF0000)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: media.width * 0.03,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: media.width * 0.75,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pickup Location',
                                        style: GoogleFonts.roboto(
                                            fontSize: 11,
                                            color: const Color(0xff818495),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.01,
                                      ),
                                      Text(
                                        myHistory[selectedHistory]
                                            ['pick_address'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: media.width * 0.75,
                                  lineThickness: 1.0,
                                  dashLength: 2.0,
                                  dashColor: const Color(0xffe4e7f4),
                                  dashRadius: 0.0,
                                  dashGapLength: 1.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                SizedBox(
                                  width: media.width * 0.75,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drop Location',
                                        style: GoogleFonts.roboto(
                                            fontSize: 11,
                                            color: const Color(0xff818495),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.01,
                                      ),
                                      Text(
                                        myHistory[selectedHistory]
                                            ['drop_address'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DottedBorder(
                            strokeCap: StrokeCap.square,
                            borderType: BorderType.Circle,
                            dashPattern: const [10, 7],
                            color: const Color(0xffd8ad38),
                            strokeWidth: 1.5,
                            child: Container(
                              alignment: Alignment.center,
                              height: media.width * 0.13,
                              width: media.width * 0.13,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                  radius: media.width * 0.17,
                                  backgroundImage: NetworkImage(
                                    myHistory[selectedHistory]['driverDetail']
                                        ['data']['profile_picture'],
                                  )),
                            ),
                          ),
                          // Container(
                          //   height: media.width * 0.13,
                          //   width: media.width * 0.13,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(
                          //           image: NetworkImage(
                          //               myHistory[selectedHistory]
                          //                       ['driverDetail']['data']
                          //                   ['profile_picture']),
                          //           fit: BoxFit.cover)),
                          // ),
                          SizedBox(
                            width: media.width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                myHistory[selectedHistory]['driverDetail']
                                        ['data']['name']
                                    .toUpperCase(),
                                style: GoogleFonts.roboto(
                                    fontSize: media.width * eighteen,
                                    fontWeight: FontWeight.bold,
                                    color: textColor),
                              ),
                              SizedBox(
                                height: media.height * 0.009,
                              ),
                              Container(
                                  height: media.width * 0.069,
                                  decoration: BoxDecoration(
                                      color: const Color(0xfffff7e2),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.fromLTRB(
                                      media.width * 0.02,
                                      media.width * 0.01,
                                      media.width * 0.02,
                                      media.width * 0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        myHistory[selectedHistory]
                                                ['ride_user_rating']
                                            .toString(),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * 0.037,
                                            color: textColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: media.width * 0.01,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffd8ad38),
                                        size: 12,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffd8ad38),
                                        size: 12,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffd8ad38),
                                        size: 12,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.height * 0.05,
                      ),
                      Container(
                        width: media.width,
                        height: media.width * 0.5,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffe4e7f4)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffe4e7f4), //New
                                blurRadius: 10.0,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: media.width*0.07,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height:media.height * 0.03,width:media.height * 0.03 ,
                                      child: Image.asset(
                                        'assets/images/reference.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.height * 0.0175,
                                    ),
                                    SizedBox(height:media.width * 0.15,width:media.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_reference'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * 0.028,
                                                fontWeight: ui.FontWeight.w400,
                                                color: const Color(0xff898989)),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.01,
                                          ),
                                          Text(
                                            myHistory[selectedHistory]
                                                ['request_number'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * fourteen,
                                                fontWeight: ui.FontWeight.bold,
                                                color: textColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                DottedLine(
                                  direction: Axis.vertical,
                                  lineLength: media.width * 0.135,
                                  lineThickness: 1.0,
                                  dashLength: 2.0,
                                  dashColor: const Color(0xffe4e7f4),
                                  dashRadius: 0.0,
                                  dashGapLength: 1.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height:media.height * 0.03,width:media.height * 0.03 ,
                                      child: Image.asset(
                                        'assets/images/type.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.height * 0.0175,
                                    ),
                                    SizedBox(height:media.width * 0.15,width:media.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_rideType'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * 0.028,
                                                fontWeight: ui.FontWeight.w400,
                                                color: const Color(0xff898989)),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.01,
                                          ),
                                          Text(
                                            (myHistory[selectedHistory]
                                                        ['is_rental'] ==
                                                    false)
                                                ? languages[choosenLanguage]
                                                    ['text_regular']
                                                : languages[choosenLanguage]
                                                    ['text_rental'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * fourteen,
                                                fontWeight: ui.FontWeight.bold,
                                                color: textColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            DottedLine(
                              direction: Axis.horizontal,
                              lineLength: media.width * 0.95,
                              lineThickness: 1.0,
                              dashLength: 2.0,
                              dashColor: const Color(0xffe4e7f4),
                              dashRadius: 0.0,
                              dashGapLength: 1.0,
                              dashGapColor: Colors.transparent,
                              dashGapRadius: 0.0,
                            ),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height:media.height * 0.03,width:media.height * 0.03 ,
                                      child: Image.asset(
                                        'assets/images/distance.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.height * 0.0175,
                                    ),
                                    SizedBox(height:media.width * 0.15,width:media.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_distance'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * 0.028,
                                                fontWeight: ui.FontWeight.w400,
                                                color: const Color(0xff898989)),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.01,
                                          ),
                                          Text(
                                            myHistory[selectedHistory]
                                                    ['total_distance'] +
                                                ' ' +
                                                myHistory[selectedHistory]
                                                    ['unit'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * fourteen,
                                                fontWeight: ui.FontWeight.bold,
                                                color: textColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                DottedLine(
                                  direction: Axis.vertical,
                                  lineLength: media.width * 0.135,
                                  lineThickness: 1.0,
                                  dashLength: 2.0,
                                  dashColor: const Color(0xffe4e7f4),
                                  dashRadius: 0.0,
                                  dashGapLength: 1.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height:media.height * 0.03,width:media.height * 0.03 ,
                                      child: Image.asset(
                                        'assets/images/duration.png',fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: media.height * 0.01,
                                    ),
                                    SizedBox(height:media.width * 0.15,width:media.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            languages[choosenLanguage]
                                                ['text_duration'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * 0.028,
                                                fontWeight: ui.FontWeight.w400,
                                                color: const Color(0xff898989)),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.01,
                                          ),
                                          Text(
                                            '${myHistory[selectedHistory]['total_time']} mins',
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * fourteen,
                                                fontWeight: ui.FontWeight.bold,
                                                color: textColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.height * 0.05,
                      ),



                          Container(height: media.width*0.1,width: media.width,decoration: BoxDecoration(
                            color: const Color(0xfff4f7f9),border: Border.all(color: const Color(0xfff4f7f9)),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xffe4e7f4), //New
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                            child: Center(
                              child: Text(
                                languages[choosenLanguage]['text_tripfare'],
                                style: GoogleFonts.roboto(
                                    fontSize: media.width * fourteen,fontWeight: ui.FontWeight.bold,
                                    color: textColor),
                              ),
                            ),
                          ),


                      SizedBox(
                        height: media.height * 0.05,
                      ),
                      (myHistory[selectedHistory]['is_rental'] == true)
                          ? Container(
                              padding:
                                  EdgeInsets.only(bottom: media.width * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    languages[choosenLanguage]
                                        ['text_ride_type'],
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * fourteen,
                                        color: textColor),
                                  ),
                                  Text(
                                    myHistory[selectedHistory]
                                        ['rental_package_name'],
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * fourteen,
                                        color: textColor),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_baseprice'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['base_price']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,fontWeight: ui.FontWeight.bold,
                                color: textColor),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_distprice'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['distance_price']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_timeprice'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['time_price']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                        ],
                      ),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['cancellation_fee'] !=
                              0)
                          ? SizedBox(
                              height: media.height * 0.02,
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['cancellation_fee'] !=
                              0)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  languages[choosenLanguage]['text_cancelfee'],
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twelve,
                                      color: const Color(0xff818495)),
                                ),
                                Text(
                                  myHistory[selectedHistory]['requestBill']
                                              ['data']
                                          ['requested_currency_symbol'] +
                                      ' ' +
                                      myHistory[selectedHistory]['requestBill']
                                              ['data']['cancellation_fee']
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twelve,
                                      color: const Color(0xff818495)),
                                ),
                              ],
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['airport_surge_fee'] !=
                              0)
                          ? SizedBox(
                              height: media.height * 0.02,
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['airport_surge_fee'] !=
                              0)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  languages[choosenLanguage]['text_surge_fee'],
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twelve,
                                      color: const Color(0xff818495)),
                                ),
                                Text(
                                  myHistory[selectedHistory]['requestBill']
                                              ['data']
                                          ['requested_currency_symbol'] +
                                      ' ' +
                                      myHistory[selectedHistory]['requestBill']
                                              ['data']['airport_surge_fee']
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twelve,
                                      color: const Color(0xff818495)),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_waiting_price'] +
                                ' (' +
                                myHistory[selectedHistory]['requestBill']
                                    ['data']['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['waiting_charge_per_min']
                                    .toString() +
                                ' x ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['calculated_waiting_time']
                                    .toString() +
                                ' mins' +
                                ')',
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['waiting_charge']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_convfee'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['admin_commision']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                        ],
                      ),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['promo_discount'] !=
                              null)
                          ? SizedBox(
                              height: media.height * 0.02,
                            )
                          : Container(),
                      (myHistory[selectedHistory]['requestBill']['data']
                                  ['promo_discount'] !=
                              null)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  languages[choosenLanguage]['text_discount'],
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twelve,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffd8ad38)),
                                ),
                                Text(
                                  myHistory[selectedHistory]['requestBill']
                                              ['data']
                                          ['requested_currency_symbol'] +
                                      ' ' +
                                      myHistory[selectedHistory]['requestBill']
                                              ['data']['promo_discount']
                                          .toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twelve,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffd8ad38)),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_taxes'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['service_tax']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff818495)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Container(
                        height: 1.5,
                        color: const Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_totalfare'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffd8ad38)),
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['total_amount']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,fontWeight: FontWeight.w600,
                                color: const Color(0xffd8ad38)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Container(
                        height: 1.5,
                        color: const Color(0xffE0E0E0),
                      ),
                      // SizedBox(height: media.height*0.02,),
                      SizedBox(
                        height: media.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [
                              SizedBox(  width: media.width * 0.06,
                                child: Image.asset(
                                  'assets/images/cash.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: media.height * 0.008,
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                   'Payment Method',
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * 0.0267,
                                        color: const Color(0xff818495)),
                                  ),
                                  Text(
                                    (myHistory[selectedHistory]['payment_opt'] == '1')
                                        ? languages[choosenLanguage]['text_cash']
                                        : (myHistory[selectedHistory]['payment_opt'] ==
                                                '2')
                                            ? languages[choosenLanguage]['text_wallet']
                                            : '',
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * 0.032,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            myHistory[selectedHistory]['requestBill']['data']
                                    ['requested_currency_symbol'] +
                                ' ' +
                                myHistory[selectedHistory]['requestBill']
                                        ['data']['total_amount']
                                    .toString(),
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twentysix,
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //make complaint button
              Container(
                padding: EdgeInsets.all(media.width * 0.05),
                child: Button(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MakeComplaint(fromPage: 1)));
                    },
                    text: languages[choosenLanguage]['text_make_complaints']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
