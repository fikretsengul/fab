import 'dart:math';

import 'package:deps/features/features.dart';
import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/injectable.dart';

import '../../data/products.service.dart';
import '../../domain/models/category.model.dart';

@injectable
class ProductListCubit extends Cubit<PaginatedListState<ProductModel>> implements PaginatedListCubit<ProductModel> {
  ProductListCubit(this._service) : super(const PaginatedListState.initial());

  final ProductsService _service;

  @override
  Future<void> fetch({
    int offset = 0,
    int limit = 20,
  }) async {
    emit(const PaginatedListState.loading());

    final response = await _service.getProducts(offset: offset, limit: limit);

    response.fold(
      (failure) => emit(PaginatedListState.failed(failure)),
      (products) {
        final newProducts = <ProductModel>[];

        for (var i = 0; i < 30; i++) {
          newProducts.add(
            ProductModel(
              id: i,
              title: '$i Product',
              price: i + 10 * 10,
              discountRate: Random().nextInt(31) + 20,
              description: '$i Product Description',
              images: ['https://picsum.photos/500/500'],
              creationAt: DateTime.now().toString(),
              updatedAt: DateTime.now().toString(),
              category: CategoryModel(
                id: i,
                name: '$i Category',
                image: '',
                creationAt: DateTime.now().toString(),
                updatedAt: DateTime.now().toString(),
              ),
            ),
          );
        }

        emit(PaginatedListState.loaded(newProducts));

        //emit(PaginatedListState.loaded(products));
      },
    );
  }

  void refresh() => emit(const PaginatedListState.refresh());
}
