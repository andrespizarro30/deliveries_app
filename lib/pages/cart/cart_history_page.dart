import 'package:deliveries_app/controllers/cart_controller.dart';
import 'package:deliveries_app/models/cart_model.dart';
import 'package:deliveries_app/utils/colors.dart';
import 'package:deliveries_app/utils/dimensions.dart';
import 'package:deliveries_app/widgets/app_icon.dart';
import 'package:deliveries_app/widgets/big_text.dart';
import 'package:deliveries_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/app_constants.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    //List<int> orderTimes = Get.find<CartController>().getOrderTimes();
    
    //List<Map<String,List<CartModel>>> groupHistoryDataList = Get.find<CartController>().groupHistoryDataList();

    Map<String,List<CartModel>> groupHistoryDataMap = Get.find<CartController>().groupHistoryDataMap();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                ApplIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: MediaQuery.removePadding(
                  removeTop: true,
                    context: context,
                    child: GetBuilder<CartController>(builder: (controller){
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: groupHistoryDataMap.length,
                          itemBuilder: (context,index){

                            var date = groupHistoryDataMap.keys.elementAt(index);

                            List<CartModel> cartModelList = groupHistoryDataMap.values.elementAt(index);

                            return Container(
                              height: Dimensions.height45*3.2,
                              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ((){
                                    var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
                                    var outputDate = outputFormat.format(DateTime.parse(date));
                                    return Text(outputDate);
                                  }()),
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(cartModelList.length>3?3:cartModelList.length, (index) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                                    width:80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                        color: Colors.white38,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartModelList[index].img!
                                                              //recommendedProduct.img!
                                                            )
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(width: Dimensions.width10,)
                                                ],
                                              );
                                            })
                                        ),
                                        Container(
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SmallText(text: "Total"),
                                              BigText(text: "${cartModelList.length} Items",size: Dimensions.font20,color: AppColors.titleColor,),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                  border: Border.all(width: 1,color: AppColors.mainColor),
                                                ),
                                                child: SmallText(text: "One more",color: AppColors.mainColor,),
                                              )
                                            ],
                                          ),
                                        )
                                      ]
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    }),
                )
              )
          ),
        ],
      ),
    );
  }


}
