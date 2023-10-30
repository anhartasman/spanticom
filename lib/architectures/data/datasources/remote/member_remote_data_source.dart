import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spanticom/architectures/domain/entities/MemberInfo.dart';

class MemberRemoteDataSource {
  static Future<MemberInfo> memberInfo(String memberId) async {
    final result = await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(memberId)
        .get();

    return MemberInfo.fromMap(result.data()!);
  }
}
