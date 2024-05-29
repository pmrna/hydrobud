import 'package:hydrobud/features/navigation/domain/repositories/navigation_repository.dart';

class SelectTab {
  final NavRepository repository;
  SelectTab(this.repository);

  Future<void> call(int index) async {
    return repository.selectTab(index);
  }
}
