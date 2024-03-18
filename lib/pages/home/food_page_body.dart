import 'package:deliveries_app/controllers/popular_product_controller.dart';
import 'package:deliveries_app/controllers/recommended_product_controller.dart';
import 'package:deliveries_app/models/products_model.dart';
import 'package:deliveries_app/pages/food/popular_food_detail.dart';
import 'package:deliveries_app/routes/route_helper.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:deliveries_app/widgets/big_text.dart';
import 'package:deliveries_app/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/food_detail_column.dart';
import '../../widgets/icon_and_text_widget.dart';


class FoodBodyPage extends StatefulWidget {
  const FoodBodyPage({super.key});

  @override
  State<FoodBodyPage> createState() => _FoodBodyPageState();
}

class _FoodBodyPageState extends State<FoodBodyPage> {

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          GetBuilder<PopularProductController>(builder: (popularProducts){
            return popularProducts.isLoaded ? Container(
              color: Colors.white,
              height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getPopularFood(position));
                        },
                        child: _buildPageItem(position,popularProducts.popularProductList[position])
                    );
                  }
              ),
            ) : CircularProgressIndicator(color: AppColors.mainColor,backgroundColor: Colors.white,);
          }),
          GetBuilder<PopularProductController>(builder: (popularProducts){
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length,
              position: _currPageValue.round(),
              decorator: DotsDecorator(
                color: Colors.grey,
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }),
          SizedBox(height: Dimensions.height30,),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Recommended"),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(text: ".",color: Colors.black26,),
                ),
                SizedBox(width: Dimensions.width10,),
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food Combining",color: Colors.black26,),
                ),
              ],
            ),
          ),
          GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
            return recommendedProducts.isLoaded ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProducts.recommendedProductList.length,
              itemBuilder: (context,index){

                ProductsModel recommendedProduct = recommendedProducts.recommendedProductList[index] as ProductsModel;

                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        Container(
                          width:Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  AppConstants.BASE_URL + AppConstants.UPLOAD_URL + recommendedProduct.img!
                                //popularProducts.img!
                              )
                            )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20)
                              ),
                              color: Colors.white
                            ),
                            child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProduct.name!),
                                SizedBox(height: Dimensions.height10,),
                                SmallText(text: recommendedProduct.description!,overflow: TextOverflow.ellipsis,),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      icon: Icons.circle_sharp,
                                      text: "Normal",
                                      iconColor: AppColors.iconColor1,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.location_on,
                                      text: "1.5km",
                                      iconColor: AppColors.mainColor,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: "24mins",
                                      iconColor: AppColors.iconColor2,
                                    )
                                  ],
                                )
                              ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                                ),
                );
            }) : CircularProgressIndicator(color: AppColors.mainColor,);
          })
      ],
    );
  }

  Widget _buildPageItem(int index,ProductsModel popularProducts) {

    Matrix4 matrix = new Matrix4.identity();

    if(index==_currPageValue.floor()){
      var currScale = 1 - (_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if (index == _currPageValue.floor()-1){
      var currScale = 1 - (_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
            Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                //color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                image: DecorationImage(
                  image: NetworkImage(
                      AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProducts.img!
                      //popularProducts.img!
                  ),
                  fit: BoxFit.cover
                )
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor,
                      blurRadius: 5.0,
                      offset: Offset(0,5)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5,0)
                    )
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width15,right: Dimensions.width15),
                child: ColumnFoodDetail(text: popularProducts.name!,)
              ),
            ),
          )
        ],
      ),
    );
  }

}


