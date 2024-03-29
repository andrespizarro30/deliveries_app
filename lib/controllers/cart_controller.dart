import 'package:deliveries_app/data/repository/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController{

  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int,CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductsModel product, int quantity){

    var totalQuantity = 0 ;

    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value){

        totalQuantity = value.quantity!+quantity;

        return CartModel(
            id : value.id!,
            name : value.name!,
            description : value.description!,
            price : value.price!,
            img : value.img!,
            quantity : value.quantity!+quantity,
            isExist : true,
            time : DateTime.now().toString(),
            productModel: product
        );
      });

      if(totalQuantity<=0){
        _items.remove(product.id!);
      }

    }else{
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id : product.id!,
              name : product.name!,
              description : product.description!,
              price : product.price!,
              img : product.img!,
              quantity : quantity,
              isExist : true,
              time : DateTime.now().toString(),
              productModel: product
          );
        });
      }else{
        Get.snackbar(
            "Item Count",
            "At least one item must be added",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white,
            duration: Duration(seconds: 2)
        );
      }
    }
    
    cartRepo.addToCartList(getItems);

    update();

  }

  existInCart(ProductsModel productsModel){
    if(_items.containsKey(productsModel.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductsModel productsModel){
    var quantity = 0;
    if(_items.containsKey(productsModel.id)){
      _items.forEach((key, value) {
        if(productsModel.id == key){
          quantity = value.quantity!;
        }
      });
      //quantity = _items[productsModel.id]!.quantity!;
    }
    return quantity;
  }

  int get totalItems{

    var totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{

    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  List<CartModel> getCartData(){

    setCart = cartRepo.getCartList();

    return storageItems;

  }

  set setCart(List<CartModel> items){

    storageItems =  items;

    for(int i = 0; i < storageItems.length ; i++){

      _items.putIfAbsent(storageItems[i].productModel!.id!, () => storageItems[i]);

    }

  }

  void addToHistoryList(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  List<int> getOrderTimes(){
    return cartRepo.cartOrderTimeToList();
  }

  Map<String,List<CartModel>> groupHistoryDataMap(){
    return cartRepo.groupHistoryDataMap();
  }

  List<Map<String,List<CartModel>>> groupHistoryDataList(){
    return cartRepo.groupHistoryDataList();
  }

}