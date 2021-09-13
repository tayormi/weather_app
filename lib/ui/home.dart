import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.settings),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Showers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.network(
                  'https://www.metaweather.com/static/img/weather/sn.svg',
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '20',
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Humidity: 67%',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Pressure: 1009 hPa',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Wind: 23 km/h',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return const WeatherItem();
                  },
                  itemCount: 5,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
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

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: 120,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5)),

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'FRI',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.network(
                'https://www.metaweather.com/static/img/weather/sn.svg',
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '14/21',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
