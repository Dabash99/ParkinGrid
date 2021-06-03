import 'package:flutter/cupertino.dart';

String Mode({@required String mode}){
  if(mode=='0') return 'Less Than 5 Hours';
  if(mode=='1') return 'Less Than Day';
  if(mode=='2') return 'More Than Day';
}