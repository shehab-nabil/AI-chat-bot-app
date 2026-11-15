sealed class Failure {
  const Failure(this.message);

  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ParseFailure extends Failure {
  const ParseFailure(super.message);
}

class StreamFailure extends Failure {
  const StreamFailure(super.message);
}
