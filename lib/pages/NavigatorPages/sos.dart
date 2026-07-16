import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxiuser/functions/functions.dart';
import 'package:tagxiuser/pages/NavigatorPages/pickcontacts.dart';
import 'package:tagxiuser/pages/loadingPage/loading.dart';
import 'package:tagxiuser/pages/login/login.dart';
import 'package:tagxiuser/styles/styles.dart';
import 'package:tagxiuser/translations/translation.dart';
import 'package:tagxiuser/widgets/widgets.dart';

class Sos extends StatefulWidget {
  const Sos({Key? key}) : super(key: key);

  @override
  State<Sos> createState() => _SosState();
}

class _SosState extends State<Sos> {
  bool _isDeleting = false;
  bool _isLoading = false;
  String _deleteId = '';

  navigateLogout() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Material(
        child: ValueListenableBuilder(
            valueListenable: valueNotifierBook.value,
            builder: (context, value, child) {
              return Directionality(
                textDirection: (languageDirection == 'rtl')
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Stack(
                  children: [
                    Container(
                      height: media.height * 1,
                      width: media.width * 1,
                      color: page,
                      child: Column(
                        children: [
                          Container(
                            height: media.height / 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xfffff8db),
                                    Color(0xffffce48)
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(0.0, 0.5),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).padding.top +
                                        media.width * 0.05),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: media.width * 0.05,
                                      right: media.width * 0.05),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: textColor,
                                          )),
                                      SizedBox(
                                        width: media.width * 0.35,
                                      ),
                                      Text(
                                        languages[choosenLanguage]['text_sos'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twenty,
                                            fontWeight: FontWeight.w600,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: media.width * 0.05,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: media.width,
                                      height: media.height * 0.25,
                                      child: Image.asset(
                                        'assets/images/sosimage.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: media.width * 0.72,
                          ),
                          //add sos button
                          (sosData
                                      .where((element) =>
                                          element['user_type'] != 'admin')
                                      .length <
                                  5)
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: media.width * 0.135,
                                      bottom: media.width * 0.05,
                                      left: media.width * 0.075,
                                      right: media.width * 0.075),
                                  child: Button(
                                      onTap: () async {
                                        var nav = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PickContact()));
                                        if (nav) {
                                          setState(() {});
                                        }
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_add_trust_contact']))
                              : Container()
                        ],
                      ),
                    ),
                    Positioned(
                      top: media.width * 0.85,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    left: media.width * 0.05,
                                    right: media.width * 0.05),
                                width: media.width,
                                height: media.height / 2.2,
                                child: Column(
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_trust_contact_3'],
                                      style: GoogleFonts.roboto(
                                          fontSize: media.width * fourteen,
                                          fontWeight: FontWeight.w600,
                                          color: textColor),
                                    ),
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_trust_contact_4'],
                                      style: GoogleFonts.roboto(
                                          fontSize: media.width * twelve,
                                          color: textColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    Container(
                                      width: media.width * 0.47,
                                      height: media.width * 0.09,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffdda403)),
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: Center(
                                        child: Text(
                                          languages[choosenLanguage]
                                              ['text_yourTrustedContacts'],
                                          style: GoogleFonts.roboto(
                                              fontSize: media.width * fourteen,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xffdda403)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.025,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: media.width * 0.025,
                                            ),
                                            (sosData
                                                    .where((element) =>
                                                        element['user_type'] !=
                                                        'admin')
                                                    .isNotEmpty)
                                                ? Column(
                                                    children: sosData
                                                        .asMap()
                                                        .map((i, value) {
                                                          return MapEntry(
                                                              i,
                                                              (sosData[i]['user_type'] !=
                                                                      'admin')
                                                                  ? Container(
                                                                      padding: EdgeInsets.all(
                                                                          media.width *
                                                                              0.025),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: media.width * 0.7,
                                                                                child: Text(
                                                                                  sosData[i]['name'],
                                                                                  style: GoogleFonts.roboto(fontSize: media.width * sixteen, fontWeight: FontWeight.w600, color: textColor),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: media.width * 0.01,
                                                                              ),
                                                                              Text(
                                                                                sosData[i]['number'],
                                                                                style: GoogleFonts.roboto(fontSize: media.width * twelve, color: textColor),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  _deleteId = sosData[i]['id'];
                                                                                  _isDeleting = true;
                                                                                });
                                                                              },
                                                                              child: Icon(
                                                                                Icons.remove_circle_outline,
                                                                                color: textColor,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container());
                                                        })
                                                        .values
                                                        .toList(),
                                                  )
                                                : Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height:
                                                              media.width * 0.5,
                                                          width:
                                                              media.width * 0.7,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/nodatafound.png'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                        Text(
                                                          'No data Found',
                                                          style: GoogleFonts.roboto(
                                                              fontSize:
                                                                  media.width *
                                                                      sixteen,
                                                              color: textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),

                    //delete sos
                    (_isDeleting == true)
                        ? Positioned(
                            top: 0,
                            child: Container(
                              height: media.height * 1,
                              width: media.width * 1,
                              // color: Colors.transparent.withOpacity(0.6),
                              color: (isDarkTheme == true)
                                  ? textColor.withOpacity(0.2)
                                  : Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: media.width * 0.9,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: media.height * 0.1,
                                            width: media.width * 0.1,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: page),
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _isDeleting = false;
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel_outlined,
                                                  color: textColor,
                                                ))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(media.width * 0.05),
                                    width: media.width * 0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: page),
                                    child: Column(
                                      children: [
                                        Text(
                                          languages[choosenLanguage]
                                              ['text_removeSos'],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontSize: media.width * sixteen,
                                              color: textColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: media.width * 0.05,
                                        ),
                                        Button(
                                            onTap: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });

                                              var val =
                                                  await deleteSos(_deleteId);
                                              if (val == 'success') {
                                                setState(() {
                                                  _isDeleting = false;
                                                });
                                              } else if (val == 'logout') {
                                                navigateLogout();
                                              }
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_confirm'])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),

                    //loader
                    (_isLoading == true)
                        ? const Positioned(top: 0, child: Loading())
                        : Container()
                  ],
                ),
              );
            }),
      ),
    );
  }
}
