import 'package:deliveries_app/controllers/recommended_product_controller.dart';
import 'package:deliveries_app/pages/cart/cart_page.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:deliveries_app/widgets/app_icon.dart';
import 'package:deliveries_app/widgets/big_text.dart';
import 'package:deliveries_app/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';

class RecommendedFoodDetail extends StatelessWidget {

  int pageId;
  String page;

  RecommendedFoodDetail({
    super.key,
    required this.pageId,
    required this.page
  });

  @override
  Widget build(BuildContext context) {

    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId] as ProductsModel;
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height40*2,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: ApplIcon(icon: Icons.clear),
                  onTap: (){
                    if(page=='cartPage'){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1){
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        ApplIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems>=1 ?
                        Positioned(
                            right: 0,
                            top: 0,
                            child: ApplIcon(
                              icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
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
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height40),
              child: Container(
                child: Center(child: BigText(text: product.name!,size: Dimensions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top:5,bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)
                  )
                ),
              ),
            ),
            pinned: false,
            backgroundColor: Colors.orangeAccent,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                  //product.img!,
                  fit: BoxFit.cover,
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.height20),
                    child: ExpandableText(text: product.description!)
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: ApplIcon(
                      icon: Icons.remove,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  BigText(text: "\$ ${product.price} x ${controller.inCartItems}",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: ApplIcon(
                      icon: Icons.add,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  )
                ],
              ),
            ),
            Container(
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
                      child: Icon(Icons.favorite,color: AppColors.mainColor,)
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                      child: BigText(text: "\$ ${product.price} | Add to cart", color: Colors.white,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
