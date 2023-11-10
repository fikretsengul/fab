import 'package:deps/fpdart.dart';

import '../errors/failure.dart';

typedef AsyncEither<T> = Future<Either<Failure, T>>;
typedef SyncEither<T> = Either<Failure, T>;
