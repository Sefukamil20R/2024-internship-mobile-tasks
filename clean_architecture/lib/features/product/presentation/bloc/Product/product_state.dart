import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}
//initial state
class InitialProductState extends ProductState {}
//loading state
class LoadingProductState extends ProductState {}
//loaded state
class LoadedProductState extends ProductState {
  final List<ProductEntitiy> products;

  const LoadedProductState({required this.products });

  @override
  List<Object> get props => [products];
}
// when single product is successfully retrieved
class SingleProductLoadedState extends ProductState {
  final ProductEntitiy product;

  const SingleProductLoadedState({required this.product });

  @override
  List<Object> get props => [product];
}
// state when there is an  error 
class ErrorProductState extends ProductState {
  final String errorMessage;

  const ErrorProductState({required this.errorMessage });

  @override
  List<Object> get props => [errorMessage];
}
class UpdatedSuccessProductState extends ProductState {
  final ProductEntitiy product;
  final String successMessage;

  const UpdatedSuccessProductState({required this.product , required this.successMessage});

  @override
  List<Object> get props => [product, successMessage];
}
class Success extends ProductState {
  final String message;

  const Success({required this.message });

  @override
  List<Object> get props => [message];
}
class SuccessProductState extends ProductState {
  final ProductEntitiy product;

  const SuccessProductState(this.product);
}
