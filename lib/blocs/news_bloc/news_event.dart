import 'package:equatable/equatable.dart';
import 'package:taazakhabar/data/models/news_model.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {}

class FetchFavNews extends NewsEvent {
  final String category;

  const FetchFavNews(this.category);

  @override
  List<Object> get props => [category];
}

