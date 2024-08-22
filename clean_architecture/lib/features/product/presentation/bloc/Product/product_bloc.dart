import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/product/domain/usecases/add_product.dart';
import 'package:clean_architecture/features/product/domain/usecases/delete_product.dart';
import 'package:clean_architecture/features/product/domain/usecases/get_allproduct.dart';
import 'package:clean_architecture/features/product/domain/usecases/get_specproduct.dart';
import 'package:clean_architecture/features/product/domain/usecases/update_product.dart';


import 'product_event.dart'; 
import 'product_state.dart';
class ProductBloc extends  Bloc<ProductEvent, ProductState> {
final GetAllproductusecase getAllproductusecase;
final GetSpecproductsusecase getSpecproductsusecase;
final DeleteProductusecase deleteProductusecase;
final UpdateProductusecase updateProductusecase;
final AddProductUseCase addProductusecase;
ProductBloc({
  required this.getAllproductusecase,
  required this.getSpecproductsusecase,
  required this.deleteProductusecase,
  required this.updateProductusecase,
  required this.addProductusecase,
}) : super(InitialProductState())
// passing initial state to the parent bloc class
{
    on<LoadAllProductEvent>(_onLoadAllProductEvent);
    on<GetsingleProductEvent>(_onGetSingleProductEvent);
    on<UpdateProductEvent>(_onUpdateProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
    on<CreateProductEvent>(_onCreateProductEvent);
}
Future<void>_onLoadAllProductEvent(LoadAllProductEvent event,Emitter<ProductState>emit)async
{ emit(LoadingProductState()); // start loading
  final result = await getAllproductusecase.getAllproduct();
  // print(state);
  print(result);
  result.fold((failure) =>emit(const ErrorProductState(errorMessage: "unable to fetch products")), (products) =>emit(LoadedProductState(products:products)));


} 

Future<void>_onGetSingleProductEvent(GetsingleProductEvent event , Emitter<ProductState>emit)async
{emit(LoadingProductState());
final result = await getSpecproductsusecase.GetSpecproduct(event.id);
result.fold((failure) => emit(ErrorProductState(errorMessage: 'failed to fetch single product')), (product) => emit(SingleProductLoadedState(product: product)));
}
Future<void>_onUpdateProductEvent(UpdateProductEvent event , Emitter<ProductState>emit)async
{
  emit(LoadingProductState());
  final result = await updateProductusecase.updateproduct(event.id, event.model);
  print(result);
  result.fold((failure) => emit(ErrorProductState(errorMessage: 'failed to update product')), (updatedpro) => emit(UpdatedSuccessProductState(product: updatedpro, successMessage: 'product updated successfully')));
}
Future <void>_onDeleteProductEvent(DeleteProductEvent event,Emitter<ProductState>emit)async 
{
  emit(LoadingProductState());
  final result = await deleteProductusecase.deleteproduct(event.id);
  print(result);
  result.fold((failure) => emit(ErrorProductState(errorMessage: 'product cannot be deleted')), (_)=>emit(Success(message: 'Product Deleted Successfully')));  
}
Future <void>_onCreateProductEvent(CreateProductEvent event,Emitter<ProductState>emit)async 
{
  emit(LoadingProductState());
  final result = await addProductusecase.addProduct(event.model);
print(result);
  result.fold((failure) => emit(ErrorProductState(errorMessage: 'product cannot be added')), (_)=>emit(Success(message: 'Product added Successfully')));  
}

}

