import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/injectable.dart';
import 'package:deps/packages/internet_connection_checker_plus.dart';

enum NetworkState { initial, connected, disconnected }

@lazySingleton
class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(this._internetConnection) : super(NetworkState.initial) {
    checkNetwork();
  }
  final InternetConnection _internetConnection;

  Future<void> checkNetwork() async {
    if (await _internetConnection.hasInternetAccess) {
      emit(NetworkState.connected);
    } else {
      emit(NetworkState.disconnected);
    }
  }
}
