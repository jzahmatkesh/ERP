import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
