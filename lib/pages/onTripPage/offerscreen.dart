import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translations/translation.dart';
import '../../widgets/widgets.dart';
import '../login/login.dart';
import '../referralcode/PromocodeModal.dart';
import 'booking_confirmation.dart';

class offerscreen extends StatefulWidget {
  int? type;
  offerscreen({super.key,required this.type});

  @override
  State<offerscreen> createState() => _offerscreenState();
}

class _offerscreenState extends State<offerscreen> {
  bool isLoading = false;
  List<Coupon> couponList = [];
  @override
  void initState() {
    fetchCouponList();
    super.initState();
  }

  TextEditingController promoKey = TextEditingController();
  List<Coupon> coupanList = [];
  navigateLogout() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
  }

  void fetchCouponList() async {
    try {
      setState(() {
        isLoading = true;
      });

      couponList = await fetchMatchList();
      if (kDebugMode) {
        print(couponList);
      }

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print("Coupon list is empty");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      height: media.height / 1.05,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: media.width * 0.05,
        ),
        Row(
          children: [
            SizedBox(
              width: media.width * 0.05,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                )),
            SizedBox(
              width: media.width * 0.07,
            ),
            Text('Offers',
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: media.width * 0.05,
        ),
        Container(
          margin: EdgeInsets.only(left: media.width * 0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderLines, width: 1.2),
          ),
          padding: EdgeInsets.fromLTRB(
              media.width * 0.025, 0, media.width * 0.025, 0),
          width: media.width * 0.9,
          child: Row(
            children: [
              SizedBox(
                width: media.width * 0.025,
              ),
              Expanded(
                child: (promoStatus == null)
                    ? TextField(
                  controller: promoKey,
                  onChanged: (val) {
                    setState(() {
                      promoCode = val;
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Coupon Code',
                      hintStyle: GoogleFonts.roboto(
                          fontSize: media.width * twelve,
                          color: (isDarkTheme == true)
                              ? textColor.withOpacity(0.3)
                              : const Color(0xff818495))),
                  style: GoogleFonts.roboto(color: textColor),
                )
                    : (promoStatus == 1)
                    ? Container(
                  padding: EdgeInsets.fromLTRB(
                      0, media.width * 0.045, 0, media.width * 0.045),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(promoKey.text,
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * ten,
                                  color: const Color(0xff319900))),
                          Text(
                              languages[choosenLanguage]
                              ['text_promoaccepted'],
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * ten,
                                  color: const Color(0xff319900))),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          // setState(() {
                          //   _isLoading = true;
                          // });
                          dynamic result;
                          if (widget.type != 1) {
                            result = await etaRequest();
                          } else {
                            result = await rentalEta();
                          }
                          setState(() {
                            // _isLoading = false;
                            if (result == true) {
                              print(result);
                              promoStatus = null;
                              promoCode = '';
                            }
                          });
                        },
                        child: Text(
                            languages[choosenLanguage]['text_remove'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xff319900))),
                      )
                    ],
                  ),
                )
                    : (promoStatus == 2)
                    ? Container(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      media.width * 0.045,
                      0,
                      media.width * 0.045),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(promoKey.text,
                          style: GoogleFonts.roboto(
                              fontSize: media.width * twelve,
                              color: const Color(0xffFF0000))),
                      InkWell(
                        // onTap: () async {
                        //   print(promoCode);
                        //   setState(() {
                        //     promoStatus = null;
                        //     promoCode = '';
                        //     promoKey.clear();
                        //   });
                        //
                        //  // setState(() {});
                        // },
                        onTap: () {
                          setState(() {
                            promoStatus = null;
                            promoCode = '';
                            promoKey.clear();
                            // promoKey.text = promoCode;
                            if (widget.type != 1) {
                              etaRequest();
                            } else {
                              rentalEta();
                            }
                          });
                        },
                        child: Text(
                            languages[choosenLanguage]
                            ['text_remove'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * twelve,
                                color: const Color(0xffFF0000))),
                      )
                    ],
                  ),
                )
                    : Container(),
              ),
              Button(
                  onTap:
                      () async {
                    if (promoCode ==
                        '') {

                    } else {

                      if (widget
                          .type !=
                          1) {
                        dynamic result= await etaRequestWithPromo();
                        print(result);
                        if(result==null)
                        {
                          setState(() {
                            promoStatus=1;
                          });
                        }
                        else
                        {
                          setState(() {
                            promoStatus=2;
                          });
                        }

                      }
                      else {
                        dynamic result= await rentalRequestWithPromo();
                        print(result);
                        if(result==null)
                        {
                          setState(() {
                            promoStatus=1;
                          });
                        }
                        else
                        {
                          setState(() {
                            promoStatus=2;
                          });
                        }

                      }

                    }
                  },
                  width: media.width * 0.2,
                  height: media.width * 0.1,
                  text: languages[choosenLanguage]['text_confirm'])
            ],
          ),
        ),

        //promo code status
        (promoStatus == 2)
            ? Container(
          width: media.width * 0.9,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: media.height * 0.02),
          child: Text(languages[choosenLanguage]['text_promorejected'],
              style: GoogleFonts.roboto(
                  fontSize: media.width * ten,
                  color: const Color(0xffFF0000))),
        )
            : Container(),
        SizedBox(
          height: media.height * 0.02,
        ),
        SizedBox(
          width: media.width,
          height: media.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height:
              //   media.height *
              //       0.15,
              // ),
              isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              )
                  : couponList.isNotEmpty
                  ? Expanded(
                child: ListView.builder(
                  itemCount: couponList.length,
                  itemBuilder: (context, index) {
                    Coupon coupon = couponList[index];
                    return SafeArea(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: media.width * 0.01,
                                bottom: media.width * 0.05),
                            child: SizedBox(
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/coupan.png',
                                    height: media.width * 0.3,
                                    width: media.width * 0.85,
                                  ),
                                )),
                          ),
                          Positioned(
                            left: media.width * 0.095,
                            top: media.width * 0.055,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Use Code',
                                      style: GoogleFonts.roboto(
                                          fontSize:
                                          media.width * 0.035,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: RichText(
                                      text: TextSpan(
                                        text: coupon.code,
                                        style: GoogleFonts.roboto(
                                            fontSize:
                                            media.width * 0.04,
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: media.width * 0.1,
                            top: media.width * 0.03,
                            child: InkWell(
                              onTap: () async {
                                promoKey.text = coupon.code;
                                setState(() {
                                  promoCode =promoKey.text;
                                });
                              },
                              child: SizedBox(
                                width: media.width * 0.85,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: media.width * 0.6,
                                      child: Text(
                                          "Get ${coupon.discountPercent}% Discount",
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.black)),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    SizedBox(
                                      width: media.width * 0.6,
                                      child: Text(
                                          "Get Flat ₹ ${coupon.maximumDiscountAmount} Discount On Minimum Ride Of ₹ ${coupon.minimumTripAmount}",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.black)),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.035,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: media.width * 0.07),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: media.width * 0.5,
                                            child: Text(
                                                "valid from ${coupon.from} to ${coupon.to}",
                                                style: GoogleFonts
                                                    .roboto(
                                                    fontSize: 11,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    color: Colors
                                                        .black)),
                                          ),
                                          InkWell(
                                            child: Container(
                                                width:
                                                media.width * 0.1,
                                                height: media.width *
                                                    0.075,
                                                decoration:
                                                BoxDecoration(
                                                  gradient:
                                                  const LinearGradient(
                                                    begin: Alignment
                                                        .centerRight,
                                                    end: Alignment
                                                        .centerLeft,
                                                    colors: [
                                                      Color(
                                                          0xffffd52b),
                                                      Color(
                                                          0xffffc00d)
                                                    ],
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      8),
                                                ),
                                                child: Center(
                                                  child: Text('Apply',
                                                      style: GoogleFonts.roboto(
                                                          fontSize:
                                                          11,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .black)),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
                  : Column(children: [
                Image.asset('assets/images/offer1.png',
                    height: media.width * 0.4),
                SizedBox(
                  height: media.height * 0.02,
                ),
                Text('No offer are Available Currently',
                    style: GoogleFonts.roboto(
                        fontSize: media.width * sixteen,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff000000)))
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}
