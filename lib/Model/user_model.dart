
class UserModel {
  String? uid;
  String? email;
  String? name;
  String? noTelp;
  String? nik;
  String? kategori;
  String? jurusan;
  String? asalInstansi;
  String? alamatMagang;
  String? statusMagang;
  String? mulaiMagang;
  String? akhirMagang;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.noTelp,
    this.nik,
    this.kategori,
    this.jurusan,
    this.asalInstansi,
    this.alamatMagang,
    this.statusMagang,
    this.mulaiMagang,
    this.akhirMagang,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      noTelp: map['noTelp'],
      nik: map['nik'],
      kategori: map['kategori'],
      jurusan: map['jurusan'],
      asalInstansi: map['asalInstansi'],
      alamatMagang: map['alamatMagang'],
      statusMagang: map['statusMagang'],
      mulaiMagang: map['mulaiMagang'],
      akhirMagang: map['akhirMagang'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'noTelp': noTelp,
      'nik': nik,
      'kategori': kategori,
      'jurusan': jurusan,
      'asalInstansi': asalInstansi,
      'alamatMagang': alamatMagang,
      'statusMagang': statusMagang,
      'mulaiMagang': mulaiMagang,
      'akhirMagang': akhirMagang,
    };
  }

  Map<String, dynamic> toJson() => {
      'uid': uid,
      'email': email,
      'name': name,
      'noTelp': noTelp,
      'nik': nik,
      'kategori': kategori,
      'jurusan': jurusan,
      'asalInstansi': asalInstansi,
      'alamatMagang': alamatMagang,
      'statusMagang': statusMagang,
      'mulaiMagang': mulaiMagang,
      'akhirMagang': akhirMagang,
    };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
    email: json['email'],
    name: json['name'],
    noTelp: json['noTelp'],
    nik: json['nik'],
    kategori: json['kategori'],
    jurusan: json['jurusan'],
    asalInstansi: json['asalInstansi'],
    alamatMagang: json['alamatMagang'],
    statusMagang: json['statusMagang'],
    mulaiMagang: json['mulaiMagang'],
    akhirMagang: json['akhirMagang'],
  );
}