import '../../domain/entities/main_entity.dart';
import '../../domain/repositories/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  @override
  Future<MainEntity> getMainData() async {
    return const MainEntity();
  }
}
