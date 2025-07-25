import 'package:astro_test_app/core/errors/failures.dart';
import 'package:astro_test_app/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/main_entity.dart';
import '../repositories/main_repository.dart';

class GetMainData implements UseCase<MainEntity, NoParams> {
  final MainRepository repository;

  GetMainData(this.repository);

  @override
  Future<Either<Failure, MainEntity>> call(NoParams params) async {
    try {
      final result = await repository.getMainData();
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
