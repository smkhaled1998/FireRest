import 'package:firerest/cart-file/cart-states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates>{
  CartCubit():super(CartInitialState());

  static CartCubit get(context)=>BlocProvider.of(context);


  int orderQuantity=0;
  void addOrder(){

  }

}