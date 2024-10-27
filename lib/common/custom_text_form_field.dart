import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final IconData? suffixIcon;


  final bool obscureText;
  final bool? readOnly;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final Function? onTap;

  const CustomTextFormField({
    super.key,
    this.hintText = '',
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onSubmitted,
    this.validator,
    this.onTap,
    this.readOnly = false,

  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
 late bool _obscureText;

@override
initState(){
  super.initState();
  _obscureText = widget.obscureText;
}

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly!,
      onTap: widget.onTap as void Function()?,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1.5, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1.5, color: Colors.red),
        ),
        filled: true,
        fillColor: const Color(0xFFE0E0E0),
        labelStyle: const TextStyle(color: Color(0xFF9F9F9F)),
        hintStyle: const TextStyle(
            color: Color(0xFF9F9F9F), fontWeight: FontWeight.w500),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: Theme.of(context).primaryColor)
            : null,
        suffixIcon: widget.suffixIcon != null
          ? Icon(widget.suffixIcon, color: Theme.of(context).primaryColor)
          : widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : null,
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       keyboardType: widget.keyboardType,
//       textInputAction: widget.textInputAction,
//       obscureText: widget.obscureText,
//       onFieldSubmitted: widget.onSubmitted,
//       validator: widget.validator,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         hintText: widget.hintText,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide: const BorderSide(width: 1.5, color: Colors.transparent),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide:
//               BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.0),
//           borderSide: const BorderSide(width: 1.5, color: Colors.red),
//         ),
//         filled: true,
//         fillColor: const Color(0xFFE0E0E0),
//         labelStyle: const TextStyle(color: Color(0xFF9F9F9F)),
//         hintStyle: const TextStyle(
//             color: Color(0xFF9F9F9F), fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }
