import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:taazakhabar/modules/news/domain/models/news_model.dart';
import 'package:taazakhabar/modules/news/infrastructure/repos/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<FetchNews>(_onFetchNews);
    on<FetchFavNews>(_onFetchFavNews);
  }

  void _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final List<NewsModel> newsList = await newsRepository.fetchNews();
      emit(NewsLoaded(newsList));
    } catch (e) {
      emit(NewsError('Failed to fetch news: $e'));
    }
  }

  void _onFetchFavNews(FetchFavNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final List<NewsModel> newsList = await newsRepository.fetchFavNews(event.category);
      emit(NewsLoaded(newsList));
    } catch (e) {
      emit(NewsError('Failed to fetch news: $e'));
    }
  }
}
