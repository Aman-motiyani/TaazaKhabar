import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:taazakhabar/data/models/news_model.dart';
import 'package:taazakhabar/data/repository/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    // Register event handlers
    on<FetchNews>(_onFetchNews);
    on<FetchFavNews>(_onFetchFavNews);
  }

  void _onFetchNews(FetchNews event, Emitter<NewsState> emit) async {
    // Emit NewsLoading state
    emit(NewsLoading());
    try {
      final List<NewsModel> newsList = await newsRepository.fetchNews();
      // Emit NewsLoaded state with newsList
      emit(NewsLoaded(newsList));
    } catch (e) {
      // Emit NewsError state with error message
      emit(NewsError('Failed to fetch news: $e'));
    }
  }

  void _onFetchFavNews(FetchFavNews event, Emitter<NewsState> emit) async {
    // Emit NewsLoading state
    emit(NewsLoading());
    try {
      final List<NewsModel> newsList = await newsRepository.fetchFavNews(event.category);
      // Emit NewsLoaded state with newsList
      emit(NewsLoaded(newsList));
    } catch (e) {
      // Emit NewsError state with error message
      emit(NewsError('Failed to fetch news: $e'));
    }
  }
}
