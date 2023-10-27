// @dart=2.9

import 'package:absensi/Model/user_model.dart';
import 'package:absensi/Screens/profile_screen.dart';
import 'package:absensi/extensions/date_time_extension.dart';
import 'package:absensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpdateProfileScreen extends StatefulWidget {
  static String routeName = "/update_profile_screen";
  const UpdateProfileScreen({key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
    final _auth = FirebaseAuth.instance;
    var selectedDate = DateTime.now();
    User user = FirebaseAuth.instance.currentUser;
    UserModel loggedInUser = UserModel();

    TextEditingController nameController;
    TextEditingController noTelpController;
    TextEditingController nikController;
    TextEditingController kategoriController;
    TextEditingController jurusanController;
    TextEditingController asalInstansiController;
    TextEditingController alamatMagangController;
    TextEditingController statusMagangController;
    TextEditingController mulaiMagangController;
    TextEditingController akhirMagangController;

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
          this.loggedInUser = UserModel.fromMap(value.data());

      nameController = new TextEditingController(text: '${loggedInUser.name}');
      noTelpController = new TextEditingController(text: '${loggedInUser.noTelp}');
      nikController = new TextEditingController(text: '${loggedInUser.nik}');
      kategoriController = new TextEditingController(text: '${loggedInUser.kategori}');
      jurusanController = new TextEditingController(text: '${loggedInUser.jurusan}');
      asalInstansiController = new TextEditingController(text: '${loggedInUser.asalInstansi}');
      alamatMagangController = new TextEditingController(text: '${loggedInUser.alamatMagang}');
      statusMagangController = new TextEditingController(text: '${loggedInUser.statusMagang}');
      mulaiMagangController = new TextEditingController(text: '${loggedInUser.mulaiMagang}');
      akhirMagangController = new TextEditingController(text: '${loggedInUser.akhirMagang}');
          setState(() {});
        });
      
    }
    // string for displaying the error Message
    String errorMessage;

    // our form key
    final _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      //first name field
      final nameField = TextFormField(
          inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
          ],
          autofocus: false,
          controller: nameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{3,}$');
            if (value.isEmpty) {
              return ("Nama tidak boleh kosong");
            }
            if (!regex.hasMatch(value)) {
              return ("Masukkan nama yang valid(Min. 3 Character)");
            }
            return null;
          },
          onSaved: (value) {
            nameController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "${loggedInUser.name}",
            labelText: "Nama Lengkap",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //noTelp field
      final noTelpField = TextFormField(
          inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          autofocus: false,
          controller: noTelpController,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{3,}$');
            if (value.isEmpty) {
              return ("Masukkan No Telp");
            }
            return null;
          },
          onSaved: (value) {
            nameController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "No Telp",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //nik field
      final nikField = TextFormField(
          autofocus: false,
          controller: nikController,
          validator: (value) {
            RegExp regex = new RegExp(r'^.{6,}$');
            if (value.isEmpty) {
              return ("Masukkan NPM/NIK");
            }
            if (!regex.hasMatch(value)) {
              return ("Masukkan NPM/NIK yang valid(Min. 6 Character)");
            }
          },
          onSaved: (value) {
            nikController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "NPM/NIK",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      //confirm kategori field
      String selectedValue = null;
      
      final kategoriField = DropdownButtonFormField(
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
            onChanged: (String newValue) {
              setState(() {
                selectedValue = newValue;
                kategoriController.text = selectedValue;
              });
            },
            items: [
              DropdownMenuItem<String>(child: Text("Siswa"),value: "Siswa"),
              DropdownMenuItem<String>(child: Text("Mahasiswa"),value: "Mahasiswa"),
            ]
      );

      //jurusan field
      final jurusanField = TextFormField(
          autofocus: false,
          controller: jurusanController,
          validator: (value) {
            if (value.isEmpty) {
              return ("Masukkan Jurusan");
            }
            return null;
          },
          onSaved: (value) {
            jurusanController.text = value;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Jurusan",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

        //asalInstansi field
        final asalInstansiField = TextFormField(
            autofocus: false,
            controller: asalInstansiController,
            validator: (value) {
              if (value.isEmpty) {
                return ("Masukkan Asal Instansi");
              }
              return null;
            },
            onSaved: (value) {
              asalInstansiController.text = value;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Asal Instansi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ));

        //alamatMagang field
        final alamatMagangField = TextFormField(
            autofocus: false,
            controller: alamatMagangController,
            validator: (value) {
              if (value.isEmpty) {
                return ("Masukkan Alamat Magang");
              }
              return null;
            },
            onSaved: (value) {
              alamatMagangController.text = value;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Alamat Magang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ));

        //statusMagang field
        final statusMagangField = TextFormField(
            autofocus: false,
            controller: statusMagangController,
            validator: (value) {
              if (value.isEmpty) {
                return ("Masukkan Status Magang");
              }
              return null;
            },
            onSaved: (value) {
              statusMagangController.text = value;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Status Magang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ));

        final mulaiMagangField = TextFormField(
            readOnly: true,
            controller: mulaiMagangController,
            decoration: InputDecoration(
              hintText: 'Pilih tanggal mulai',
              // fillColor: greyColor,
              // filled: true,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: new Icon(
                  Icons.calendar_month_rounded,
                  color: darkColor,
              )
            ),
            onTap: () async {
              await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2015),
              lastDate: DateTime(2025),
            ).then((selectedDate) {
              if (selectedDate != null) {
                mulaiMagangController.text = selectedDate.dayName + ", " + DateFormat('dd/MM/yy')
              .format(selectedDate);
              }
            });
            },
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pilih tanggal mulai';
              }
                return null;
              },
          );

        final akhirMagangField = TextFormField(
            readOnly: true,
            controller: akhirMagangController,
            decoration: InputDecoration(
              hintText: 'Pilih tanggal akhir',
              // fillColor: greyColor,
              // filled: true,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: new Icon(
                  Icons.calendar_month_rounded,
                  color: darkColor,
              )
            ),
            onTap: () async {
              await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2015),
              lastDate: DateTime(2025),
            ).then((selectedDate) {
              if (selectedDate != null) {
                akhirMagangController.text = selectedDate.dayName + ", " + DateFormat('dd/MM/yy')
              .format(selectedDate);
              }
            });
            },
              validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pilih tanggal akhir';
              }
                return null;
              },
          );

      //signup button
      final signUpButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.green,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              regist();
            },
            child: Text(
              "Update",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            )),
      );

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.green),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Update Profile",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 44),
                      nameField,
                      SizedBox(height: 20),
                      kategoriField,
                      SizedBox(height: 20),
                      jurusanField,
                      SizedBox(height: 20),
                      asalInstansiField,
                      SizedBox(height: 20),
                      noTelpField,
                      SizedBox(height: 20),
                      nikField,
                      SizedBox(height: 20),
                      alamatMagangField,
                      SizedBox(height: 20),
                      statusMagangField,
                      SizedBox(height: 20),
                      mulaiMagangField,
                      SizedBox(height: 20),
                      akhirMagangField,
                      SizedBox(height: 44),
                      signUpButton,
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
  
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;
    userModel.noTelp = noTelpController.text;
    userModel.nik = nikController.text;
    userModel.kategori = kategoriController.text;
    userModel.jurusan = jurusanController.text;
    userModel.asalInstansi = asalInstansiController.text;
    userModel.alamatMagang = alamatMagangController.text;
    userModel.statusMagang = statusMagangController.text;
    userModel.mulaiMagang = mulaiMagangController.text;
    userModel.akhirMagang = akhirMagangController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Profile berhasil di update");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => profileScreen()),
        (route) => false);
  }

  void regist() async {
    if (_formKey.currentState.validate()) {
        postDetailsToFirestore();
     }
    }
  }