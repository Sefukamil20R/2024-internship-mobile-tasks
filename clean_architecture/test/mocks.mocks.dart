// Mocks generated by Mockito 5.4.4 from annotations
// in clean_architecture/test/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:clean_architecture/core/error/failure.dart' as _i5;
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart'
    as _i6;
import 'package:clean_architecture/features/product/domain/repositories/product_repositories.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProductRepositories].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductRepositories extends _i1.Mock
    implements _i3.ProductRepositories {
  MockProductRepositories() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ProductEntitiy>>>
      getAllProducts() => (super.noSuchMethod(
            Invocation.method(
              #getAllProducts,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure, List<_i6.ProductEntitiy>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.ProductEntitiy>>(
              this,
              Invocation.method(
                #getAllProducts,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.ProductEntitiy>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>> getProductById(
          int? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProductById,
          [productId],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>.value(
                _FakeEither_0<_i5.Failure, _i6.ProductEntitiy>(
          this,
          Invocation.method(
            #getProductById,
            [productId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>> addproduct(
          _i6.ProductEntitiy? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #addproduct,
          [product],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>.value(
                _FakeEither_0<_i5.Failure, _i6.ProductEntitiy>(
          this,
          Invocation.method(
            #addproduct,
            [product],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>> updateproduct(
          int? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateproduct,
          [productId],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>.value(
                _FakeEither_0<_i5.Failure, _i6.ProductEntitiy>(
          this,
          Invocation.method(
            #updateproduct,
            [productId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>> deleteproduct(
          int? productId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteproduct,
          [productId],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>.value(
                _FakeEither_0<_i5.Failure, _i6.ProductEntitiy>(
          this,
          Invocation.method(
            #deleteproduct,
            [productId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductEntitiy>>);
}
