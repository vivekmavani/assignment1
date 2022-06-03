import 'package:assignment1/domain/entity/characters_entity.dart';

class CharactersModel extends CharactersEntity {
  int? charId;
  String? name;
  String? birthday;
  List<String>? occupation;
  String? img;
  String? status;
  String? nickname;
  List<int>? appearance;
  String? portrayed;
  String? category;
  List<int>? betterCallSaulAppearance;

  CharactersModel(
      {this.charId,
      this.name,
      this.birthday,
      this.occupation,
      this.img,
      this.status,
      this.nickname,
      this.appearance,
      this.portrayed,
      this.category,
      this.betterCallSaulAppearance})
      : super(
            charId: charId,
            name: name,
            birthday: birthday,
            occupation: occupation,
            img: img,
            status: status,
            nickname: nickname,
            appearance: appearance,
            portrayed: portrayed,
            category: category,
            betterCallSaulAppearance: betterCallSaulAppearance);

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      charId: json['char_id'],
      name: json['name'],
      birthday: json['birthday'],
      occupation: json['occupation'].cast<String>(),
      img: json['img'],
      status: json['status'],
      nickname: json['nickname'],
      appearance: json['appearance'].cast<int>(),
      portrayed: json['portrayed'],
      category: json['category'],
      betterCallSaulAppearance: json['better_call_saul_appearance'].cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['char_id'] = this.charId;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['occupation'] = this.occupation;
    data['img'] = this.img;
    data['status'] = this.status;
    data['nickname'] = this.nickname;
    data['appearance'] = this.appearance;
    data['portrayed'] = this.portrayed;
    data['category'] = this.category;
    data['better_call_saul_appearance'] = this.betterCallSaulAppearance;
    return data;
  }
}
