import 'package:deliveries_app/controllers/cart_controller.dart';
import 'package:deliveries_app/pages/home/main_food_page.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:deliveries_app/widgets/app_icon.dart';
import 'package:deliveries_app/widgets/big_text.dart';
import 'package:deliveries_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
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
                    Get.to(()=>MainFoodPage());
                  },
                  child: ApplIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children: [
                      ApplIcon(
                        icon: Icons.home_outlined,
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
                  return ListView.builder(
                      itemCount: controller.getItems.length,
                      itemBuilder: (_,index){
                        return Container(
                          height: 100,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.width20 * 5,
                                height: Dimensions.height20 * 5,
                                margin: EdgeInsets.only(bottom: Dimensions.height10),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.BASE_URL + AppConstants.UPLOAD_URL + controller.getItems[index].img!
                                        )
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.white
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
                                        BigText(text: controller.getItems[index].name!,color: Colors.black,),
                                        SmallText(text: controller.getItems[index].description!,overflow: TextOverflow.ellipsis,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "\$ ${controller.getItems[index].price!.toString()}",color: Colors.redAccent,),
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
                                                            //popularProduct.setQuantity(false);
                                                          },
                                                          child: Icon(Icons.remove,color: AppColors.signColor,)
                                                      ),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      BigText(
                                                          text: controller.getItems[index].quantity!.toString()
                                                      ),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      GestureDetector(
                                                          onTap: (){
                                                            //popularProduct.setQuantity(true);
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
    );
  }
}
