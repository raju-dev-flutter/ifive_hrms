import 'package:dartz/dartz.dart';

import '../core.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;

typedef DataMapString = Map<String, String>;
