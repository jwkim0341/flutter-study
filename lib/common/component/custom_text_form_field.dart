import 'package:flutter/material.dart';
import 'package:section1/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  //텍스트필드 마다 다른값 적용하기 위해
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  //외부에서 입력을 받음
  const CustomTextFormField({
    required  this.onChanged,
    this.obscureText = false,
    this.autofocus = false,
    this.hintText,
    this.errorText,super.key
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      // 실제 테두리
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      )
    );
    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 비밀번호 입력할 때 글자 가려짐
      obscureText: obscureText,
      // 화면에서 바로 포커스 되는 것 제어
      autofocus: autofocus,
      //값이 바뀔떄마다 실행되는 콜백함수
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText, //placeholder
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,
        //false - 배경색 없음, ture: 있음
        filled:true,
        //모든  Input 상태의 기본 스타일 세팅
        border:baseBorder,
        enabledBorder: baseBorder,
        //copywidth는 위젯의 속성을 복사하는 것
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          )
        ),
      ),
    );
  }
}
