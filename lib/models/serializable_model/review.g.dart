// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      ratingGiverfname: json['reviewer']['first_name'] as String,
      ratingGiverlname: json['reviewer']['last_name'] as String,
      ratingGiverprofileurl: json['profile'] == null
          ? null
          : json['profile']['profile_picture'] as String?,
      rating: (json['rating'] as num).toDouble(),
      ratingpublishedDate: '',
      ratingcomment: json['review'] as String,
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'first_name': instance.ratingGiverfname,
      'last_name': instance.ratingGiverlname,
      'ratingGiverprofileurl': instance.ratingGiverprofileurl,
      'rating': instance.rating,
      'ratingpublishedDate': instance.ratingpublishedDate,
      'review': instance.ratingcomment,
    };
