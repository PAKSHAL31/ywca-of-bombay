import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'become_member.dart';

import '../../drawers_constants/user_drawer.dart';
import '../../models/User.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/gradient_button.dart';

// ignore: must_be_immutable
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final imageList = [
    'assets/images/about_us/Ywca_spotlight_1.jpg',
    'assets/images/about_us/Ywca_spotlight_2.jpg',
    'assets/images/about_us/Ywca_spotlight_3.jpg',
    'assets/images/about_us/Ywca_spotlight_4.jpg',
    'assets/images/about_us/Ywca_spotlight_5.jpg',
  ];

  final DrawerScaffoldController controller = DrawerScaffoldController();
  late int selectedMenuItemId;

  var userInfo;

  @override
  void initState() {
    selectedMenuItemId = menuWithIcon.items[0].id;
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var role = userInfo.getmemberRole;
    final _height = MediaQuery.of(context).size.height;
    print("item: $selectedMenuItemId");
    return DrawerScaffold(
      // appBar: AppBar(), // green app bar
      drawers: [
        SideDrawer(
          percentage: 0.75, // main screen height proportion
          headerView: header(context, userInfo),
          footerView: footer(context, controller),
          color: successStoriesCardBgColor,
          selectorColor: Colors.red, menu: menuWithIcon,
          animation: true,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
              selectedItem(context, itemId);
            });
          },
        )
      ],
      controller: controller,
      builder: (context, id) => SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  MainPageBlueBubbleDesign(),
                  Positioned(
                    child: AppBar(
                      centerTitle: true,
                      title: Text(
                        "YWCA Of Bombay",
                        style: TextStyle(
                          fontFamily: 'LobsterTwo',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () => {
                          // widget.onMenuPressed,
                          controller.toggle(Direction.left),
                          // OR
                          // controller.open()
                        },
                      ),
                    ),
                  ),
                  // Events & Search bar Starts
                  Positioned(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: _height * 0.1),
                        child: Column(
                          children: [
                            Text(
                              'OUR STORY',
                              style: TextStyle(
                                fontSize: 35,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RacingSansOne',
                                letterSpacing: 2.5,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.0, 3.0),
                                    blurRadius: 3.0,
                                    color: Color(0xff333333),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              child: SizedBox(
                                height: 80,
                              ),
                              // TODO: Replace with null safe carousel
                              // child: Swiper(
                              //   autoplay: false,
                              //   itemCount: 5,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return Column(
                              //       // To centralize the children.
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       children: <Widget>[
                              //         ClipRRect(
                              //           borderRadius: BorderRadius.circular(10),
                              //           child: Image(
                              //             image: AssetImage(imageList[index]),
                              //             fit: BoxFit.contain,
                              //           ),
                              //         ),
                              //       ],
                              //     );
                              //   },
                              //   viewportFraction: 0.87,
                              //   scale: 0.9,
                              //   pagination: SwiperPagination(
                              //     //changing the color of the pagination dots and that of
                              //     //the active dot
                              //     builder: DotSwiperPaginationBuilder(
                              //       color: Colors.grey,
                              //       activeColor: Color(0XFF80DEEA),
                              //       //  DotsIndicator(
                              //       // dotsCount: pageLength,
                              //       // position: currentIndexPage,
                              //       // dotsCount: pageLength,
                              //       // decorator: DotsDecorator()
                              //     ),
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 30, right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'The Young Women\'s Christian Association (YWCA) was established in 1855, when the movement formed on prayer and service united together and adopted the Blue Triangle as its symbol that signifies the unity and completeness of body, mind and spirit.\n',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.25,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          'The history of YWCA dates back to 1875 when the first local association was established in Mumbai. This was followed by the YWCA of India in the year 1896.\n',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.25,
                            fontFamily: 'Montserrat',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'It is one of the oldest non-profit community service organizations for women In India, which is based on the biblical principle \"Love thy neighbour as thyself\".\n',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.25,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          'The YWCA of Bombay is registered under the societies registration act, 1860 under no. 44 dated 06-08-1952 and of the Bombay public trust act, 1950 under no. F/388 (BOM.) dated 13-07-1953.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.25,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        // ),
                        SizedBox(
                          height: _height * 0.010,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: "To learn more, visit our website:\n",
                                  ),
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    text: "www.ywcaofbombay.co.in",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url =
                                            "http://www.ywcaofbombay.co.in/";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        if (role == "NonMember") ...[
                          GradientButton(
                            buttonText: 'Become a member today!',
                            screenHeight: _height,
                            onPressedFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BecomeMemberScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                        SizedBox(height: _height * 0.020),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}