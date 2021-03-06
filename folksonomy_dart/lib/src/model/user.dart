import 'package:json_annotation/json_annotation.dart';
import '../interface/JsonObject.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(includeIfNull: false)
  final String? comment;

  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey()
  final String password;

  const User({
    this.comment,
    required this.userId,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
