import 'package:elhaga/business_logic/bloc/favorite/favorite_bloc.dart';
import 'package:elhaga/business_logic/bloc/settings/settings_bloc.dart';
import 'package:elhaga/helper.dart';
import 'package:elhaga/presentation/screens/favorite_screen.dart';
import 'package:elhaga/presentation/screens/last_orders_screen.dart';
import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:elhaga/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          const CustomAppBar(title: 'المزيد', backgroundColor: Colors.white),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            CustomListTile(
              title: 'الطلبات السابقة',
              leading: Icons.access_time_rounded,
              showArrow: true,
              onTap: () {
                Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: const LastOredersScreen()));
              },
            ),
            CustomListTile(
              title: 'المفضلة',
              leading: Icons.favorite_outline_rounded,
              showArrow: true,
              onTap: () {
                context.read<FavoriteBloc>().add(FavoriteStarted());
                Navigator.of(context).push(PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: const FavoriteScreen()));
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return CustomListTile(
                    title: 'تحدث معنا',
                    leading: Icons.chat_outlined,
                    showArrow: true,
                    onTap: state is SettingsLoaded
                        ? () async {
                            openWhatsapp(
                                context: context,
                                number: state.settings.contactPhone);
                          }
                        : () {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
