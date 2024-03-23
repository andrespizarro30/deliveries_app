import 'package:deliveries_app/controllers/cart_controller.dart';
import 'package:deliveries_app/data/repository/popular_product_repo.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController{

  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductsModel> _popularProductList=[];
  List<ProductsModel> get popularProductList => _popularProductList;

  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList()async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //_popularProductList.forEach((v) {
        //print((v as ProductsModel).name);
      //});
      _isLoaded = true;
      update();
    }else{

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = _quantity + 1;
    }else{
      _quantity = _quantity - 1;
    }

    _quantity = checkQuantity(_quantity);

    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar(
        "Item Count",
        "Item number can't be less than zero",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        duration: Duration(seconds: 1)
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
            return _quantity;
      }
      return 0;
    }else
    if((_inCartItems+quantity)>20){
      Get.snackbar(
          "Item Count",
          "Item number can't be greater than 20",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          duration: Duration(seconds: 1)
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductsModel productsModel,CartController cartController){
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;

    var exist = false;
    exist = _cartController.existInCart(productsModel);

    print("Exists ${exist.toString()}");

    if(exist){
      _inCartItems = _cartController.getQuantity(productsModel);
    }

    print("The quantity of product ${productsModel.id} in the cart is ${_inCartItems}");

    //update();

  }

  void addItem(ProductsModel product){

    _cartController.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);

    _cartController.items.forEach((key, value) {
      print("The id is ${key.toString()} and value is ${value.quantity.toString()}");
    });

    update();

  }

  int get totalItems{
    return _cartController.totalItems;
  }

  List<CartModel> get getItems{
    return _cartController.getItems;
  }


}