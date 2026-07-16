import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxiuser/pages/loadingPage/loading.dart';
import 'package:tagxiuser/pages/login/get_started.dart';
import 'package:tagxiuser/pages/login/login.dart';
import 'package:tagxiuser/pages/login/otp_page.dart';
import 'package:tagxiuser/pages/noInternet/nointernet.dart';
import 'package:tagxiuser/translations/translation.dart';
import '../../styles/styles.dart';
import '../../functions/functions.dart';
import '../../widgets/widgets.dart';

class SignInwithEmail extends StatefulWidget {
  const SignInwithEmail({Key? key}) : super(key: key);

  @override
  State<SignInwithEmail> createState() => _SignInwithEmailState();
}

class _SignInwithEmailState extends State<SignInwithEmail> {
  TextEditingController controller = TextEditingController();

  bool terms = true; //terms and conditions true or false
  bool _isLoading = true;
  bool validate = false;
  var verifyEmailError = '';
  var _error = '';

  @override
  void initState() {
    countryCode();
    super.initState();
  }

  countryCode() async {
    await getCountryCode();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //navigate
  navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));
  }

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
              color: page,
              height: media.height * 1,
              width: media.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: media.width * 0.1),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              )),
                        ),
                        Container(
                          width: media.width * 0.8,
                          height: media.width * 0.7,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/login.png")),
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: media.width * 0.08),
                  Text(
                    languages[choosenLanguage]['text_sign_up_email'],
                    style: GoogleFonts.roboto(
                        fontSize: media.width * twentysix,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color(0xffe4e7f4), width: 1)),
                      alignment: Alignment.center,
                      height: 45,
                      width: media.width * 1 - (media.width * 0.08 * 2),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TextFormField(
                          controller: controller,
                          style: GoogleFonts.roboto(
                              fontSize: media.width * sixteen,
                              color: textColor,
                              letterSpacing: 1),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            icon: const Icon(Icons.mail),
                            hintText: languages[choosenLanguage]['text_email'],
                            hintStyle: GoogleFonts.roboto(
                                fontSize: media.width * sixteen,
                                color: textColor.withOpacity(0.7)),
                            errorText: (verifyEmailError == '')
                                ? null
                                : languages[choosenLanguage]['error_email'],
                            labelStyle: TextStyle(
                              color:
                                  (verifyEmailError == '') ? null : Colors.red,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                      )),
                  (_error != '')
                      ? Container(
                          width: media.width * 0.8,
                          margin: EdgeInsets.only(top: media.height * 0.02),
                          alignment: Alignment.center,
                          child: Text(
                            _error,
                            style: GoogleFonts.roboto(
                                fontSize: media.width * sixteen,
                                color: Colors.red),
                          ),
                        )
                      : Container(),
                  SizedBox(height: media.height * 0.03),
                  Row(
                    children: [
                      SizedBox(width: media.height * 0.04),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (terms == true) {
                              terms = false;
                            } else {
                              terms = true;
                            }
                          });
                        },
                        child: Container(
                            height: media.width * 0.08,
                            width: media.width * 0.08,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: buttonColor, width: 2),
                                shape: BoxShape.circle,
                                color: (terms == true) ? buttonColor : page),
                            child: Icon(Icons.done,
                                color: (isDarkTheme == true)
                                    ? Colors.black
                                    : Colors.white)),
                      ),
                      SizedBox(
                        width: media.width * 0.02,
                      ),

                      //terms and condition and https://nextdriveindia.com/privacy-policy
                      SizedBox(
                        width: media.width * 0.7,
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              languages[choosenLanguage]['text_agree'] + ' ',
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * twelve,
                                  color: const Color(0xffa8acbf)),
                            ),
                            InkWell(
                              onTap: () {
                                openBrowser(
                                    'https://nextdriveindia.com/terms-and-conditions');
                              },
                              child: Text(
                                languages[choosenLanguage]['text_terms'],
                                style: GoogleFonts.roboto(
                                    fontSize: media.width * twelve,
                                    color: const Color(0xfffcb13c)),
                              ),
                            ),
                            Text(
                              ' ${languages[choosenLanguage]['text_and']} ',
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * twelve,
                                  color: const Color(0xffa8acbf)),
                            ),
                            InkWell(
                              onTap: () {
                                openBrowser(
                                    'https://nextdriveindia.com/privacy-policy');
                              },
                              child: Text(
                                languages[choosenLanguage]['text_privacy'],
                                style: GoogleFonts.roboto(
                                    fontSize: media.width * twelve,
                                    color: const Color(0xfffcb13c)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: media.height * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      controller.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: Container(
                      width: media.width * 0.75,
                      height: media.width * 0.14,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffe4e7f4)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_rounded,
                              size: media.width * eighteen,
                              color: const Color(0xfffcb13c)),
                          SizedBox(width: media.width * 0.02),
                          Text(
                            languages[choosenLanguage]['text_continue_with'],
                            style: GoogleFonts.roboto(
                              color: textColor.withOpacity(0.7),
                              fontSize: media.width * sixteen,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: media.width * 0.01,
                          ),
                          Text(
                            languages[choosenLanguage]['text_phone_number'],
                            style: GoogleFonts.roboto(
                                fontSize: media.width * sixteen,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xfffcb13c)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: media.width * 0.08),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/fg.png",
                        height: 19,
                      ),
                      SizedBox(
                        width: media.width * 0.02,
                      ),
                      Text(
                        'Made In India',
                        style: GoogleFonts.roboto(
                          color: textColor.withOpacity(0.7),
                          fontSize: media.width * fourteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: media.width * 0.08),
                  (controller.text.isNotEmpty)
                      ? Container(
                          height: media.width * 0.15,
                          width: media.width * 1 - media.width * 0.3,
                          alignment: Alignment.center,
                          child: Button(
                              onTap: () async {
                                String pattern =
                                    r"^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])*$";
                                RegExp regex = RegExp(pattern);
                                if (regex.hasMatch(controller.text)) {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  setState(() {
                                    verifyEmailError = '';
                                    _error = '';
                                    _isLoading = true;
                                  });

                                  phoneAuthCheck = true;
                                  await sendOTPtoEmail(email);
                                  value = 1;
                                  navigate();

                                  setState(() {
                                    _isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    verifyEmailError =
                                        languages[choosenLanguage]
                                            ['text_email_validation'];
                                    _error = languages[choosenLanguage]
                                        ['text_email_validation'];
                                  });
                                }
                              },
                              text: languages[choosenLanguage]['text_login']))
                      : Container(),
                  SizedBox(
                    height: media.width * 0.03,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: media.width,
                        height: media.width * 0.27,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/bottomimage.png")),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //No internet
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(onTap: () {
                      setState(() {
                        _isLoading = true;
                        internet = true;
                        countryCode();
                      });
                    }))
                : Container(),

            //loader
            (_isLoading == true)
                ? const Positioned(top: 0, child: Loading())
                : Container()
          ],
        ),
      ),
    );
  }
}
