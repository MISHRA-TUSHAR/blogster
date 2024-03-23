import 'package:blogster/core/errors/failures.dart';
import 'package:blogster/core/usecase/usecase.dart';
import 'package:blogster/core/common/entities/user.dart';
import 'package:blogster/features/auth/domain/repos/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
