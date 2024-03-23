import 'dart:async';

import 'package:deliveries_app/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadResources();

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    )..forward();

    animation = CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInQuart
    );

    Timer(
      const Duration(seconds: 3),
      ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellowColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo.jpg",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10,),
          Center(
            child: Image.asset(
              "assets/image/slogan_here.jpg",
              height: Dimensions.splashImg/3,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _loadResources() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<CartController>().getCartData();
  }

}
