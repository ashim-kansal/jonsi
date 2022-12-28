import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Rating {
  @JsonKey(name: 'first_name')
  String ratingGiverfname;
  @JsonKey(name: 'last_name')
  String ratingGiverlname;
  String? ratingGiverprofileurl;
  double rating;
  String ratingpublishedDate;
  @JsonKey(name: 'review')
  String ratingcomment;

  Rating(
      {required this.ratingGiverfname,
      required this.ratingGiverlname,
      required this.ratingGiverprofileurl,
      required this.rating,
      required this.ratingpublishedDate,
      required this.ratingcomment});

  /// Connect the generated [_$SignInFromJson] function to the `fromJson`
  /// factory.
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  /// Connect the generated [_$SignInToJson] function to the `toJson` method.

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
