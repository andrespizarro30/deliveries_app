
import 'package:deliveries_app/controllers/popular_product_controller.dart';
import 'package:deliveries_app/pages/food/popular_food_detail.dart';
import 'package:deliveries_app/pages/food/recommended_food_detail.dart';
import 'package:deliveries_app/pages/home/food_page_body.dart';
import 'package:deliveries_app/pages/home/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    Get.find<PopularProductController>().getPopularProductList();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainFoodPage(),
    );
  }
}