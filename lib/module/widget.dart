import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../class/BaseClass.dart';

enum EditType { Text, Number, Money, Date }

class MoneyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.extentOffset;
      List<String> chars = newValue.text.replaceAll(',', '').split('');
      String newString = '';
      for (int i = 0; i < chars.length; i++) {
        if (i % 3 == 0 && i != 0) newString += ',';
        newString += chars[i];
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.extentOffset;
      List<String> chars = newValue.text.replaceAll('/', '').split('');
      String newString = '';
      for (int i = 0; i < chars.length; i++) {
        if (i == 4 || i == 6) newString += '/';
        newString += chars[i];
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}

class EditBox extends StatelessWidget {
  final String label;
  final String? defaultvalue;
  final bool expanded;
  final bool password;
  final void Function(String)? onChange;
  final TextEditingController? controller;
  final EditType type;
  final int? maxLength;
  final bool notEmpty;

  EditBox(
    {
      required this.label,
      this.defaultvalue,
      this.expanded = false,
      this.password = false,
      this.onChange,
      this.controller,
      this.type = EditType.Text,
      this.maxLength,
      this.notEmpty = false
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(4),
        child: this.expanded ? Expanded(child: builder()) : builder());
  }

  Widget builder() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          labelText: this.label,
          counterText: this.type == EditType.Date ? '' : null),
      initialValue: this.defaultvalue,
      obscureText: this.password,
      onChanged: this.onChange,
      maxLength: this.type == EditType.Date ? 10 : this.maxLength,
      validator: (String? val){
        if (this.notEmpty && (val == null || val.isEmpty))
          return "required".tr();
      },
      keyboardType: [EditType.Money, EditType.Number].contains(this.type)
          ? TextInputType.number
          : TextInputType.text,
      inputFormatters: [
        [EditType.Number, EditType.Money, EditType.Date].contains(this.type)
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.deny(''),
        this.type == EditType.Money
            ? MoneyTextInputFormatter()
            : FilteringTextInputFormatter.deny(''),
        this.type == EditType.Date
            ? DateTextInputFormatter()
            : FilteringTextInputFormatter.deny('')
      ],
    );
  }
}

class Button extends StatelessWidget {
  
  final String caption;
  final void Function() onPressed;
  final Icon? icon;

  Button({required this.caption, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: this.onPressed, 
        child: this.icon == null
          ? Text('${this.caption}')
          : Row(
            children: [
              this.icon!,
              SizedBox(width: 5),
              Text('${this.caption}')
            ],
          ),
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(horizontal: 28, vertical: 18))
        ),
      ),
    );
  }
}

class TxtButton extends StatelessWidget {
  
  final String caption;
  final void Function() onPressed;

  TxtButton({required this.caption, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: TextButton(onPressed: this.onPressed, child: Text('${this.caption}'))
    );
  }
}

class IButton extends StatelessWidget {
  
  final String? hint;
  final Icon? icon;
  final String? asseimage;
  final void Function() onPressed;

  IButton({this.icon, this.hint, required this.onPressed, this.asseimage});

  @override
  Widget build(BuildContext context) {
    return 
      this.asseimage == null 
        ? this.hint==null
          ? IconButton(icon: this.icon!, onPressed: this.onPressed)
          : Tooltip(message: this.hint!, child: IconButton(icon: this.icon!, onPressed: this.onPressed))
        : this.hint==null
          ? InkWell(
              child: CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('$asseimage')
              ), 
              onTap: this.onPressed
            )
          : Tooltip(
              message: this.hint!, 
              child: InkWell(
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('$asseimage')
                ), 
                onTap: this.onPressed
              )
            );
  }
}

class Label extends StatelessWidget {
  final String text;
  final TextStyle? style;

  Label(this.text, {this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Text('${this.text}', style: this.style),
    );
  }
}

class MultiItem extends StatelessWidget {
  final int value;
  final List<Map<String, dynamic>> options;
  final Function(int)? onChange;

