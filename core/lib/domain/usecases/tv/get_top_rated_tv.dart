import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
