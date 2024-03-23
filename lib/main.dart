
import 'package:deliveries_app/controllers/popular_product_controller.dart';
import 'package:deliveries_app/controllers/recommended_product_controller.dart';
import 'package:deliveries_app/pages/food/popular_food_detail.dart';
import 'package:deliveries_app/pages/food/recommended_food_detail.dart';
import 'package:deliveries_app/pages/home/food_page_body.dart';
import 'package:deliveries_app/pages/home/main_food_page.dart';
import 'package:deliveries_app/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'helper/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetBuilder<CartController>(builder: (_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            //home: MainFoodPage(),
            initialRoute: RouteHelper.getSplash(),
            getPages: RouteHelper.routes,
          );
        });
      });
    });
  }
}