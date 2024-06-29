import '../../../features/model/user/user.dart';
import '../../../internal/entities/either.dart';
import '../repository_error.dart';

abstract class UserRepository {
  Future<Either<RepositoryError, List<User>>> getUsers();
}
