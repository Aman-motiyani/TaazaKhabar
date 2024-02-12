import 'dart:typed_data';
import 'package:isar/isar.dart';

part 'local_news.g.dart';


@Collection()
class LocalNews{

  final Id id = Isar.autoIncrement;

  @Index(
    unique: true,
    replace: true,
  )


  @Ignore()
  late Uint8List imageBytes;
  late String title;
  late String description;
  late String publishedAt;
}