import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/const/routes.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../const/AppColors.dart';
import '../../database/access_data.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _searchController;

  final List<String> _carouselImages = [];
  final List _products = [];
  _fetchCarouselImages() {
    AccessData.fetchCarouselImages(_carouselImages);
  }

  _fetchProductsInfo() {
    AccessData.fetchProductsInfo(_products);
  }

  @override
  void initState() {
    _fetchCarouselImages();
    _fetchProductsInfo();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => Changes(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: null,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(searchRoute);
                            },
                            child: const Icon(
                              Icons.track_changes_outlined,
                              color: AppColors.deepOrange,
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width / 1.6,
                            height: 45,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 18),
                              controller: _searchController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.deepOrange,
                                  size: 30.sm,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.sm, color: AppColors.deepOrange),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.sm, color: AppColors.deepOrange),
                                ),
                                label: const Text("Search Products"),
                                labelStyle: TextStyle(fontSize: 18.sm),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              cursorColor: AppColors.deepOrange,
                            ),
                          ),
                          const Icon(Icons.person_outline_rounded,
                              color: AppColors.deepOrange)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: screenSize.height / 5,
                      width: double.maxFinite,
                      child: CarouselSlider(
                        items: _carouselImages
                            .map(
                              (item) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
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
                    SizedBox(
                      height: 10.h,
                    ),
                    DotsIndicator(
                      dotsCount:
                          _carouselImages.isEmpty ? 1 : _carouselImages.length,
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
                    SizedBox(
                      height: 7.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                  fontSize: 20.sm, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7.5.h,
                    ),
                    SizedBox(
                      height: 280.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.sm),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _products.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 135.w,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 15),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(productDetailsRoute, arguments: [
                                  {"product": _products[index]}
                                ]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.7,
                                    child: Image.network(
                                      _products[index]["product-images"][0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 1),
                                    child: Text(
                                      "${_products[index]["product-name"]}",
                                      style: TextStyle(
                                        fontSize: 16.sm,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: Text(
                                      "\$ ${_products[index]["product-price"]}",
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.5.h,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Hot ",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20.sm,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.fireplace_outlined,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.5.h,
                    ),
                    SizedBox(
                      height: 450.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.sm),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _products.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            return UnconstrainedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  // decoration: BoxDecoration(border: Border.all()),
                                  width: screenSize.width * 0.75,
                                  height: 100.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                48, 255, 107, 107),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(15)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _products[index]
                                                        ["product-name"],
                                                    style: TextStyle(
                                                      fontSize: 15.sm,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Sale 45% off",
                                                    style: TextStyle(
                                                      fontSize: 10.sm,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 75.w,
                                                    height: 28.h,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .deepOrange,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.sm)),
                                                    child: TextButton(
                                                        style: ButtonStyle(
                                                          overlayColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            const Color
                                                                    .fromARGB(
                                                                32,
                                                                171,
                                                                97,
                                                                97),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "Shop",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10.sm,
                                                          ),
                                                        ),
                                                        onPressed: () {}),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      AspectRatio(
                                        aspectRatio: 1.35,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(15)),
                                          child: Image.network(
                                            _products[index]["product-images"]
                                                [0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "For You",
                              style: TextStyle(
                                  fontSize: 20.sm, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sm),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: _products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 7.5,
                        ),
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              decoration: BoxDecoration(boxShadow: const [
                                BoxShadow(
                                  color: AppColors.deepOrange,
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ], borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.25,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image.network(
                                        _products[index]["product-images"][0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          _products[index]["product-name"],
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.sm,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: AppColors.deepOrange,
                                              size: 10.sm,
                                            ),
                                            Text(
                                              "${_products[index]["product-rating"]}/5",
                                              style: TextStyle(
                                                fontSize: 10.sm,
                                                color: AppColors.deepOrange,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 2, 8, 2),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.deepOrange),
                                            borderRadius:
                                                BorderRadius.circular(2.5),
                                          ),
                                          child: Text(
                                            _products[index]["product-quality"],
                                            style: TextStyle(
                                              fontSize: 12.sm,
                                              color: AppColors.deepOrange,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          _products[index]["product-price"],
                                          style: TextStyle(
                                              fontSize: 12.sm,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
