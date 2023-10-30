import 'dart:convert';

class UserProfile {
  final String nama;
  final bool kelaminPria;
  final int tglLahir;
  final String foto;
  const UserProfile({
    this.nama = "",
    this.kelaminPria = true,
    this.tglLahir = 0,
    this.foto = "",
  });

  UserProfile copyWith({
    String? nama,
    bool? kelaminPria,
    int? tglLahir,
    String? foto,
  }) {
    return UserProfile(
      nama: nama ?? this.nama,
      kelaminPria: kelaminPria ?? this.kelaminPria,
      tglLahir: tglLahir ?? this.tglLahir,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nama': nama});
    result.addAll({'kelaminPria': kelaminPria});
    result.addAll({'tglLahir': tglLahir});
    result.addAll({'foto': foto});

    return result;
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      nama: map['nama'] ?? '',
      kelaminPria: map['kelaminPria'] ?? false,
      tglLahir: map['tglLahir']?.toInt() ?? 0,
      foto: map['foto'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfile(nama: $nama, kelaminPria: $kelaminPria, tglLahir: $tglLahir, foto: $foto)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile &&
        other.nama == nama &&
        other.kelaminPria == kelaminPria &&
        other.tglLahir == tglLahir &&
        other.foto == foto;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
        kelaminPria.hashCode ^
        tglLahir.hashCode ^
        foto.hashCode;
  }
}
