import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubit/weather_cubit/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is LoadingWeatherState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessWeatherState) {
          weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                weatherData!.getThemeColor(),
                weatherData!.getThemeColor()[300]!,
                weatherData!.getThemeColor()[100]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 3,
                ),
                Text(
                  BlocProvider.of<WeatherCubit>(context).cityName!,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(weatherData!.getImage()),
                    Text(
                      weatherData!.temp.toInt().toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                        Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  weatherData!.weatherStateName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          );
        } else if (state is FailWeatherState) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'something went wrong 😔 start',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                'searching now 🔍',
                style: TextStyle(
                  fontSize: 30,
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'please 😔 start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'searching now 🔍',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
