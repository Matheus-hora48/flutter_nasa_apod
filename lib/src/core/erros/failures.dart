abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerFailure && other.message == message);

  @override
  int get hashCode => message.hashCode;
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
