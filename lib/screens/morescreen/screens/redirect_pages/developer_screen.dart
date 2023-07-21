import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';
import 'package:oasis_2022/utils/scroll_remover.dart';
import 'package:oasis_2022/utils/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopersScreen2 extends StatelessWidget {
  DevelopersScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.h, left: 24.w),
                  child: Text(
                    "Developers",
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
                  child: GridView(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            crossAxisCount: 2,
                            childAspectRatio: 0.57),
                    children: const [
                      SingleCard(
                          iconsMap: {
                            "github": 'shashvat1965',
                            "linkedin": 'shashvatsingh',
                            'twitter': 'Xcarnage__'
                          },
                          image: "assets/images/ShashvatSingh.png",
                          name: 'Shashvat Singh',
                          job: 'App Developer'),
                      SingleCard(
                          iconsMap: {
                            "github": 'risingPhoenix7',
                            "linkedin": 'achinthya-hebbar',
                          },
                          image: "assets/images/AchinthyaHebbar.png",
                          name: 'Achinthya Hebbar',
                          job: 'App Developer'),
                      SingleCard(
                          iconsMap: {
                            "github": 'lovenya',
                            "linkedin": 'lovenya-jain-44848818a',
                            'twitter': 'lovenyajain'
                          },
                          image: "assets/images/LovenyaJain.png",
                          name: 'Lovenya Jain',
                          job: 'App Developer'),
                      SingleCard(
                          iconsMap: {
                            "github": 'APRABHASKUMAR',
                            "linkedin": 'prabhas-kumar-alamuri/',
                          },
                          image: "assets/images/PrabhasKumarAlamuri.png",
                          name: 'A. Prabhas Kumar',
                          job: 'App Developer'),
                      SingleCard(
                          iconsMap: {
                            "behance": 'sejalagarwal12',
                            "linkedin": 'sejal-agarwal-618176228',
                            'twitter': 'sejalag44718131'
                          },
                          image: "assets/images/SejalAgarwal.png",
                          name: 'Sejal Agarwal',
                          job: 'UI/UX Design'),
                      SingleCard(
                          iconsMap: {
                            "behance": 'shivangrai2',
                            "linkedin": 'shivang-rai-36a0481bb',
                            'instagram': 'shivang0305'
                          },
                          image: "assets/images/ShivangRai.png",
                          name: 'Shivang Rai',
                          job: 'UI/UX Design'),
                      SingleCard(
                          iconsMap: {
                            "behance": 'AnAvUser',
                            "linkedin": 'aditya-patil-aa2431230',
                            'twitter': 'AnAvUser?t=3zMTVg6rAofnDcwFSdsATQ&s=09'
                          },
                          image: "assets/images/AdityaPatil.png",
                          name: 'Aditya Patil',
                          job: 'UI/UX Design'),
                      SingleCard(
                          iconsMap: {
                            "behance": 'patiswaha',
                            "linkedin": 'swahapati',
                            'twitter': 'swahapati'
                          },
                          image: "assets/images/SwahaPati.png",
                          name: 'Swaha Pati',
                          job: 'UI/UX Design'),
                      SingleCard(
                          iconsMap: {
                            "behance": 'satwikrath',
                            "linkedin": 'satwik-rath-70034421b',
                            'instagram': '_satw_k'
                          },
                          image: "assets/images/SatwikRath.png",
                          name: 'Satwik\nRath',
                          job: 'UI/UX Design'),
                      SingleCard(
                          iconsMap: {
                            "github": 'DankMemes4President',
                            "linkedin": 'harsh-singh-049838227',
                            'twitter':
                                'harsh_singh58?t=NDO5fvFMXJfGMIo5-cOSQw&s=09'
                          },
                          image: "assets/images/HarshSingh.png",
                          name: 'Harsh\nSingh',
                          job: 'Backend Dev'),
                      SingleCard(
                          iconsMap: {
                            "github": 'FirePing32',
                            "linkedin": 'prakhargurunani',
                            'twitter': 'FirePing32'
                          },
                          image: "assets/images/PrakharGurunani.png",
                          name: 'Prakhar Gurunani',
                          job: 'Backend Dev'),
                      SingleCard(
                          iconsMap: {
                            "github": 'Maanas-23',
                            "linkedin": 'maanas23',
                          },
                          image: "assets/images/MaanasSingh.png",
                          name: 'Maanas Singh',
                          job: 'Backend Dev'),
                      SingleCard(
                          iconsMap: {"github": 'ode', 'twitter': 'endofunct'},
                          image: "assets/images/HarshithVasireddy.png",
                          name: 'Harshith Vasireddy',
                          job: 'Backend Dev'),
                      SingleCard(
                          iconsMap: {
                            "github": 'utkarsh314',
                            "linkedin": 'utkarsh314',
                          },
                          image: "assets/images/UtkarshSharma.png",
                          name: 'Utkarsh Sharma',
                          job: 'Backend Dev'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleCard extends StatelessWidget {
  const SingleCard(
      {Key? key,
      required this.iconsMap,
      required this.image,
      required this.name,
      required this.job})
      : super(key: key);
  final String image;
  final String name;
  final String job;
  final Map<String, String> iconsMap;

  Future<void> _launchGithub(String gituser) async {
    final Uri profileUrl = Uri.parse('https://github.com/$gituser');
    await launchUrl(profileUrl);
  }

  Future<void> _launchLinkedin(String linkedinUser) async {
    final Uri profileUrl =
        Uri.parse('https://www.linkedin.com/in/$linkedinUser');
    await launchUrl(profileUrl);
  }

  Future<void> _launchTwitter(String twitterUser) async {
    final Uri profileUrl = Uri.parse('https://twitter.com/$twitterUser');
    await launchUrl(profileUrl);
  }

  Future<void> _launchBehance(String behanceUser) async {
    final Uri profileUrl = Uri.parse('https://www.behance.net/$behanceUser');
    await launchUrl(profileUrl);
  }

  Future<void> _launchDribble(String dribbleUser) async {
    final Uri profileUrl = Uri.parse('https://dribbble.com/$dribbleUser');
    await launchUrl(profileUrl);
  }

  Future<void> _launchInstagram(String instagramUser) async {
    final Uri profileUrl =
        Uri.parse('https://www.instagram.com/$instagramUser');
    await launchUrl(profileUrl);
  }

  otherOne(String iconLocation, Function a, String handleurl) {
    return GestureDetector(
      onTap: () async {
        await a(handleurl);
      },
      child: SvgPicture.asset(
        iconLocation,
        width: 20,
        height: 20,
        // color: Colors.grey,
      ),
    );
  }

  Widget relavantWidget(String app, String handleurl) {
    switch (app) {
      case 'github':
        return otherOne(
            'assets/images/githubIcon.svg', _launchGithub, handleurl);
      case 'linkedin':
        return otherOne(
            'assets/images/linkedinIcon.svg', _launchLinkedin, handleurl);
      case 'twitter':
        return otherOne(
            'assets/images/twitterIcon.svg', _launchTwitter, handleurl);
      case 'behance':
        return otherOne(
            'assets/images/behanceIcon.svg', _launchBehance, handleurl);
      case 'dribble':
        return otherOne(
            'assets/images/dribbleIcon.svg', _launchDribble, handleurl);
      case 'instagram':
        return otherOne(
            'assets/images/instagramIcon.svg', _launchInstagram, handleurl);
      default:
        {
          return Container();
        }
    }
  }

  List<Widget> getListFromMap() {
    var list = <Widget>[];
    for (String a in iconsMap.keys) {
      list.add(relavantWidget(a, iconsMap[a]!));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF17181C),
          borderRadius: BorderRadius.circular(10.r)),
      width: UIUtills().getProportionalWidth(width: 182),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: UIUtills().getProportionalHeight(height: 32)),
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
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  child: ClipOval(
                    child: Container(
                      color: Colors.black,
                      child: Image.asset(
                        image,
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
                  name,
                  textAlign: TextAlign.center,
                  style: OasisTextStyles.openSansSubHeading
                      .copyWith(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.08.h, bottom: 20.35.h),
              child: Center(
                child: Text(
                  job,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: OasisTextStyles.openSansSubHeading.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: OasisColors.primaryYellow,
                  )),
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getListFromMap()),
          ],
        ),
      ),
    );
  }
}
