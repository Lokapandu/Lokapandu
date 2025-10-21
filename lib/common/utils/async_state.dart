sealed class AsyncState<T> {
  const AsyncState();
}

class Idle<T> extends AsyncState<T> {
  const Idle();
}

class Loading<T> extends AsyncState<T> {
  final T? previous; // for SWR: show previous data when loading
  const Loading([this.previous]);
}

class Success<T> extends AsyncState<T> {
  final T data;

  const Success(this.data);
}

class FailureState<T> extends AsyncState<T> {
  final Object error;
  final StackTrace? stackTrace;

  const FailureState(this.error, [this.stackTrace]);
}
