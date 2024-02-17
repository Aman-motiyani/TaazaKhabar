import 'dart:typed_data';
import 'package:isar/isar.dart';

part 'local_news.g.dart';


@Collection()
class LocalNews{

  Id id = Isar.autoIncrement;

  @Index(
    unique: true,
    replace: true,
  )


  late List<int> imageBytes;
  late String title;
  late String description;
  late String publishedAt;
}