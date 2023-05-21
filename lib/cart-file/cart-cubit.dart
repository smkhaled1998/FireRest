import 'package:firerest/cart-file/cart-states.dart';
import 'package:firerest/models/cart-model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates>{
  CartCubit():super(CartInitialState());

  static CartCubit get(context)=>BlocProvider.of(context);

  // List <CartModel> cartItems=[];
  // CartModel? cartModel;
  // void addItemsToCart(name,img){
  //   cartModel=CartModel(img:img,name: name );
  //   cartItems.add(cartModel!);
  //   emit(CartAddItemSuccessState());
  // }

}