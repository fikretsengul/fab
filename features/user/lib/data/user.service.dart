import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/injectable.dart';

@injectable
class UserService {
  UserService(this._client);

  final INetworkClient _client;
}
