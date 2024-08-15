import 'package:clean_architecture/features/product/data/models/products_models.dart';
import 'package:clean_architecture/features/product/domain/entities/product_entitiy.dart';
import 'package:equatable/equatable.dart';
abstract class ProductEvent extends Equatable {
  const ProductEvent();

@override
  List<Object> get props => [];
}
class LoadAllProductEvent extends ProductEvent {
  const LoadAllProductEvent();
}
class GetsingleProductEvent extends ProductEvent {
  final String id;
  const GetsingleProductEvent(this.id);
  @override
  List<Object> get props => [id];
}
class UpdateProductEvent extends ProductEvent {
  final String id;
  final ProductModel model;
  
  const UpdateProductEvent(this.id,this.model);
  @override
  List<Object> get props => [id, model];
}
class DeleteProductEvent extends ProductEvent {
  final String id;
  const DeleteProductEvent(this.id);
  @override
  List<Object> get props => [id];
}
class CreateProductEvent extends ProductEvent {
  final ProductEntitiy model;
  const CreateProductEvent(this.model);
  @override
  List<Object> get props => [model];
}
