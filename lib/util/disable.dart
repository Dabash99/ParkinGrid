import 'package:flutter/material.dart';

bool Disabled({@required var PARKID}){
  if (PARKID == null) {
    return false;
  }
  else{
    return true;
  }
}

bool DiableinMAP({@required dynamic DISTANCE }){
if(DISTANCE < 2){
  return true;
}else {return false;}
}