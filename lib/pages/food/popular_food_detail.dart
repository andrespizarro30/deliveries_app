import 'package:deliveries_app/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/food_detail_column.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage(
                      "assets/image/food3.jpg"
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
                  ApplIcon(icon: Icons.arrow_back_ios),
                  ApplIcon(icon: Icons.shopping_cart_outlined)
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
                    ColumnFoodDetail(text: "Japanesse Food",),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableText(text: "Chicken korma is a luxurious and aromatic dish that hails from the Indian subcontinent, known for its rich flavors and creamy texture. Traditionally, it features tender pieces of chicken cooked in a velvety sauce infused with a blend of spices and thickened with cream or yogurt. Here's a detailed description of this delectable dish:                          Appearance: pon serving, chicken korma presents itself as a luscious ensemble of golden-hued chicken pieces nestled in a creamy, slightly off-white sauce. The sauce coats the chicken, providing a glossy sheen that hints at its richness. Aroma: The aroma of chicken korma is nothing short of captivating. As it wafts through the air, one is greeted by a harmonious blend of fragrant spices such as cardamom, cinnamon, cloves, and nutmeg, all mingling with the subtle sweetness of onions and the earthiness of garlic and ginger. The scent is warm, inviting, and deeply comforting. Texture: The texture of chicken korma is a key element of its appeal. The chicken itself is tender and succulent, having absorbed the flavors of the sauce during the cooking process. The sauce, on the other hand, is smooth and creamy, with a luxurious mouthfeel that is both velvety and indulgent. Slivers of almonds or cashews may be scattered throughout, adding a delightful crunch to each bite. Flavor Profile: The flavor profile of chicken korma is a complex symphony of tastes that dance across the palate. At first bite, one experiences a subtle sweetness, derived from caramelized onions and perhaps a hint of honey or sugar. This sweetness is quickly balanced by the savory notes of the spices, which impart warmth and depth to the dish. The creaminess of the sauce lends a luxurious richness, while the addition of yogurt or coconut milk provides a subtle tanginess that cuts through the richness, keeping the flavors well-rounded and balanced. Accompaniments: Chicken korma is often served alongside fragrant basmati rice, which serves as the perfect canvas for soaking up the decadent sauce. Naan or roti, traditional Indian breads, are also popular accompaniments, offering a satisfying contrast in texture and flavor. A garnish of fresh cilantro or chopped nuts adds a final touch of freshness and crunch to the dish. Overall, chicken korma is a dish that delights the senses with its enticing aroma, sumptuous texture, and complex yet harmonious flavors. It is a true culinary indulgence, perfect for special occasions or whenever one craves a taste of luxury.")
                      ),
                    )
                  ],
                )
              )
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
                  Icon(Icons.remove,color: AppColors.signColor,),
                  SizedBox(width: Dimensions.width10/2,),
                  BigText(text: "0"),
                  SizedBox(width: Dimensions.width10/2,),
                  Icon(Icons.add,color: AppColors.signColor,),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,right: Dimensions.width20,left: Dimensions.width20),
              child: BigText(text: "\$10 | Add to cart", color: Colors.white,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
