import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/auth_cubit/auth_cubit.dart';
import 'package:healthify/src/business_logic/points_cubit/points_cubit.dart';
import 'package:healthify/src/constants/const_variables.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/views/home_views/account_views/account_item_view.dart';
import 'package:healthify/src/presentation/views/home_views/account_views/account_title_view.dart';
import 'package:healthify/src/presentation/views/home_views/account_views/account_user_view.dart';
import '../../../constants/colors.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.defaultWhite,
        centerTitle: true,
        title: Text(
          context.account,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultBlack,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.background2,
        padding: const EdgeInsets.all(16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final user = AuthCubit.get(context).user;
                String? image;
                if (user?.image != null && user?.image?.isNotEmpty == true) {
                  image = "${EndPoints.imageBaseUrlGlobal}${user?.image}";
                }
                return AccountUserView(
                  image: image,
                  username: user?.name ?? "username",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouterNames.rAccountSettings,
                    );
                  },
                );
              },
            ),
            AccountTitleView(
              title: context.myAccount,
            ),
            BlocBuilder<PointsCubit, PointsState>(
              builder: (context, state) {
                final points = PointsCubit.get(context).pointsModel;
                return AccountItemView(
                  isPoints: true,
                  icon: Icons.military_tech,
                  title: context.rewards,
                  points: context
                      .pointNumber(num.tryParse("${points?.points}") ?? 0.0),
                  margin: const EdgeInsets.only(bottom: 4),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouterNames.rPoints,
                  ),
                );
              },
            ),
            AccountItemView(
              icon: Icons.credit_card,
              title: context.insuranceCard,
              margin: const EdgeInsets.only(bottom: 4),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouterNames.rInsuranceCard,
                );
              },
            ),
            AccountItemView(
              icon: Icons.book,
              title: context.myReservation,
              margin: const EdgeInsets.only(bottom: 4),
              onTap: () => Navigator.pushNamed(
                context,
                AppRouterNames.rMyReservation,
              ),
            ),
            AccountItemView(
              icon: Icons.location_on,
              title: context.myAddress,
              margin: const EdgeInsets.only(bottom: 4),
              onTap: () => Navigator.pushNamed(
                context,
                AppRouterNames.rDeliveryLocations,
              ),
            ),
            AccountItemView(
              icon: Icons.favorite,
              title: context.favourite,
              onTap: () => Navigator.pushNamed(
                context,
                AppRouterNames.rFavourites,
              ),
            ),
            AccountTitleView(
              title: context.helpTitle,
            ),
            AccountItemView(
              icon: Icons.support_agent,
              title: context.help,
              margin: const EdgeInsets.only(bottom: 4),
              onTap: reveChat.gotoReveChat,
            ),
            AccountItemView(
              icon: Icons.help,
              title: context.aboutApp,
              margin: const EdgeInsets.only(bottom: 4),
              onTap: () => Navigator.pushNamed(
                context,
                AppRouterNames.rAbout,
              ),
            ),
            AccountItemView(
              icon: Icons.security,
              title: context.terms,
              onTap: () => Navigator.pushNamed(
                context,
                AppRouterNames.rTerms,
              ),
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLogoutSuccessState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouterNames.rLogin,
                    (route) => false,
                  );
                } else if (state is AuthLogoutFailureState) {
                  Navigator.pop(context);
                }
              },
              child: AccountItemView(
                icon: Icons.logout,
                title: context.logout,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => WillPopScope(
                      onWillPop: () => Future.value(false),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                  AuthCubit.get(context).logout();
                },
                isArrow: false,
                titleColor: AppColors.defaultRed,
                iconBackgroundColor: AppColors.defaultWhite,
                iconColor: AppColors.defaultRed,
                backgroundColor: AppColors.redTransparent,
                margin: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
