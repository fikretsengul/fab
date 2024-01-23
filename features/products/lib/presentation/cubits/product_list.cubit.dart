import 'package:deps/features/features.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/injectable.dart';

import '../../data/products.service.dart';
import '../../domain/models/product.model.dart';

@injectable
class ProductListCubit extends Cubit<PaginatedListState<ProductModel>> {
  ProductListCubit(this._service) : super(const PaginatedListState.initial());

  final ProductsService _service;

  Future<void> getProducts({
    int offset = 0,
    int limit = 20,
  }) async {
    emit(const PaginatedListState.loading());

    final response = await _service.getProducts(offset: offset, limit: limit);

    response.fold(
      (failure) => emit(PaginatedListState.failed(failure)),
      (products) => emit(PaginatedListState.loaded(products)),
    );
  }

  void refresh() => emit(const PaginatedListState.refresh());
}
