// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:elhaga/business_logic/bloc/location/location_bloc.dart';
import 'package:elhaga/presentation/widgets/location/animated_marker.dart';
import 'package:elhaga/presentation/widgets/custom_button.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import '../../../constants.dart';

class LoactionBottomSheet extends StatefulWidget {
  final LatLng currentLocation;
  final LatLng pickedUpLocation;
  const LoactionBottomSheet(
      {required this.currentLocation,
      required this.pickedUpLocation,
      super.key});

  @override
  State<LoactionBottomSheet> createState() =>
      _LoactionBottomSheetState(currentLocation, pickedUpLocation);
}

class _LoactionBottomSheetState extends State<LoactionBottomSheet> {
  final LatLng currentLocation;
  final LatLng pickedUpLocation;

  _LoactionBottomSheetState(this.currentLocation, this.pickedUpLocation);

  TextEditingController addressController = TextEditingController();
  final MapController _mapController = MapController();
  List<Marker> markers = [];
  bool isGeoCodingComplete = true;

  Widget _buildCloseButton(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
        child: const Icon(
          Icons.close_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSelectLocationButton(
      BuildContext context, bool isGeoCodingCompelte) {
    return CustomButton(
      disabledWidget: const CircularProgressIndicator(color: Colors.grey),
      width: 40,
      isEnable: isGeoCodingCompelte,
      onPressed: () {
        context.read<LocationBloc>().add(PickUpLocation(
            adress: addressController.text, location: markers[1].point));
        Navigator.of(context).pop();
      },
      title: const Text('أضغط للتأكيد'),
    );
  }

  Widget _buildGoToMyCurrentLocationButton() {
    return InkWell(
      onTap: () {
        _goToCurrentLocation();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: const Icon(
          Icons.my_location_rounded,
          color: Colors.teal,
          size: 25,
        ),
      ),
    );
  }

  Future<String> getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = placemark.street!;

        return address
            .replaceAll("مصر", "")
            .replaceAll("محافظة القاهرة", "")
            .replaceAll("،", "")
            .replaceAll(RegExp(r'\d{5,}'), "");
      } else {
        return 'العنوان غير موجود';
      }
    } catch (e) {
      return 'حدث خطأ ما';
    }
  }

  Widget _buildSearchTextFeild() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        enabled: false,
        controller: addressController,
        style: const TextStyle(
          fontSize: 18,
          height: 1.3,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, size: 30, color: Colors.teal),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[400]!)),
        ),
      ),
    );
  }

  void _goToCurrentLocation() {
    _mapController.move(currentLocation, 18);
    _markTheMap(currentLocation);
    _addAdressToTextField(currentLocation);
  }

  void _markTheMap(LatLng latlang) async {
    setState(() {
      markers[1] = Marker(
        width: 50.0,
        height: 50.0,
        point: latlang,
        builder: (context) => Image.asset('assets/icons/locaiton_pin.png'),
      );
    });
  }

  void _addAdressToTextField(LatLng latlang) async {
    setState(() {
      isGeoCodingComplete = false;
    });
    String address = await getAddressFromLatLng(latlang);
    setState(() {
      isGeoCodingComplete = true;
    });
    if (mounted) {
      setState(() {
        addressController.text = address;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    markers = [
      //Current location Marker
      Marker(
        width: 50.0,
        height: 50.0,
        point: currentLocation,
        builder: (context) => const AnimatedMarker(),
      ),
      //Pick up location Marker
      Marker(
        width: 50.0,
        height: 50.0,
        point: pickedUpLocation,
        builder: (context) => Image.asset('assets/icons/locaiton_pin.png'),
      ),
    ];

    _addAdressToTextField(pickedUpLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildCloseButton(context),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: _buildSearchTextFeild(),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  minZoom: 5,
                  maxZoom: 18,
                  zoom: 18,
                  onTap: (tapPosition, latlang) async {
                    _markTheMap(latlang);
                    _addAdressToTextField(latlang);
                  },
                  interactiveFlags: InteractiveFlag.pinchZoom |
                      InteractiveFlag.drag, // rotated : false
                  center: pickedUpLocation,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: urlTemplate,
                    additionalOptions: {
                      'mapStyleId': mapBoxStyleId,
                      'accessToken': mapAccessToken,
                    },
                  ),
                  MarkerLayerOptions(
                    markers: markers,
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: _buildSelectLocationButton(context, isGeoCodingComplete),
              ),
              Positioned(
                bottom: 80,
                left: 20,
                child: _buildGoToMyCurrentLocationButton(),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
