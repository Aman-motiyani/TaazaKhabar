import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'entities/local_news.dart';

class IsarService {
  static late Isar _isar;

  static Future<Isar> openDB() async {
    final dir = await getApplicationSupportDirectory();
    _isar = await Isar.open([LocalNewsSchema], directory: dir.path);
    return _isar;
  }

  static Isar get isar => _isar;

  Future<List<LocalNews?>> getAllSavedNews(List<int> ids) async {
    final newsList = await _isar.localNews.getAll(ids);
    return newsList;
  }

  Future<void> saveNews(LocalNews news) async {
    await _isar.writeTxn<int>(() {
      return _isar.localNews.put(news);
    });
  }

  Future<void> deleteNews(int id) async {
    await _isar.writeTxn<bool>(() {
      return _isar.localNews.delete(id);
    });
  }

  Stream<List<LocalNews>> watchSavedNews() async* {
    yield* isar.localNews.where().watch();
  }
}
