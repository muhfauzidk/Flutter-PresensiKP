class User {
  String? uid;
  final String email;
  final String name;
  final String noTelp;
  final String nik;
  final String kategori;
  final String jurusan;
  final String asalInstansi;
  final String alamatMagang;
  final String statusMagang;
  final String mulaiMagang;
  final String akhirMagang;

  User({
    this.uid = '',
    required this.email,
    required this.name,
    required this.noTelp,
    required this.nik,
    required this.kategori,
    required this.jurusan,
    required this.asalInstansi,
    required this.alamatMagang,
    required this.statusMagang,
    required this.mulaiMagang,
    required this.akhirMagang,
  });

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

  static User fromJson(Map<String, dynamic> json) => User(
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