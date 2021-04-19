import 'package:flutter/material.dart';
import 'widget.dart';

class Field<T>{
  final String fieldName;
  final String fieldLabel;
  T value;

  Field({required this.fieldName, required this.fieldLabel, required this.value});

  Widget toLabel()=>Text('${this.value}');
  Widget toEdit({bool expanded=false})=>EditBox(label: this.fieldLabel, onChange: (val)=>this.value=T is int ? int.tryParse(val) : T is String ? val : );
}