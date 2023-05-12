import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../const/AppColors.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  final _product = Get.arguments[0]["product"];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => Changes(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const CircleAvatar(
                  backgroundColor: AppColors.deepOrange,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart,
                  size: 28,
                  color: AppColors.deepOrange,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: screenSize.height / 4,
                      width: double.infinity,
                      child: CarouselSlider(
                        items: _product["product-images"]
                            .map<Widget>(
                              (item) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          // autoPlay: true,
                          // autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.easeInCubic,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (val, carouselPageChangedReason) {
                            Provider.of<Changes>(context, listen: false)
                                .changeDotPosition(val);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: DotsIndicator(
                      dotsCount: _product["product-images"].isEmpty
                          ? 1
                          : _product["product-images"].length,
                      position:
                          Provider.of<Changes>(context)._dotPosition.toDouble(),
                      decorator: DotsDecorator(
                        activeColor: AppColors.deepOrange,
                        color: AppColors.deepOrange.withOpacity(0.5),
                        spacing: const EdgeInsets.all(2),
                        activeSize: const Size(8, 8),
                        size: const Size(6, 6),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text(
                        _product["product-name"],
                        style: TextStyle(
                            color: AppColors.deepOrange, fontSize: 25.sm),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.deepOrange,
                        ),
                        child: Text(
                          "\$ ${_product["product-price"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sm,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(65, 255, 107, 107),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _product["product-description"],
                      style: TextStyle(fontSize: 15.sm, height: 1.3),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        itemSize: 18,
                        initialRating: double.parse(_product["product-rating"]),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColors.deepOrange,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.deepOrange,
                              borderRadius: BorderRadius.circular(5.sm)),
                          child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      const Color.fromARGB(32, 171, 97, 97))),
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sm,
                                ),
                              ),
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Changes extends ChangeNotifier {
  int _dotPosition = 0;

  void changeDotPosition(int i) {
    _dotPosition = i;
    notifyListeners();
  }
}
