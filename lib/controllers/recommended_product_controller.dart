import 'package:deliveries_app/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';

class RecommendedProductController extends GetxController{

  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  Future<void> getRecommendedProductList()async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //_popularProductList.forEach((v) {
      //print((v as ProductsModel).name);
      //});
      _isLoaded = true;
      update();
    }else{

    }
  }

}