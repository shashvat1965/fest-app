import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/morescreen/repo/models/contact_model.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';
import 'package:oasis_2022/utils/scroll_remover.dart';
import 'package:oasis_2022/utils/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contactList = [
    Contact(
      name: "Anshal Shukla",
      desc: "Website, App and \nPayments",
      email: "webmaster@bits-oasis.org",
      imageAsset: "anshal_shukla.png",
      phoneNumber: "8058088802",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Madhav Gupta",
      desc: "Publications and \nCorrespondence",
      email: "pcr@bits-oasis.org",
      imageAsset: "madhav_gupta.png",
      phoneNumber: "8130127878",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Angel Maria Baby",
      desc: "Reception and \nAccomodation",
      email: "recnacc@bits-oasis.org",
      imageAsset: "angel_maria_baby.png",
      phoneNumber: "8921977221",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Karishma K",
      desc: "Sponsorship and \nMarketing",
      email: "sponsorship@bits-oasis.org",
      imageAsset: "karishma.png",
      phoneNumber: "9902819428",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Rythm Saxena",
      desc: "Publicity and\nOnline Partnerships",
      email: "collaborations@bits-oasis.org",
      imageAsset: "rhythm.png",
      phoneNumber: "7836809755",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Pranav Dangi",
      desc: "Events, Projects and\nLogistics",
      email: "controls@bits-oasis.org",
      imageAsset: "pranav_dangi.png",
      phoneNumber: "8080263399",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Ashirwad Karande",
      desc: "President\n Student Union",
      email: "finance@bits-oasis.org",
      imageAsset: "ashirwad.png",
      phoneNumber: "8793009454",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Naman Jalan",
      desc: "General Secretary\n Student Union",
      email: "inventory@bits-oasis.org",
      imageAsset: "naman.png",
      phoneNumber: "8617395921",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
  ];

  Future<void> _launchMail(String email) async {
    final Uri _mailurl = Uri.parse('mailto:$email');
    await launchUrl(_mailurl);
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri _callurl = Uri.parse('tel:$phoneNumber');
    await launchUrl(_callurl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60.h, left: 24.w),
                    child: Text(
                      "Contact Us",
                      style: GoogleFonts.openSans(
                          fontSize: 28.sp, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 200.w, top: 50.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28.r,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: UIUtills().getProportionalHeight(height: 20),
                    left: UIUtills().getProportionalWidth(width: 36),
                    right: UIUtills().getProportionalWidth(width: 36)),
                child: SizedBox(
                  height: (MediaQuery.of(context).size.height - 184.h),
                  child: ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 24.w,
                            mainAxisSpacing: 20.h,
                            crossAxisCount: 2,
                            childAspectRatio: 0.62),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF17181C),
                                borderRadius: BorderRadius.circular(10.r)),
                            width: UIUtills().getProportionalWidth(width: 182),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: UIUtills()
                                      .getProportionalHeight(height: 16)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      height: 113.h,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                        Color.fromRGBO(209, 154, 8, 1),
                                        Color.fromRGBO(254, 212, 102, 1),
                                        Color.fromRGBO(227, 186, 79, 1),
                                        Color.fromRGBO(209, 154, 8, 1),
                                        Color.fromRGBO(209, 154, 8, 1),
                                      ])),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        child: ClipOval(
                                          child: Container(
                                            color: Colors.black,
                                            child: Image.asset(
                                              "assets/images/${contactList[index].imageAsset}",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Center(
                                      child: Text(
                                        contactList[index].name,
                                        textAlign: TextAlign.center,
                                        style: OasisTextStyles
                                            .openSansSubHeading
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 16.08.h, bottom: 20.35.h),
                                    child: Center(
                                      child: Text(
                                        contactList[index].desc,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            textStyle: OasisTextStyles
                                                .openSansSubHeading
                                                .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: OasisColors.primaryYellow,
                                        )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: UIUtills()
                                        .getProportionalWidth(width: 65.57),
                                    height: UIUtills()
                                        .getProportionalHeight(height: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              await _launchPhone(
                                                  contactList[index]
                                                      .phoneNumber);
                                              await Clipboard.setData(
                                                  ClipboardData(
                                                      text: contactList[index]
                                                          .phoneNumber));
                                            },
                                            child: Icon(
                                              Icons.phone,
                                              size: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 20),
                                              color: Colors.grey,
                                            )),
                                        InkWell(
                                            onTap: () async {
                                              await _launchMail(
                                                  contactList[index].email);
                                              await Clipboard.setData(
                                                  ClipboardData(
                                                      text: contactList[index]
                                                          .email));
                                            },
                                            child: Icon(
                                              size: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 20),
                                              Icons.email,
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: contactList.length),
                  ),
                ),
              ),
            ])));
  }
}
