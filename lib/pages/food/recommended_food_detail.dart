import 'package:deliveries_app/controllers/recommended_product_controller.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:deliveries_app/widgets/app_icon.dart';
import 'package:deliveries_app/widgets/big_text.dart';
import 'package:deliveries_app/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class RecommendedFoodDetail extends StatelessWidget {

  int pageId;

  RecommendedFoodDetail({
    super.key,
    required this.pageId
  });

  @override
  Widget build(BuildContext context) {

    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId] as ProductsModel;

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
                    Get.toNamed(RouteHelper.getInitial());
                  },
                ),
                ApplIcon(icon: Icons.shopping_cart_outlined)
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
            pinned: true,
            backgroundColor: Colors.orangeAccent,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  //AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                  product.img!,
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
      bottomNavigationBar: Column(
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
                ApplIcon(
                  icon: Icons.remove,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                BigText(text: "\$ ${product.price}"+" x "+"0",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                ApplIcon(
                  icon: Icons.add,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
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
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
                  child: BigText(text: "\$ ${product.price} | Add to cart", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
