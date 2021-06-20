import 'package:firebase_auth/firebase_auth.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/about_us.dart';
import '../screens/admin/analytics/analytics.dart';
import '../screens/admin/approval/approval.dart';
import '../screens/admin/events/events.dart';
import '../services/class_builder.dart';
import '../widgets/constants.dart';
import '../screens/contact_us/contact_us.dart';
import '../screens/initiatives/initiatives.dart';
import '../screens/authentication/login.dart';
import '../screens/success_stories/success_stories.dart';
import '../models/user.dart';
import '../screens/view_profile.dart';

class AdminMainWidget extends StatefulWidget {
  AdminMainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AdminMainWidgetState createState() => _AdminMainWidgetState();
}

class _AdminMainWidgetState extends State<AdminMainWidget>
    with TickerProviderStateMixin {
  KFDrawerController _drawerController;
  var userInfo;
  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('AdminEvents'),
      items: [
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.info),
              SizedBox(width: 10),
              Text(
                'About Us',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: AboutUs(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.event),
              SizedBox(width: 10),
              Text(
                'Events',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: AdminEvents(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.follow_the_signs_sharp),
              SizedBox(width: 10),
              Text(
                'Initiatives',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: Initiatives(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 10),
              Text(
                'Success Stories',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: SuccessStories(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.quick_contacts_mail),
              SizedBox(width: 10),
              Text(
                'Contact Us',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: ContactUs(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.insert_chart),
              SizedBox(width: 10),
              Text(
                'Analytics',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: AnalyticsScreen(),
        ),
        KFDrawerItem.initWithPage(
          text: Row(
            children: [
              Icon(Icons.verified_user),
              SizedBox(width: 10),
              Text(
                'Approval',
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ],
          ),
          page: ApprovalScreen(),
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('You are going to exit the application!!'),
          actions: <Widget>[
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('YES'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
      child: Scaffold(
      // in Moto G5s Plus
      // A RenderFlex overflowed by 90 pixels on the bottom.
      // The relevant error-causing widget was
      // KFDrawer
      // lib\widgets\drawer.dart:119
      body: KFDrawer(
        controller: _drawerController,
        header: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'YWCA Of Bombay',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontFamily: 'LilyScriptOne',
                    ),
                  ),
                  // SizedBox(height: 15),
                  Text(
                    'MENU',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 10),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                      "https://content.jdmagicbox.com/comp/mumbai/54/022p4700154/catalogue/ywca-of-bombay-andheri-west-mumbai-hostels-p2eb4p7v56.jpg?clr=666600",
                    ),
                  ),
                  // SizedBox(height: 15),
                  Text(
                    'Welcome, ' + userInfo.getfirstName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 15),
                  ElevatedButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('View Profile'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return primaryColor;
                          return secondaryColor; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewProfileScreen(),
                        ),
                      );
                    },
                  ),
                  // SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'LOGOUT',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          icon: Icon(
            Icons.logout,
            color: Colors.black,
            size: 22,
          ),
          onPressed: () async {
            userInfo.updateAfterAuth(
                "", "", "", DateTime.now(), "", "", "", "", "", "", "", "");
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
          },
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.3, 0.8, 0.9],
            colors: [
              Colors.white,
              Colors.white,
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
      ),
    ),
    );
  }
}
