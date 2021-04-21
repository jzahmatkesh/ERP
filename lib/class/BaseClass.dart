import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../module/widget.dart';

abstract class Entity{
  bool edit=false;
  String token="";

  Entity.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class Bloc<T>{
  BehaviorSubject<T> _bloc = BehaviorSubject<T>();
  Stream<T> get stream$ => _bloc.stream;
  T get value$ => _bloc.value!;

  setValue(T value) => _bloc.add(value);
}

class Field<T>{
  final String fieldName;
  final String fieldLabel;
  T value;
  final List<Map<String, dynamic>>? options;

  Field({required this.fieldName, required this.fieldLabel, required this.value, this.options});

  Widget toLabel({bool expanded=false}){
    if (expanded)
      return Expanded(child: Label('${this.value}'));
    return Label('${this.value}');
  }
  
  Widget toEdit({bool expanded=false}){
    Widget editBox(){
      return EditBox(label: this.fieldLabel, 
        onChange: (val)=>this.value=val as T,
        type: T is int ? EditType.Number : EditType.Text,
        defaultvalue: value as String,
      );
    }
    if (expanded)
      return Expanded(child: editBox());
    return editBox();
  }

  Widget toMultiChoose({bool expanded=false}){
    if (expanded)
      return Expanded(child: MultiItem(value: this.value as int, options: this.options!, onChange: (val)=>this.value = val as T));
    return MultiItem(value: this.value as int, options: this.options!, onChange: (val)=>this.value = val as T);
  }
}