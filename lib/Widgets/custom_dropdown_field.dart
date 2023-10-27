 import 'package:flutter/material.dart';
 
 class DropdownItem extends StatefulWidget {
  const DropdownItem({Key? key, required TextEditingController}) : super(key: key);

  @override
  State<DropdownItem> createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Siswa"),value: "Siswa"),
    DropdownMenuItem(child: Text("Mahasiswa"),value: "Mahasiswa"),
  ];
  return menuItems;
}

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField(
              hint: Text("Kategori"),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12.5,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return ("Pilih Kategori");
                  }
                  return null;
                },
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    TextEditingController().text = selectedValue!;
                  });
                },
                items: dropdownItems),
          ],
        ));
  }
}