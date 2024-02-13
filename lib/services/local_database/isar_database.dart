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

  Future<List<LocalNews>> getAllSavedNews() async {
    List<LocalNews> newsList = []; // Initialize as an empty list
    await isar.txn(() async {
      newsList = await isar.localNews.where().findAll();
    });
    return newsList;
  }

  Future<bool> saveNews(LocalNews news) async {
    List<LocalNews> newsList = []; // Initialize as an empty list
    await _isar.txn(() async {
      newsList = await _isar.localNews.where().findAll();
    });

    // Check if the provided news is already present in the newsList
    bool isNewsPresent = newsList.any((item) => item.title == news.title);

    if (isNewsPresent) {
      return false; // News already saved
    } else {
      await _isar.writeTxn<int>(() {
        return _isar.localNews.put(news);
      });
      return true; // News saved successfully
    }
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