  MultiItem({required this.value, required this.options, this.onChange});

  @override
  Widget build(BuildContext context) {
    Bloc<int> _mlt = Bloc<int>()..setValue(this.value);
    return StreamBuilder<int>(
      stream: _mlt.stream$,
      builder: (context, snap) {
        return DropdownButton<int>(
          value: snap.data,
          items: this.options.map<DropdownMenuItem<int>>((e) => DropdownMenuItem(value: e['id'],child: Text('${e['name']}'))).toList(),
          onChanged: (val){
            print('drop: $val');
            _mlt.setValue(val!);
            if (this.onChange != null)
              this.onChange!(val);
          },
        );
      }
    );
  }
}

class SubMenuItem extends StatelessWidget {
  final Icon icon;
  final String caption;
  final Function() onPressed;

  SubMenuItem({required this.icon, required this.caption, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 45,
        child: Stack(
          children: [
            Positioned(
              left: 5,
              child: Container(
                height: 45,
                width: 2,
                decoration: BoxDecoration(
                  border: Border(left: BorderSide())
                ),
              ),
            ),
            Positioned(
              left: 1,
              top: 18,
              child: CircleAvatar(backgroundColor: Colors.grey, radius: 5,)
            ),
            Positioned(
              left: 18,
              top: 12,
              child: this.icon
            ),
            Positioned(
              left: 55,
              top: 16,
              child: Text('$caption'.tr())
            )
          ]
        ),
        ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final bool selected;
  final String caption;
  final Function() onPressed;
  final Icon icon;

  MenuItem({required this.caption, required this.icon ,required this.selected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            this.icon,
            SizedBox(width: 5),
            Label('$caption'.tr()),
            Spacer(),
            this.selected
              ? Icon(Icons.arrow_drop_up)
              : Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

extension LabelStyle on Label{
  Label isBold() => Label(this.text, style: this.style?.merge(TextStyle(fontWeight: FontWeight.bold)) ?? TextStyle(fontWeight: FontWeight.bold));
  Label fontSize(double size) => Label(this.text, style: this.style?.merge(TextStyle(fontSize: size)) ?? TextStyle(fontSize: size));
  Label fontFamily(String name) => Label(this.text, style: this.style?.merge(TextStyle(fontFamily: name)) ?? TextStyle(fontFamily: name));
  Label fontColor(Color color) => Label(this.text, style: this.style?.merge(TextStyle(color: color)) ?? TextStyle(color: color));
  Expanded expand()=>Expanded(child: this);
}

extension WidgetExtension on Widget{
  Expanded expand({int flex=1}) => Expanded(flex: flex, child: this);
  Container setpadding({EdgeInsetsGeometry? padding}) => Container(padding: padding ?? EdgeInsets.all(6), child: this);
  Card card({Color? color}) => Card(child: this, color: color);
  Widget hMargin({double mrg=6}) => Container(margin: EdgeInsets.symmetric(horizontal: mrg), child: this);
  Widget vMargin({double mrg=6}) => Container(margin: EdgeInsets.symmetric(vertical: mrg), child: this);
  Widget height(double height) => Container(height: height, child: this);
  Widget width(double width) => Container(width: width, child: this);
  Container color(Color color) => Container(color: color, child: this);
}

extension IntExtension on int{
  EditBox toEdit(String label, Function(String) onChange)=>EditBox(label: label, defaultvalue: '$this', onChange: onChange);
  Label toLabel()=>Label('$this');
}

extension DoubleExtention on double{
  EditBox toEdit(String label, Function(String) onChange)=>EditBox(label: label, defaultvalue: '$this', onChange: onChange);
  Label toLabel()=>Label('$this');
}

extension StringExtension on String{
  Label toLabel()=>Label('$this');
  EditBox toEdit(String label, Function(String) onChange)=>EditBox(label: label, defaultvalue: '$this', onChange: onChange);
}
