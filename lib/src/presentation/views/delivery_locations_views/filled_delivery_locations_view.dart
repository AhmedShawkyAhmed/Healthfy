import 'package:flutter/material.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/data/shared_models/location_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/views/delivery_locations_views/delete_delivery_location_dialog_view.dart';
import 'package:healthify/src/presentation/views/delivery_locations_views/delivery_location_item_view.dart';
import 'package:healthify/src/presentation/widgets/custom_button.dart';

class FilledDeliveryLocationsView extends StatelessWidget {
  const FilledDeliveryLocationsView({
    super.key,
    required this.locations,
  });

  final List<LocationModel> locations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.responsiveHeight(24),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => DeliveryLocationItemView(
              title: locations[index].type ?? "LocationType",
              description: locations[index].address ?? "Unknown address",
              isCurrentLocation: true,
              delete: () {
                showDialog(
                  context: context,
                  builder: (_) => DeleteDeliveryLocationDialog(
                    remove: () {
                      LocationCubit.get(context).deleteLocation(
                        id: locations[index].id!,
                      );
                    },
                  ),
                );
              },
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: context.responsiveHeight(16),
            ),
            itemCount: locations.length,
          ),
        ),
        CustomButton(
          text: context.addNewLocation,
          onTap: () => Navigator.pushNamed(
            context,
            AppRouterNames.rLocationSelect,
          ),
        ),
        SizedBox(
          height: context.responsiveHeight(24),
        ),
      ],
    );
  }
}
