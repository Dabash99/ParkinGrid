
import 'package:flutter/material.dart';


Color ChooseColor({@required String status}){
  if(status=='yellow') return Colors.orangeAccent.withOpacity(0.8);
  if(status=='green') return Colors.green;
  if(status=='red') return Colors.redAccent.withOpacity(0.8);
}