import 'package:blogster/core/errors/failures.dart';
import 'package:blogster/core/usecase/usecase.dart';
import 'package:blogster/features/blog/domain/entities/blog.dart';
import 'package:blogster/features/blog/domain/repos/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
