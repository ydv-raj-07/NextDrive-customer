import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxiuser/functions/functions.dart';
import 'package:tagxiuser/styles/styles.dart';
import 'package:tagxiuser/translations/translation.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              height: media.height * 1,
              width: media.width * 1,
              color: page,
              padding: EdgeInsets.fromLTRB(media.width * 0.05,
                  media.width * 0.05, media.width * 0.05, 0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  SizedBox(
                    height: media.width * 0.65,
                  ),
                ],
              ),
            ),
            Positioned(
              top: media.width * 0.088,
              child: SizedBox(
                width: media.width * 1,
                height: media.height * 0.4,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xfffff8db), Color(0xffffce48)],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.0, 0.5),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Image.asset(
                    'assets/images/aboit.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: media.width * 0.12,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: media.width * 0.035, bottom: media.width * 0.01),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: textColor,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: media.width * 0.01, right: media.width * 0.15),
                    width: media.width * 1,
                    alignment: Alignment.center,
                    child: Text(
                      languages[choosenLanguage]['text_about'],
                      style: GoogleFonts.roboto(
                          fontSize: media.width * twenty,
                          fontWeight: FontWeight.w600,
                          color: textColor),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: media.width * 0.9,
                child: Container(
                  height: media.height / 2,
                  width: media.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          openBrowser(
                              'https://nextdriveindia.com/terms-and-conditions');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: media.width * 0.05,
                              left: media.width * 0.05,
                              right: media.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]
                                      ['text_termsandconditions'],
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      fontWeight: FontWeight.w600,
                                      color: textColor),
                                ),
                              ),
                              SizedBox(
                                width: media.width * 0.28,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Color(0xff818495),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      //privacy policy
                      Padding(
                        padding: EdgeInsets.only(
                            top: media.width * 0.05,
                            left: media.width * 0.05,
                            right: media.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: media.width * 0.5,
                              child: InkWell(
                                onTap: () {
                                  openBrowser(
                                      'https://nextdriveindia.com/privacy-policy');
                                },
                                child: Text(
                                  languages[choosenLanguage]['text_privacy'],
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      fontWeight: FontWeight.w600,
                                      color: textColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.28,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Color(0xff818495),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),

                      //website url
                      InkWell(
                        onTap: () {
                          openBrowser('https://nextdriveindia.com/about-us');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: media.width * 0.05,
                              left: media.width * 0.05,
                              right: media.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_about'],
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      fontWeight: FontWeight.w600,
                                      color: textColor),
                                ),
                              ),
                              SizedBox(
                                width: media.width * 0.28,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Color(0xff818495),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
