abstract class MemberInfoBlocEvent {}

class MemberInfoBlocRetrieve extends MemberInfoBlocEvent {
  final String memberId;
  MemberInfoBlocRetrieve(this.memberId);
}
