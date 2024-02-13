abstract class LocalNewsEvent {}

class LoadSavedNews extends LocalNewsEvent {}

class DeleteNews extends LocalNewsEvent {
  final int newsId;

  DeleteNews(this.newsId);
}