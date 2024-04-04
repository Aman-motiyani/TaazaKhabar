import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
//
// @freezed
// class NewsModel with _$NewsModel {
//   const factory NewsModel({
//     required String author,
//     required String title,
//     required String description,
//     required String url,
//     required String urlToImage,
//     required String publishedAt,
//     required String content,
//   }) = _NewsModel;
//
//   factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
// }
