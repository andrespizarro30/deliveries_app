import 'package:deliveries_app/controllers/cart_controller.dart';
import 'package:deliveries_app/controllers/recommended_product_controller.dart';
import 'package:deliveries_app/models/products_model.dart';
import 'package:deliveries_app/pages/home/main_food_page.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:deliveries_app/widgets/app_icon.dart';
import 'package:deliveries_app/widgets/big_text.dart';
import 'package:deliveries_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ApplIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(width: Dimensions.width20*5,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: ApplIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                GetBuilder<CartController>(builder: (controller){
                  return Stack(
                    children: [
                      ApplIcon(
                        icon: Icons.shopping_cart_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                      controller.totalItems>=1 ?
                      Positioned(
                          right: 0,
                          top: 0,
                          child: ApplIcon(
                            icon: Icons.circle,
                            size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.iconColor2,
                          )
                      ) :
                      Container(),
                      controller.totalItems>=1 ?
                      Positioned(
                        right: 3,
                        top: 3,
                        child: SmallText(
                          text: controller.totalItems.toString(),
                          color: Colors.white,
                          size: 12,
                        ),
                      ) :
                      Container()
                    ],
                  );
                })
              ],
            )
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (controller){

                  var _cartList = controller.getItems;

                  return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_,index){
                        return Container(
                          height: 100,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  var popularIndex = Get.find<PopularProductController>()
                                      .popularProductList
                                      .indexOf(_cartList[index].productModel!);

                                  if(popularIndex>=0){
                                    Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartPage"));
                                  }else{
                                    var recommendedIndex = Get.find<RecommendedProductController>()
                                        .recommendedProductList
                                        .indexOf(_cartList[index].productModel!);

                                    Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartPage"));

                                  }
                                },
                                child: Container(
                                  width: Dimensions.width20 * 5,
                                  height: Dimensions.height20 * 5,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            AppConstants.BASE_URL + AppConstants.UPLOAD_URL + _cartList[index].img!
                                          )
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Expanded(
                                  child: Container(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: _cartList[index].name!,color: Colors.black,),
                                        SmallText(text: _cartList[index].description!,overflow: TextOverflow.ellipsis,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "\$ ${_cartList[index].price!.toString()}",color: Colors.redAccent,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,right: Dimensions.height10,left: Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                      color: Colors.white
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap:(){
                                                            controller.addItem(_cartList[index].productModel!, -1);
                                                          },
                                                          child: Icon(Icons.remove,color: AppColors.signColor,)
                                                      ),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      BigText(
                                                          text: _cartList[index].quantity!.toString()
                                                      ),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      GestureDetector(
                                                          onTap: (){
                                                            controller.addItem(_cartList[index].productModel!, 1);
                                                          },
                                                          child: Icon(Icons.add,color: AppColors.signColor,)
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                        );
                      });
                }),
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackGroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20*2),
                topLeft: Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(
                        text: "\$ ${controller.totalAmount.toString()}"
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  controller.addToHistoryList();
                  Get.find<CartController>().cartRepo.printHistoryList();
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                  child: BigText(text: "Confirm", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
