// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:deps/infrastructure/infrastructure.dart';
import 'package:deps/packages/injectable.dart';

import '../domain/models/product.model.dart';

@lazySingleton
class ProductsService {
  ProductsService(this._client);

  final INetworkClient _client;

  AsyncEither<List<ProductModel>> getProducts({
    required int offset,
    required int limit,
  }) async {
    return _client.invoke<ProductModel, List<ProductModel>>(
      '/products?limit=$limit&offset=$offset',
      RequestType.get,
      fromJson: ProductModel.fromJson,
    );
  }
}
