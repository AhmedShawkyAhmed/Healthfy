import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthify/src/business_logic/location_cubit/location_cubit.dart';
import 'package:healthify/src/constants/colors.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/extensions.dart';
import 'package:healthify/src/data/request/create_location_request.dart';
import 'package:healthify/src/data/shared_models/location_address_model.dart';
import 'package:healthify/src/localization/app_strings_extension.dart';
import 'package:healthify/src/presentation/views/common_views/custom_form_field_view.dart';
import 'package:healthify/src/presentation/widgets/custom_button.dart';

class DeliveryLocationDetailsScreen extends StatefulWidget {
  const DeliveryLocationDetailsScreen({
    super.key,
    required this.location,
    required this.locationAddress,
  });

  final LatLng location;
  final Placemark locationAddress;

  @override
  State<DeliveryLocationDetailsScreen> createState() =>
      _DeliveryLocationDetailsScreenState();
}

class _DeliveryLocationDetailsScreenState
    extends State<DeliveryLocationDetailsScreen> {
  final _titleController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _streetController = TextEditingController();
  final _buildingController = TextEditingController();
  final _floorController = TextEditingController();
  final _flatController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  bool _done = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cityController.text = widget.locationAddress.administrativeArea ?? "";
    _areaController.text = widget.locationAddress.locality ?? "";
    _streetController.text = widget.locationAddress.thoroughfare ?? "";
    _buildingController.text = widget.locationAddress.subThoroughfare ?? "";
    _floorController.text = "";
    _flatController.text = "";
    _additionalInfoController.text = "";
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
          context.deliveryLocationDetails,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.defaultWhite,
            fontWeight: FontWeight.w500,
            fontFamily: "Alexandria",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveWidth(16),
                  vertical: context.responsiveHeight(16),
                ),
                // height: context.responsiveHeight(618),
                child: Column(
                  children: [
                    CustomFormFieldView(
                      margin: EdgeInsets.only(
                        bottom: context.responsiveHeight(8),
                      ),
                      title: context.locationTitle,
                      controller: _titleController,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val?.trim().isEmpty == true) {
                          "العنوان مطلوب".toToastWarning();
                          _done = false;
                          return null;
                        }
                        _done = true;
                        return null;
                      },
                    ),
                    CustomFormFieldView(
                      margin: EdgeInsets.only(
                        bottom: context.responsiveHeight(8),
                      ),
                      title: context.city,
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val?.trim().isEmpty == true) {
                          "المحافظة مطلوبة".toToastWarning();
                          _done = false;
                          return null;
                        } else if (_done) {
                          _done = true;
                        }
                        return null;
                      },
                    ),
                    CustomFormFieldView(
                      margin: EdgeInsets.only(
                        bottom: context.responsiveHeight(8),
                      ),
                      title: context.area,
                      controller: _areaController,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val?.trim().isEmpty == true) {
                          "المنطقة مطلوبة".toToastWarning();
                          _done = false;
                          return null;
                        } else if (_done) {
                          _done = true;
                        }
                        return null;
                      },
                    ),
                    CustomFormFieldView(
                      margin: EdgeInsets.only(
                        bottom: context.responsiveHeight(8),
                      ),
                      title: context.streetName,
                      controller: _streetController,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val?.trim().isEmpty == true) {
                          "اسم الشارع مطلوب".toToastWarning();
                          _done = false;
                          return null;
                        } else if (_done) {
                          _done = true;
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: context.responsiveHeight(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomFormFieldView(
                              title: context.buildingNumber,
                              controller: _buildingController,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val?.trim().isEmpty == true) {
                                  "رقم العمارة مطلوب".toToastWarning();
                                  _done = false;
                                  return null;
                                } else if (_done) {
                                  _done = true;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: context.responsiveWidth(10),
                          ),
                          Expanded(
                            child: CustomFormFieldView(
                              title: context.floorNumber,
                              controller: _floorController,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val?.trim().isEmpty == true) {
                                  "رقم الدور مطلوب".toToastWarning();
                                  _done = false;
                                  return null;
                                } else if (_done) {
                                  _done = true;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: context.responsiveWidth(10),
                          ),
                          Expanded(
                            child: CustomFormFieldView(
                              title: context.flatNumber,
                              controller: _flatController,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val?.trim().isEmpty == true) {
                                  "رقم الشقة مطلوبة".toToastWarning();
                                  _done = false;
                                  return null;
                                } else if (_done) {
                                  _done = true;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomFormFieldView(
                      margin: EdgeInsets.only(
                        bottom: context.responsiveHeight(8),
                      ),
                      title: context.additionalInfo,
                      controller: _additionalInfoController,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: context.responsiveHeight(88),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.responsiveHeight(7),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveWidth(16),
                  vertical: context.responsiveHeight(20),
                ),
                height: context.responsiveHeight(100),
                child: BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state) {
                    if (state is LocationCreateLocationSuccessState) {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    }
                  },
                  builder: (context, state) {
                    return state is LocationCreateLocationLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            text: context.save,
                            onTap: () {
                              if (_formKey.currentState?.validate() == true &&
                                  _done == true) {
                                final request = CreateLocationRequest(
                                  lat: widget.location.latitude,
                                  lon: widget.location.longitude,
                                  address: "${_cityController.text}, "
                                      "${_areaController.text}, "
                                      "${_buildingController.text} ${_streetController.text}",
                                  type: _titleController.text,
                                  addressModel: LocationAddressModel(
                                    city: _cityController.text,
                                    region: _areaController.text,
                                    flat: _flatController.text,
                                    building: _buildingController.text,
                                    floor: _floorController.text,
                                    addition:
                                        _additionalInfoController.text.isEmpty
                                            ? null
                                            : _additionalInfoController.text,
                                  ),
                                );
                                LocationCubit.get(context)
                                    .createLocation(request: request);
                              }
                            },
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
