import 'package:deliveries_app/controllers/cart_controller.dart';
import 'package:deliveries_app/models/products_model.dart';
import 'package:deliveries_app/pages/cart/cart_page.dart';
import 'package:deliveries_app/pages/home/main_food_page.dart';
import 'package:deliveries_app/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/food_detail_column.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {

  int pageId;

  PopularFoodDetail({
    super.key,
    required this.pageId
  });

  @override
  Widget build(BuildContext context) {

    var product = Get.find<PopularProductController>().popularProductList[pageId] as ProductsModel;
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!
                        //product.img!
                    ),
                    fit: BoxFit.cover
                  )
                ),
              )
          ),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: ApplIcon(icon: Icons.arrow_back_ios)
                  ),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>CartPage());
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
                              text: Get.find<PopularProductController>().totalItems.toString(),
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
              )
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-Dimensions.height20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20)
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColumnFoodDetail(text: product.name!,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableText(text: product.description!)
                      ),
                    )
                  ],
                )
              )
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
                    GestureDetector(
                        onTap:(){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove,color: AppColors.signColor,)
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(
                        text: popularProduct.inCartItems.toString()
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add,color: AppColors.signColor,)
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                  child: BigText(text: "\$ ${product.price!} | Add to cart", color: Colors.white,),
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
