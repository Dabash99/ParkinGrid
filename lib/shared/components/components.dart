

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_gird/models/login_model.dart';
import 'package:parking_gird/modules/edit_account/edit_account.dart';
import 'package:parking_gird/modules/help_screen.dart';

import 'package:parking_gird/modules/home_screen/home_screen.dart';
import 'package:parking_gird/modules/parking_screen/parking_screen.dart';
import 'package:parking_gird/modules/rate_us_screen.dart';
import 'package:parking_gird/modules/share_screen.dart';
import 'package:parking_gird/shared/styles/colors.dart';

import 'constants.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey.withOpacity(0.4),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefix != null ? Icon(prefix) : null,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
          borderSide: new BorderSide(
            color: Colors.black,
            width: 4.0,
          ),
        ),
      ),
    );

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void showToastt({@required String msg, @required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green.withOpacity(0.8);
      break;
    case ToastStates.ERROR:
      color = Colors.red.withOpacity(0.8);
      break;
    case ToastStates.WARNING:
      color = Colors.amber.withOpacity(0.8);
      break;
  }
  return color;
}

Widget defaultTextButton(
        {@required Function function, @required String title}) =>
    TextButton(
        onPressed: function,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, color: defaultColor),
        ));

Widget customAppBar({@required String title}) => AppBar(
      iconTheme: IconThemeData(color: Color(0xff078547)),
      title: Center(
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/logo_splash.png',
              height: 50,
              width: 50,
            ),
            Text(
              title,
              style: TextStyle(color: Color(0xff078547), fontSize: 17),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Image.asset(
          'assets/images/w.png',
          height: 100,
          width: 100,
        )
      ],
    );


Widget customDrawer(context) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
             color: defaultColor
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo_splash.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Home Tap
          defaultListTile(context,
              title: 'Home',
              icon: Icon(
                Icons.home,
                color: Color(0xff078547),
              ),
              widget: HomeScreen()),
          //Edit Tap
          defaultListTile(context,
              title: 'Edit Your Account',
              icon: Icon(
                Icons.edit,
                color: Color(0xff078547),
              ),
              widget: EditAccountScreen()),
          //Help Tap
          defaultListTile(context,
              title: 'Help',
              icon: Icon(
                Icons.help,
                color: Color(0xff078547),
              ),
              widget: HelpScreen()),
          //Share Tap
          defaultListTile(context,
              title: 'Share',
              icon: Icon(
                Icons.share,
                color: Color(0xff078547),
              ),
              widget: ShareScreen()),
          //Rate Tap
          defaultListTile(context,
              title: 'Rate Us',
              icon: Icon(
                Icons.rate_review,
                color: Color(0xff078547),
              ),
              widget: RateUsScreen()),
          ListTile(
            title: Text(
              'Sign out',
              style: TextStyle(fontSize: 15, color: Colors.redAccent),
            ),
            leading: Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            onTap: () {
              signOut(context);
            },
          )
        ],
      ),
    );

Widget defaultListTile(context,
        {@required String title,
        @required Widget icon,
        @required Widget widget}) =>
    ListTile(
      title: Text(
        title,
        style: TextStyle(color: Color(0xff078547), fontSize: 15),
      ),
      leading: icon,
      onTap: () {
        navigateAndFinish(context, widget);
      },
    );

bool selected = true;

Widget buildParks(
        {@required Color color,
        @required String name,
        @required Function ontapFunction,
        @required double Width,
          @required bool Ignoring}) =>
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: ontapFunction,
        child: IgnorePointer(
          ignoring: Ignoring,
          child: Container(
            height: 100,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.green.shade900, width: Width),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                name.toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );

Widget buildInfoPark({@required Color color, @required String string}) => Row(
      children: [
        CircleAvatar(
            backgroundColor: Colors.black26,
            radius: 12.5,
            child: CircleAvatar(
              backgroundColor: color,
              radius: 10,
            )),
        SizedBox(
          width: 5,
        ),
        Text(
          string,
        )
      ],
    );
Widget alertDialogTimer(context)=>  AlertDialog(
  title: Row(
    children: [
      Icon( Icons.warning,color: Colors.orangeAccent,),
      SizedBox(width: 8,),
      Text('Attention',style: TextStyle(color:Colors.orange),),
    ],
  ),
  content: Text('Your Booking is Cancelled'),
  actions: [
    TextButton(
      onPressed: () {
        navigateAndFinish(context, ParkingScreen());
      },
      child: Text('OK, Back to book other park',style: TextStyle(color:defaultColor)),
    ),
    TextButton(
      onPressed: () {
        navigateAndFinish(context, HomeScreen());
      },
      child: Text('Cancel',style: TextStyle(color: Colors.red),),
    ),
  ],
);

