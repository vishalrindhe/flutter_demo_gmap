import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final marker1 = Marker(
      markerId: MarkerId('marker1'),
    infoWindow: InfoWindow(title: 'Map Pinned Location'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.42796133580664, -122.085749655962),
  );
  static final marker2 = Marker(
    markerId: MarkerId('marker2'),
    infoWindow: InfoWindow(title: 'Map Pinned Location'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    position: LatLng(37.43296265331129, -122.08832357078792),
  );

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Stack(
        children: [
          GoogleMap(

            markers: {marker1, marker2},
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            compassEnabled: true,
            mapToolbarEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton(
      onPressed: _showSecondScreen,
      child: Icon(Icons.add),
    ),


      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      //   Align: Alignment.bottomCenter,
      // ),
    );
  }
  void _showSecondScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormPage()));
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

class FormPage extends StatelessWidget {
  // const FormPage({Key? key}) : super(key: key);

  final name = TextField(
    decoration: InputDecoration(
      labelText: "name",
      border: OutlineInputBorder(),
    ),
  );

  final Lat = TextField(
    decoration: InputDecoration(
        labelText: "Lat",
        border: OutlineInputBorder(),
    ),
  );

  final Lng = TextField(
    decoration: InputDecoration(
        labelText: "Lng",
      border: OutlineInputBorder(),
    ),
  );


  final submit = RaisedButton(onPressed: (){
  },
  child: Text('Submit'),);

  // final submit = RaisedButton(onPressed: (){
  //         // Navigator.pop();
  //         Icons.label : 'abcd',
  //             // context,
  //             // MaterialPageRoute(
  //             //     builder: (context) => MapSample()));
  //   },
  //       // child: Text('Go back to page 1')
  //
  // );

  // final LatLng = DropdownButton(
    // decoration: InputDecoration(
    //     labelText: "Lat"
    // ),
    // int elavation = 8,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add LatLng')),
      body: Container(
        margin: EdgeInsets.all(10),

  //       child: RaisedButton(onPressed: (){
  //         Navigator.pop(context);
  //             // context,
  //             // MaterialPageRoute(
  //             //     builder: (context) => MapSample()));
  //   },
  //       child: Text('Go back to page 1')
  //
  // ),
        child: Column(
          children: <Widget>[
            Divider(),
            name,
            Divider(),
            Lat,
            Divider(),
            Lng,
            Divider(),
            submit,
          ],
        ),

    ),
    );

  }
}
