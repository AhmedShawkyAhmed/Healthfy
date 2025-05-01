import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/views/delivery_locations_views/empty_delivery_locations_view.dart';
import 'package:healthify/src/presentation/views/delivery_locations_views/filled_delivery_locations_view.dart';

class DeliveryLocationsScreen extends StatefulWidget {
  const DeliveryLocationsScreen({super.key});

  @override
  State<DeliveryLocationsScreen> createState() =>
      _DeliveryLocationsScreenState();
}

class _DeliveryLocationsScreenState extends State<DeliveryLocationsScreen> {
  @override
  void initState() {
    super.initState();
    if (LocationCubit.get(context).locations.isEmpty) {
      LocationCubit.get(context).getAllLocations();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.defaultWhite,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          context.deliveryLocations,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveWidth(16),
        ),
        color: AppColors.background2,
        width: double.infinity,
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            final locations = LocationCubit.get(context).locations;
            if (state is LocationGetAllLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (locations.isEmpty) {
              return const EmptyDeliveryLocationsView();
            }
            return FilledDeliveryLocationsView(
              locations: locations,
            );
          },
        ),
      ),
    );
  }
}
