import 'package:taazakhabar/modules/offline_news/domain/models/local_news.dart';


abstract class LocalNewsState {}

class LocalNewsLoading extends LocalNewsState {}

class LocalNewsLoaded extends LocalNewsState {
  final List<LocalNews?> savedNews;

  LocalNewsLoaded(this.savedNews);
}


class LocalNewsError extends LocalNewsState {
  final String message;

  LocalNewsError(this.message);

  @override
  List<Object> get props => [message];
}