import 'package:algoriza_hotel_app/views/home/home_carousal_item.dart';
import 'package:algoriza_hotel_app/views/home/hotels_item.dart';
import 'package:algoriza_hotel_app/widgets/default_edge_notification_listner.dart';
import 'package:algoriza_hotel_app/widgets/default_loading_indicator.dart';
import 'package:algoriza_hotel_app/widgets/default_text.dart';
import 'package:algoriza_hotel_app/widgets/search_form_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../constants/constant_methods.dart';
import '../../constants/screens.dart';
import '../../data/di/di.dart';
import '../../styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultEdgeNotificationListener(
      onBottom: () {
        sl<HomeCubit>().loadMoreHomeData(sl<HomeCubit>().nextPage);
      },
      child: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            expandedHeight: 30.h,
            elevation: 0,
            pinned: true,
            title: SearchFormField(
              readOnly: true,
              horizontalPadding: 2.w,
              controller: searchController,
              backgroundColor: darkOrLightColor(
                  defaultAppColor4.withOpacity(0.75),
                  defaultBlack.withOpacity(0.4)),
              keyboardType: TextInputType.text,
              hintText: 'Where are you going',
              onTap: () {
                Navigator.pushNamed(context, filterScreenRoute,
                        arguments: searchController.text)
                    .then((searchString) {
                  setState(() {
                    searchController.text = searchString as String;
                  });
                });
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Padding(
                padding: EdgeInsets.only(bottom: 1.0.h, top: 7.5.h),
                child: CarouselSlider(
                  options: CarouselOptions(
                      clipBehavior: Clip.antiAlias,
                      enlargeCenterPage: true,
                      height: 40.h,
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(milliseconds: 2000),
                      viewportFraction: 0.9,
                      enableInfiniteScroll: true),
                  items: List.generate(
                      6,
                      (index) => HomeCarousalItem(
                          imagePath: 'assets/image/home_carosal_$index.jpg')),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 4.w, end: 2.w),
              child: DefaultText(
                  text: 'Best Hotels',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetHotelsSuccessState || state is ShowLoadingState) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: sl<HomeCubit>().homeHotels.data.data.length,
                  (context, index) => HotelsItem(
                      hotelData: sl<HomeCubit>().homeHotels.data.data[index]),
                ));
              } else {
                return const SliverFillRemaining(
                  child: DefaultLoadingIndicator(),
                );
              }
            },
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is ShowLoadingState) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 100));
                  });
                }
                return Visibility(
                    visible: state is ShowLoadingState,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: const DefaultLoadingIndicator(),
                    ));
              },
            ),
          )
        ],
      ),
    ));
  }
}
