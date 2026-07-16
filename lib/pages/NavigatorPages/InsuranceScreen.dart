import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxiuser/styles/styles.dart';

class insurance extends StatefulWidget {
  const insurance({super.key});

  @override
  State<insurance> createState() => _insuranceState();
}

class _insuranceState extends State<insurance> {

  @override
  Widget build(BuildContext context) {
    var media= MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
          alignment: Alignment.center,
          children: [
      Positioned(
      child: Container(
      padding: EdgeInsets.fromLTRB(media.width * 0.05,
          media.width * 0.05, media.width * 0.05, 0),
      height: media.height * 1,
      width: media.width * 1,
      color: page,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).padding.top),
          Stack(
            children: [
              // Positioned(
              //     top: 10,
              //     child:
              //           Image.asset('assets/images/bg.png',
              //           ),
              // ),
              Container(
                padding: EdgeInsets.only(
                    bottom: media.width * 0.05),
                width: media.width * 1,
                alignment: Alignment.center,
                child: Text(
                  'Insurance',
                  style: GoogleFonts.roboto(
                      fontSize: media.width * twenty,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
              ),
              Positioned(
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: textColor,
                      )))
            ],
          ),
          SizedBox(
            height: media.width * 0.05,
          ),
          Expanded(child: Center(child: Text('We are Following All the norms of Motorvehicle Act 2023 and this policy will be the updated soon.',style: GoogleFonts.roboto(
              fontSize: media.width * twenty,
              fontWeight: FontWeight.w600,
              color: textColor),textAlign:TextAlign.center,)))

        ],
      ),
    ))]));

  }
}
