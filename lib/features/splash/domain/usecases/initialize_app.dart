import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/app/data_repository/user/user_repository.dart';
import '../../../auth/domain/usecases/get_current_user.dart';

class InitializeApp implements UseCase<void, NoParams> {
  final GetCurrentUser getCurrentUser;
  final UserRepository userService;

  const InitializeApp({
    required this.getCurrentUser,
    required this.userService,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      final result = await getCurrentUser(const NoParams());
      result.fold(
        (failure) {
          userService.clearUser();
        },
        (user) {
          if (user != null) {
            userService.setUser(user);
          } else {
            userService.clearUser();
          }
        },
      );

      await Future.delayed(const Duration(seconds: 2));

      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
