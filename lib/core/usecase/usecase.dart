import 'package:fpdart/fpdart.dart';
import 'package:hydrobud/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
