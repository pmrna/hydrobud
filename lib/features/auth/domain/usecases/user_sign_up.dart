import 'package:fpdart/fpdart.dart';
import 'package:hydrobud/core/error/failures.dart';
import 'package:hydrobud/core/usecase/usecase.dart';
import 'package:hydrobud/core/common/entities/user.dart';
import 'package:hydrobud/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
