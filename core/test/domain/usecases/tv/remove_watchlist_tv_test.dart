import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvRepository extends Mock implements TvRepository{}

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlistTv(mockTvRepository);
  });

  test('should remove watchlist Tv from repository', () async {
    // arrange
    when(()=> mockTvRepository.removeWatchlistTv(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(()=> mockTvRepository.removeWatchlistTv(testTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
