import 'package:spanticom/architectures/domain/entities/MemberInfo.dart';

abstract class MemberRepository {
  Future<MemberInfo> memberInfo(String memberId);
}
