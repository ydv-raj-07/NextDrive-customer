import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/styles.dart';
import '../../widgets/widgets.dart';

class LanguageSelectionBottomSheet extends StatefulWidget {
  const LanguageSelectionBottomSheet({super.key});

  @override
  _LanguageSelectionBottomSheetState createState() =>
      _LanguageSelectionBottomSheetState();
}

class _LanguageSelectionBottomSheetState
    extends State<LanguageSelectionBottomSheet> {
  List<String> cities = [
    "Driver Denied Drop Location",
    "Could not find Driver",
    "Driver Not getting Closer",
    "Driver asked Him to go directly offline",
    "Driver arrived Early",
    "Wait time Was too Long",
    "Driver unresponsive on chat/call",
    "Get another ride",
    "another reason"
  ];
  var _chosenCity = "New York";

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Stack(children: [
      SingleChildScrollView(

            child: Column(
              children: [
                SizedBox(height: media.width*0.05,),
                Container(
                  padding: EdgeInsets.only(bottom: media.width * 0.025),
                  width: media.width * 1,
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel Ride',
                    style: GoogleFonts.roboto(
                        fontSize: media.width * eighteen,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: media.width * 0.025),
                  width: media.width * 1,
                  alignment: Alignment.center,
                  child: Text(
                    'Why do you want to cancel Ride ?',
                    style: GoogleFonts.roboto(
                        fontSize: media.width * fourteen,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                ),
                Column(
                  children: cities.map((city) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _chosenCity = city;
                        });
                      },
                      child: Column(
                        children: [
                          const Divider(
                            color: Color(0xffe4e7f4),
                            indent: 0,
                            endIndent: 0,
                            thickness: 0.5,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: media.width * 0.035,
                              left: media.width * 0.075,
                              right: media.width * 0.075,
                              bottom: media.width * 0.035,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  city,
                                  style: GoogleFonts.roboto(
                                    fontSize: media.width * sixteen,
                                    color: textColor,
                                  ),
                                ),
                                Container(
                                  height: media.width * 0.05,
                                  width: media.width * 0.05,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: (isDarkTheme == true)
                                          ? textColor
                                          : const Color(0xffd8ad38),
                                      width: 1.2,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: (_chosenCity == city)
                                      ? Container(
                                          height: media.width * 0.03,
                                          width: media.width * 0.03,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: (isDarkTheme == true)
                                                ? textColor
                                                : const Color(0xffd8ad38),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: media.width * 0.05),
              ],
            ),
          ),
      Positioned(top: media.width*1.05,left:media.width*0.075 ,child:   Container(color: Colors.white,height: media.width*0.15,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(width: media.width*0.35,color: const Color(0xff818495),
                onTap: ()
               {
                 Navigator.of(context).pop();
               },
                text: 'Skip'),
            SizedBox(width:media.width*0.15 ,),
            Button(width: media.width*0.35,
                onTap: ()
                {
                  Navigator.of(context).pop();
                },
                text: 'Cancel Ride'),
          ],
        ),
      ))
    ]
    );


  }
}
