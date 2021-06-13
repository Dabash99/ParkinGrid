import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_gird/modules/parking_screen/parking_screen.dart';
import 'package:parking_gird/shared/components/components.dart';
import 'package:parking_gird/shared/styles/colors.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final double distanc;
  const CustomDialogBox({Key key, this.title, this.descriptions, this.text,this.distanc}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}
dynamic padding = 20.0;
dynamic avatar = 45.0;
String Mode ;
String _character = '0';

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: padding,top: avatar
              + padding, right: padding,bottom:padding
          ),
          margin: EdgeInsets.only(top: avatar),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,2),
                    blurRadius: 20
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap:(){
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(angle: 40
                      ,child: Icon(Icons.add_outlined,color:Colors.grey)),
                ),
              ),
              SizedBox(height: 5,),
              Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              SizedBox(height: 5,),
              Text(widget.descriptions,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _character= '0';
                  });
                },
                child: ListTile(
                  title: Text('Less Than 5 Hours'),
                  leading: Radio(value: '0', groupValue: _character,onChanged: (Mode){
                    setState(() {
                      _character=Mode;
                    });
                    print('Value === ${_character}');
                  },),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _character= '1';
                  });
                },
                child: ListTile(
                  title: Text('Less Than Day'),
                  leading: Radio(value: '1',groupValue: _character,onChanged: (Mode){
                    setState(() {
                      _character=Mode;
                    });

                  },),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _character= '2';
                  });
                },
                child: ListTile(
                  title: Text('More Than Day'),
                  leading: Radio(value: '2', groupValue: _character,onChanged: (Mode){
                    setState(() {
                      _character=Mode;
                    });
                  },),
                ),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white,elevation: 0),
                    onPressed: (){
                    print('Dialog Mode = $Mode');
                    navigateTo(context, ParkingScreen(garage: widget.descriptions, distance: widget.distanc,mode: _character,));
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18,color: defaultColor),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(

            backgroundColor: Colors.white,
            radius: avatar,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(avatar)),
                child: Image.asset('assets/images/logo_splash.png')
            ),
          ),
        ),
      ],
    );
  }
}