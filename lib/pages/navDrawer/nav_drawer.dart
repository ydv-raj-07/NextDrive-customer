import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translations/translation.dart';
import '../NavigatorPages/InsuranceScreen.dart';
import '../NavigatorPages/about.dart';
import '../NavigatorPages/editprofile.dart';
import '../NavigatorPages/faq.dart';
import '../NavigatorPages/favourite.dart';
import '../NavigatorPages/history.dart';
import '../NavigatorPages/makecomplaint.dart';
import '../NavigatorPages/notification.dart';
import '../NavigatorPages/referral.dart';
import '../NavigatorPages/selectlanguage.dart';
import '../NavigatorPages/sos.dart';
import '../NavigatorPages/walletpage.dart';
import '../onTripPage/map_page.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return  Container(height: media.height*1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menu.png'),
          ),
        ),
        width: media.width * 0.8,
        child: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Drawer(
              child:
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
              SizedBox(
                  width: media.width,
                  height: media.height / 3.5,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/menu.png'),
                        fit: BoxFit.fill,
                      ),
                    ),

                    // padding: EdgeInsets.all(1),
                    // decoration: const BoxDecoration(
                    //   color: Color(0xff818495),

                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: media.width * 0.1,
                          //height: media.height/10,
                        ),

                        DottedBorder(strokeCap: StrokeCap.square,
                          borderType: BorderType.Circle,
                          dashPattern: const [10, 7],
                          color:const Color(0xffd8ad38),
                          strokeWidth: 1.5,
                          child:Container(
                            alignment: Alignment.center,
                            height: media.width * 0.17,
                            width: media.width * 0.17,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,

                            ),
                            child:
                            CircleAvatar(
                              radius: media.width * 0.17,backgroundImage: NetworkImage(
                              userDetails['profile_picture'],
                            )

                            )
                             ,
                          ),
                        ),

                        Text(
                          userDetails['name'],
                          style: GoogleFonts.roboto(
                              fontSize: media.width * twenty,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                        ),

                        // SizedBox(
                        //   width: media.width * 0.1,
                        // ),
                        // InkWell(
                        //
                        //   child: Icon(
                        //     Icons.arrow_forward_ios_rounded,
                        //     size: media.width * eighteen,
                        //     color: Colors.black,
                        //   ),
                        // )
                        SizedBox(
                          height: media.width * 0.020,
                          //height: media.height/10,
                        ),
                        Text(
                          userDetails['email'],
                          style: GoogleFonts.roboto(
                              fontSize: media.width * fourteen,
                              color: Colors.black,fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: media.width * 0.024,
                          //height: media.height/10,
                        ),
                        InkWell(onTap: () async {
                          var val = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const EditProfile()));
                          if (val) {
                            setState(() {});
                          }
                        },
                          child:
                          Container(
                            height: media.width * 0.11,
                            width: media.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: media.width * 0.05,
                                      width: media.width * 0.05,
                                      child: Image.asset(
                                    'assets/images/menu1.png',
                                    fit: BoxFit.fill,
                                  )),
                                   SizedBox(width:media.width * 0.035,),
                                   Text('Edit Profile', style: GoogleFonts.roboto(fontSize: media.width * fourteen,
                                      color:
                                      const Color(0xffd8ad38),
                                      fontWeight:
                                      FontWeight
                                          .w600),)
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
              ),
              Container(
                  padding: EdgeInsets.only(top: media.width * 0.05,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //notification
                      ValueListenableBuilder(
                          valueListenable: valueNotifierNotification.value,
                          builder: (context, value, child) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationPage()));
                                setState(() {
                                  userDetails['notifications_count'] = 0;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: media.width * 0.01,
                                      ),
                                      const Icon(
                                          Icons.notification_important_rounded,color: Color(0xff818495),size: 22),
                                      SizedBox(
                                        width: media.width * 0.085,
                                      ),
                                      SizedBox(
                                        width: media.width * 0.5,
                                        child: Text(
                                          languages[choosenLanguage]
                                                  ['text_notification']
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                              fontSize: media.width * fourteen,
                                              color:const Color(0xff818495) ),
                                        ),
                                      ),
                                      const Icon(
                                          Icons.navigate_next,color: Color(0xff818495),size: 20),

                                    ],
                                  ),

                                  (userDetails['notifications_count'] == 0)
                                      ? Container()
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: buttonColor,
                                          ),
                                          child: Text(
                                            userDetails['notifications_count']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * fourteen,
                                                color: buttonText),
                                          ),
                                        )
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),

                      //history
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const History()));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only( left: 5.4),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: media.width * 0.025,
                              ),
                              Image.asset(
                                'assets/images/yourride.png',
                                fit: BoxFit.contain,
                                width: media.width * 0.055,height:media.width * 0.055 ,
                              ),
                              SizedBox(
                                width: media.width * 0.085,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_enable_history'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color: const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),

                      //wallet page
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WalletPage()));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.wallet_rounded,color:  Color(0xff818495),size: 20),
                              // Image.asset(
                              //   'assets/images/walletIcon.png',
                              //   fit: BoxFit.contain,
                              //   width: media.width * 0.075,
                              // ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_enable_wallet'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),

                      //referral page
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReferralPage()));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only( left: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/refer.png',
                                fit: BoxFit.fill,color: const Color(0xff818495),
                                  width: media.width * 0.055,height:media.width * 0.055
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_enable_referal'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),

                      //favorite
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Favorite()));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only( left: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 20, color:  Color(0xff818495)
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_favourites'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),

                      //faq
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Faq()));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only( left: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/faq1.png',
                                fit: BoxFit.contain,
                                width: media.width * 0.055,
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_faq'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const insurance()));
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.only( left: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/ins.png',
                                fit: BoxFit.contain,
                                width: media.width * 0.055,
                                color: Color(0xff818495),
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  'Insurance',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),


                      //sos
                      InkWell(
                        onTap: () async {
                          var nav = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Sos()));
                          if (nav) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only( left: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/sos.png',
                                fit: BoxFit.contain,
                                color: const Color(0xff818495),
                                width: media.width * 0.055,
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_sos'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color: const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),

                      //select language
                      InkWell(
                        onTap: () async {
                          var nav = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SelectLanguage()));
                          if (nav) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only( left: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/lang.png',
                                fit: BoxFit.contain,
                                width: media.width * 0.055,
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]
                                      ['text_change_language'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      //make complaints
                      InkWell(
                        onTap: () async {
                          var nav = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MakeComplaint(
                                        fromPage: 0,
                                      )));
                          if (nav) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only( left: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/mc.png',
                                fit: BoxFit.contain,
                                width: media.width * 0.055,
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]
                                      ['text_make_complaints'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color: const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      //about
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const About()));
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,color: const Color(0xff818495),
                                size: media.width * 0.055,
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_about'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color: const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            deleteAccount = true;
                          });
                          valueNotifierHome.incrementNotifier();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_forever,color: const Color(0xff818495),
                                size: media.width * 0.055,
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_delete_account'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            logout = true;
                          });
                          valueNotifierHome.incrementNotifier();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 13),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,color: Color(0xff818495),
                                size: 20,
                              ),
                              SizedBox(
                                width: media.width * 0.09,
                              ),
                              SizedBox(
                                width: media.width * 0.5,
                                child: Text(
                                  languages[choosenLanguage]['text_logout'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * fourteen,
                                      color:  const Color(0xff818495)),
                                ),
                              ),
                              const Icon(
                                  Icons.navigate_next,color: Color(0xff818495),size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                      const Divider(
                        color: Color(0xffe4e7f4),
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: media.width*0.035,
                      ),
                    ],
                  ),
              )
            ]),
                ),
          ),
        ),

    );
  }
}
