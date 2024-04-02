import 'package:bloc/bloc.dart';
import 'package:taazakhabar/modules/offline_news/infrastructure/service/isar_database.dart';

import 'local_news_event.dart';
import 'local_news_state.dart';

class LocalNewsBloc extends Bloc<LocalNewsEvent, LocalNewsState> {
  final IsarService isarService;

  LocalNewsBloc(this.isarService) : super(LocalNewsLoading()) {
    on<LoadSavedNews>((event, emit) => _mapLoadSavedNewsToState(emit));
    on<DeleteNews>((event, emit) => _mapDeleteNewsToState(event.newsId, emit));
  }

  void _mapLoadSavedNewsToState(Emitter<LocalNewsState> emit) async {
    emit(LocalNewsLoading());
    try {
      final savedNews = await isarService.getAllSavedNews();
      emit(LocalNewsLoaded(savedNews));
    } catch (e) {
      // Handle error
      emit(LocalNewsError("Failed to Load news item."));
    }
  }

  void _mapDeleteNewsToState(int newsId, Emitter<LocalNewsState> emit) async {
    try {
      await isarService.deleteNews(newsId);
      final savedNews = await isarService.getAllSavedNews();
      emit(LocalNewsLoaded(savedNews));
    } catch (e) {
      // Handle error
      emit(LocalNewsError("Failed to delete news item."));
    }
  }
}
