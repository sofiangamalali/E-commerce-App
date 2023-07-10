import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elhaga/Data/Models/offer_model.dart';
import 'package:elhaga/Data/Models/product_model.dart';
import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../business_logic/bloc/offer/offer_bloc.dart';
import '../../business_logic/bloc/product/product_bloc.dart';
import '../screens/item_screen.dart';
import '../widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Widget _buildProductsSection() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.teal[300],
            ));
          }
          if (state is ProductLoaded) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.2),
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.products[index],
                  isFavScreen: false,
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.teal[300],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTitleSection(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildContainerforOfferImage(Offer offer, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: InkWell(
          onTap: offer.isOffer
              ? () {
                  Navigator.of(context).push(PageTransition(
                      child: ItemScreen(item: offer),
                      type: PageTransitionType.bottomToTop));
                }
              : null,
          child: CachedNetworkImage(
            imageUrl: offer.image,
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => Container(),
            width: 1000,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider(List<Offer> offers, BuildContext context) {
    final List<Widget> imageSliders = offers
        .map((offer) => _buildContainerforOfferImage(offer, context))
        .toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.25,
        viewportFraction: .95,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      items: imageSliders,
    );
  }

  Widget _buildRecommndedContainer(Product product, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(PageTransition(
                child: ItemScreen(item: product),
                type: PageTransitionType.bottomToTop));
          },
          child: Container(
            width: 200,
            color: Colors.teal[200],
            child: Center(
                child: CachedNetworkImage(
              imageUrl: product.image,
              placeholder: (context, url) => Container(),
              height: 100,
              width: 100,
              errorWidget: (context, url, error) => Container(),
              fit: BoxFit.fill,
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommndedSection(List products, BuildContext context) {
    final List<Widget> recommendedList = [];
    for (var product in products) {
      if (product.isRecommended) {
        recommendedList.add(_buildRecommndedContainer(product, context));
      }
    }
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: recommendedList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        backgroundColor: Colors.white,
        isHomeScreen: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Offers
                  BlocBuilder<OfferBloc, OfferState>(
                    builder: (context, state) {
                      if (state is OfferLoaded) {
                        return _buildCarouselSlider(state.offers, context);
                      } else if (state is OfferLoading) {
                        return CircularProgressIndicator(
                          color: Colors.teal[300],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal[300],
                          ),
                        );
                      }
                    },
                  ),
                  //Recommnded
                  _buildTitleSection('توصيات الحاجة'),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoaded) {
                        return _buildRecommndedSection(state.products, context);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal[300],
                          ),
                        );
                      }
                    },
                  ),
                  _buildTitleSection('المنتجات'),
                  //Products
                  _buildProductsSection(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
