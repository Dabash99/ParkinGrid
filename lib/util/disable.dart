import 'package:flutter/material.dart';

bool Disabled({@required var PARKID}){
  if (PARKID == null) {
    return false;
  }
  else{
    return true;
  }
}

bool DiableinMAP({@required var DISTANCE }){
if(DISTANCE < 1.5){
  return true;
}else {return false;}
}