import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/bloc/favorite/favorite_bloc.dart';
import '../widgets/product_card.dart';

class FavoriteScreen extends StatelessWidget {
  static const String url = 'FavoriteScreen';
  const FavoriteScreen({super.key});
  Widget _buildEmptyScreen() {
    return Center(
      child: Text(
        'لا توجد عناصر مفضلة',
        style: TextStyle(
          fontSize: 24,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "المفضلة",
        backgroundColor: Colors.white,
        withBackButton: true,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoaded) {
            if (state.favorite.items.isEmpty) {
              return _buildEmptyScreen();
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.favorite.items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.2),
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: state.favorite.items[index],
                          isFavScreen: true,
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          }
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          } else {
            return const Center(
              child: Text('حدث خطأ ما'),
            );
          }
        },
      ),
    );
  }
}
