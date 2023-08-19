import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../globals/colors.dart';
import '../globals/my_fonts.dart';
import '../store/common_store.dart';

class CustomDropDown extends StatelessWidget {
  final String hintText;
  final String? value;

  const CustomDropDown(
      {super.key,
        required this.hintText,
        this.value,
        });

  @override
  Widget build(BuildContext context) {
    var store = context.read<CommonStore>();
    List<String> getItems(int year){
      var a = DateTime.now();
      if(hintText == "Month")
        {
          if(year < a.year)
          {
            return ["1","2","3","4","5","6","7","8","9","10","11","12"];
          }
          else
          {
            List<String> ans = [];
            int month = a.month;
            for(int i = 1; i <= month; i++)
            {
              ans.add(i.toString());
            }
            return ans;
          }
        }
      else
        {
          int cyear = a.year;
          List<String>ans = [];
          for(int i = cyear; i >= 2023; i--)
            {
              ans.add(i.toString());
            }
          return ans;
        }

    }
    Map<String,String> temp = {
      "1": "Jan",
      "2": "Feb",
      "3": "Mar",
      "4": "Apr",
      "5": "May",
      "6": "June",
      "7": "July",
      "8": "Aug",
      "9": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec"
    };
    return Observer(
      builder: (context) {
        return DropdownButtonFormField(
          menuMaxHeight: 400,
          value: hintText == "Month" ? store.month.toString() : store.year.toString(),
          isExpanded: true,
          decoration: InputDecoration(
            label: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: hintText,
                    style: MyFonts.w500.size(14).setColor(Themes.hintText),
                  ),
                  TextSpan(
                    text: ' * ',
                    style: MyFonts.w500.size(16).setColor(Themes.starColor),
                  ),
                ],
              ),
            ),
            labelStyle: MyFonts.w500.size(14).setColor(Themes.hintText),
            contentPadding:
             const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Themes.borderColor, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:  Themes.borderColor, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Themes.red, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Themes.red, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
          dropdownColor: Themes.dropDownColor,
          isDense: true,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 28,
          ),
          elevation: 16,
          style: MyFonts.w500.size(14).setColor(Themes.white),
          onChanged: (String? value) {
            // print(value);
            if(value != null)
              {
                if(hintText == "Month")
                  {
                    store.setMonth(int.parse(value));
                  }
                else
                  {
                    store.setMonth(1);
                    store.setYear(int.parse(value));
                  }
              }
          },
          items: getItems(store.year).map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: hintText == "Month" ? Text(temp[value]!) : Text(value),
            );
          }).toList(),
        );
      }
    );
  }
}
