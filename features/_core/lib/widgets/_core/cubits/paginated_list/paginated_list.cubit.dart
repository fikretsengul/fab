import 'package:deps/packages/flutter_bloc.dart';

import 'paginated_list.state.dart';

abstract class PaginatedListCubit<T> implements Cubit<PaginatedListState<T>> {
  Future<void> fetch({int offset = 0, int limit = 20});
}
