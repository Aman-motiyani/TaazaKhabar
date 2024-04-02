import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taazakhabar/modules/news/infrastructure/repos/news_repository.dart';
import 'package:taazakhabar/modules/news/presentation/logic/news_bloc/news_bloc.dart';
import 'package:taazakhabar/modules/news/presentation/logic/news_bloc/news_event.dart';
import 'package:taazakhabar/modules/news/presentation/logic/news_bloc/news_state.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  group('NewsBloc', () {
    late NewsRepository newsRepository;
    late NewsBloc newsBloc;

    setUp(() {
      newsRepository = MockNewsRepository();
      newsBloc = NewsBloc(newsRepository);
    });

    tearDown(() {
      newsBloc.close();
    });

    test('initial state is NewsInitial', () {
      expect(newsBloc.state, NewsInitial());
    });

    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading, NewsLoaded] when FetchNews is added',
      build: () {
        when(() => newsRepository.fetchNews()).thenAnswer((_) async => []);
        return newsBloc;
      },
      act: (bloc) => bloc.add(FetchNews()),
      expect: () => [NewsLoading(), NewsLoaded([])],
    );

    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading, NewsLoaded] when FetchFavNews is added',
      build: () {
        when(() => newsRepository.fetchFavNews(any())).thenAnswer((_) async => []);
        return newsBloc;
      },
      act: (bloc) => bloc.add(FetchFavNews('category')),
      expect: () => [NewsLoading(), NewsLoaded([])],
    );

    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading, NewsError] when FetchNews fails',
      build: () {
        when(() => newsRepository.fetchNews()).thenThrow(Exception());
        return newsBloc;
      },
      act: (bloc) => bloc.add(FetchNews()),
      expect: () => [NewsLoading(), NewsError('Failed to fetch news: Exception')],
    );

    blocTest<NewsBloc, NewsState>(
      'emits [NewsLoading, NewsError] when FetchFavNews fails',
      build: () {
        when(() => newsRepository.fetchFavNews(any())).thenThrow(Exception());
        return newsBloc;
      },
      act: (bloc) => bloc.add(FetchFavNews('category')),
      expect: () => [NewsLoading(), NewsError('Failed to fetch news: Exception')],
    );
  });
}
