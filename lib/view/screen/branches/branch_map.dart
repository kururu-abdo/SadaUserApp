import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchMapPage extends StatefulWidget {
  final String? branch;
  const BranchMapPage({super.key, this.branch});

  @override
  State<BranchMapPage> createState() => _BranchMapPageState();
}

class _BranchMapPageState extends State<BranchMapPage> {
  static final LatLng _kMapCenter =
    LatLng(19.018255973653343, 72.84793849278007);
  GoogleMapController? _controller;
static final CameraPosition _kInitialPosition =
    CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

    onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller!.setMapStyle(value);
  }
  getMLocation(){

  }
  updateLoacationOnMov(){

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branch!),
      ),
      body: SafeArea(
        child: GoogleMap(
      initialCameraPosition: _kInitialPosition,
      onMapCreated: onMapCreated,
    ),
      ),
    );
  }
}