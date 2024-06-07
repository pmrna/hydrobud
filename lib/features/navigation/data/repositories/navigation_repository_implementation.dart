import 'package:hydrobud/features/navigation/domain/repositories/navigation_repository.dart';

class NavRepoImplementation implements NavRepository {
  int _selectedTab = 0;

  @override
  Future<void> selectTab(int index) async {
    _selectedTab = index;
  }

  @override
  int getSelectedTab() {
    return _selectedTab;
  }
}
