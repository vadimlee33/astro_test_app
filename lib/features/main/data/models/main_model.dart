import '../../domain/entities/main_entity.dart';

class MainModel extends MainEntity {
  const MainModel();

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return const MainModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
} 