// ignore_for_file: unused_result

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ready_artisans/components/category_item.dart';
import 'package:ready_artisans/components/custom_button.dart';
import 'package:ready_artisans/components/text_inputs.dart';
import 'package:ready_artisans/pages/home_page/components/near_me_page/near_me.dart';
import 'package:ready_artisans/state_managers/category_data_state.dart';
import 'package:ready_artisans/state_managers/location_data_state.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/styles/styles.dart';
import '../../../constant/functions.dart';
import '../../../state_managers/artisans_data_state.dart';
import 'artisan_card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final FocusNode _focus = FocusNode();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var categories = ref.watch(categoryStreamProvider);
    var artisans = ref.watch(artisanStreamProvider);
    var location = ref.watch(locationStreamProvider);
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Column(children: [
        Container(
          height: 170,
          width: size.width,
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //show user location
              location.when(data: (data) {
                var data = ref.watch(locationProvider);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:
                        const Icon(Icons.location_pin, color: Colors.white),
                    title: Text(
                      '${data.city},${data.district}, ${data.region}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: normalText(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        //todo pick location from map
                      },
                      child: const Text(
                        'Change',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }, error: (e, s) {
                return Column(
                  children: [
                    Text(
                      'Unable to get location',
                      style: normalText(color: Colors.white),
                    ),
                    //todo add button to refresh location
                    TextButton(
                        onPressed: () {
                          ref.invalidate(locationStreamProvider);
                          ref.refresh(locationStreamProvider);
                        },
                        child: const Text(
                          'Refresh',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ))
                  ],
                );
              }, loading: () {
                return Column(
                  children: [
                    Text(
                      'Getting your location... make sure you have internet',
                      style: normalText(color: Colors.white),
                    ),
                    const LinearProgressIndicator(
                      color: Colors.white,
                      minHeight: 3,
                    ),
                  ],
                );
              }),

              const Divider(
                height: 10,
                thickness: 5,
                endIndent: 10,
                indent: 10,
                color: Colors.grey,
              ),
              Text('What are you looking for?',
                  style: normalText(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: CustomTextFields(
                  hintText: "Search artisans",
                  focusNode: _focus,
                  controller: _controller,
                  suffixIcon: _focus.hasFocus
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              ref
                                  .read(artisansFilterProvider.notifier)
                                  .filterArtisansByName('');
                              _focus.unfocus();
                            });
                          },
                          icon: const Icon(Icons.close, color: primaryColor))
                      : const Icon(Icons.search, color: primaryColor),
                  onChanged: (value) {
                    ref
                        .read(artisansFilterProvider.notifier)
                        .filterArtisansByName(value);
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (_focus.hasFocus)
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: ref.watch(artisansFilterProvider).filter.length,
                itemBuilder: (context, index) {
                  var artisan = ref.watch(artisansFilterProvider).filter[index];
                  return ArtisanCard(
                    artisan: artisan,
                    isRated: true,
                  );
                }),
          ),
        if (!_focus.hasFocus)
          Expanded(
              // height: size.height - 400,
              child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 160,
                width: size.width,
                child: categories.when(data: (data) {
                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        'No category added yet',
                        style: normalText(color: Colors.black),
                      ),
                    );
                  } else {
                    return CarouselSlider.builder(
                        itemCount: data.length,
                        carouselController: buttonCarouselController,
                        itemBuilder: (context, index, index2) {
                          var category = data[index];
                          return CategoryItem(
                            categoryImage: category.image,
                            categoryName: category.name,
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          autoPlay: false,
                          onPageChanged: (index, reason) {
                            ref
                                .read(artisansFilterProvider.notifier)
                                .filterArtisansByCat(data[index].name);
                          },
                        ));
                  }
                }, error: (e, s) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: normalText(color: Colors.grey),
                    ),
                  );
                }, loading: () {
                  return const Center(
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator()),
                  );
                }),
              ),
              const SizedBox(height: 10),
              artisans.when(data: (data) {
                var artisanData = ref.watch(artisansFilterProvider).filter;
                if (artisanData.isEmpty) {
                  return Center(
                    child: Text(
                      'No Artisan found',
                      style: normalText(color: Colors.black),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: ListTile(
                          title: Text('Recommended Artisans',
                              style: normalText(
                                  color: secondaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          subtitle: ListView.builder(
                              itemCount: artisanData.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var artisan = data[index];
                                return ArtisanCard(
                                  artisan: artisan,
                                );
                              }),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 280,
                        child: LayoutBuilder(builder: (context, constraints) {
                          var ratedList = sortUsersByRating(data);
                          int length =
                              ratedList.length > 10 ? 10 : ratedList.length;
                          return ListTile(
                            title: Text('Top Rated Artisans',
                                style: normalText(
                                    color: secondaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            subtitle: ListView.builder(
                                itemCount: length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var artisan = ratedList[index];
                                  return ArtisanCard(
                                    artisan: artisan,
                                    isRated: true,
                                  );
                                }),
                          );
                        }),
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                }
              }, error: (e, s) {
                return Center(
                  child: Text(
                    'Something went wrong',
                    style: normalText(color: Colors.grey),
                  ),
                );
              }, loading: () {
                return const Center(
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator()),
                );
              })
            ]),
          )),
        location.when(data: (data) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                text: 'Find Artisan near you',
                onPressed: () {
                  sendToPage(context, ArtisansNearMe(data));
                }),
          );
        }, error: (e, s) {
          return const SizedBox();
        }, loading: () {
          return const SizedBox();
        })
      ]),
    );
  }
}
