class Organ{
  List<Organ> subOrgans;
  List<Member> members;
  String value;
  String text;
  int parentId;
  int id;

  Organ(
      this.subOrgans,
      this.members,
      this.text,
      this.id,
      this.parentId,
      this.value
      );
}

class Member{
  String value;
  String text;
  int parentId;
  int id;

  Member(
      this.text,
      this.value,
      this.parentId,
      this.id
      );
}