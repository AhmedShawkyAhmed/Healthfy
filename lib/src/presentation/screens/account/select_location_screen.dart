import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/router/app_router_names.dart';
import 'package:healthify/src/presentation/widgets/custom_button.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final _searchController = TextEditingController();
  final _addressController = TextEditingController();
  late ValueNotifier<bool> _saveLocation;
  late ValueNotifier<Map<String, Marker>> _markers;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final _markerId = const MarkerId("MyLocation");
  final ValueNotifier<CameraPosition?> _myLocation = ValueNotifier(null);

  final ValueNotifier<LatLng?> _location = ValueNotifier(null);
  final ValueNotifier<Placemark?> _locationAddress = ValueNotifier(null);

  _getMyLocation({bool animate = false}) async {
    final position = await getCurrentPosition(force: true);
    late Marker marker;
    if (position != null) {
      final loc = position[0] as Position;
      final add = position[1] as Placemark;
      if (!animate) {
        _myLocation.value = CameraPosition(
          target: LatLng(loc.latitude, loc.longitude),
          zoom: 14.4746,
        );
      } else {
        final c = await _controller.future;
        c.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(loc.latitude, loc.longitude),
              zoom: 14.4746,
            ),
          ),
        );
      }
      _addressController.text = "${add.locality}, "
          "${add.subLocality}, "
          "${add.street}";
      marker = Marker(
        markerId: _markerId,
        position: LatLng(loc.latitude, loc.longitude),
      );
      _location.value = LatLng(loc.latitude, loc.longitude);
      _locationAddress.value = add;
    } else {
      _myLocation.value = const CameraPosition(
        target: LatLng(
          0.0,
          0.0,
        ),
        zoom: 14.4746,
      );
      marker = Marker(
        markerId: _markerId,
        position: const LatLng(
          0.0,
          0.0,
        ),
      );
    }
    final newMap = Map<String, Marker>.from(_markers.value);
    newMap["MyLocation"] = marker;
    _markers.value = newMap;
  }

  _onGoogleMapTap(LatLng position) async {
    _location.value = null;
    _locationAddress.value = null;
    final marker = Marker(
      markerId: _markerId,
      position: position,
    );
    final newMap = Map<String, Marker>.from(_markers.value);
    newMap["MyLocation"] = marker;
    _markers.value = newMap;
    final places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    _addressController.text = "${places[0].locality}, "
        "${places[0].subLocality}, "
        "${places[0].street}";
    _location.value = position;
    _locationAddress.value = places[0];
  }

  @override
  void initState() {
    super.initState();
    _saveLocation = ValueNotifier(false);
    _markers = ValueNotifier(<String, Marker>{});
    _getMyLocation();
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
      resizeToAvoidBottomInset: false,
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
          context.selectYourLocation,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveHeight(12),
          horizontal: context.responsiveWidth(16),
        ),
        child: Column(
          children: [
            SizedBox(
              height: context.responsiveHeight(56),
              child: TextFormField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w400,
                  color: AppColors.defaultBlack,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: AppColors.grey3,
                  ),
                  hintText: context.search,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.grey4,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: context.responsiveHeight(12),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: _myLocation,
                  builder: (context, myLocation, child) {
                    return myLocation == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ValueListenableBuilder(
                            valueListenable: _markers,
                            builder: (context, markers, child) {
                              return Stack(
                                children: [
                                  GoogleMap(
                                    key: const ValueKey(1),
                                    zoomControlsEnabled: false,
                                    initialCameraPosition: myLocation,
                                    markers: markers.values.toSet(),
                                    onTap: _onGoogleMapTap,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                  ),
                                  Positioned(
                                    bottom: context.responsiveHeight(24),
                                    left: context.responsiveWidth(16),
                                    child: Material(
                                      type: MaterialType.circle,
                                      color: AppColors.defaultWhite,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: InkWell(
                                        onTap: () => _getMyLocation(
                                          animate: true,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.my_location,
                                            color: AppColors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                  }),
            ),
            SizedBox(
              height: context.responsiveHeight(12),
            ),
            SizedBox(
              height: context.responsiveHeight(188),
              child: Column(
                children: [
                  SizedBox(
                    height: context.responsiveHeight(56),
                    child: TextFormField(
                      controller: _addressController,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey1,
                      ),
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        hintText: "الاسكندرية , محطة الرمل",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.grey4,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(48),
                    child: InkWell(
                      onTap: () {
                        final nVal = !_saveLocation.value;
                        _saveLocation.value = nVal;
                      },
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _saveLocation,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Checkbox(
                                activeColor: AppColors.green1,
                                value: value,
                                onChanged: (nVal) {
                                  _saveLocation.value = nVal ?? false;
                                },
                              );
                            },
                          ),
                          Text(
                            context.saveLocation,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Alexandria',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(12),
                  ),
                  ValueListenableBuilder(
                      valueListenable: _location,
                      builder: (context, location, child) {
                        return ValueListenableBuilder(
                            valueListenable: _locationAddress,
                            builder: (context, locationAddress, child) {
                              final enabled =
                                  location != null && locationAddress != null;
                              return CustomButton(
                                backgroundColor:
                                    enabled ? null : AppColors.grey4,
                                textColor: enabled ? null : AppColors.grey3,
                                text: context.confirmLocation,
                                onTap: () => Navigator.pushNamed(context,
                                    AppRouterNames.rDeliveryLocationDetails,
                                    arguments: [
                                      location!,
                                      locationAddress!,
                                    ]),
                              );
                            });
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
