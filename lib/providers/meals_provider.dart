// import riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

// we can add provider using the Provider class
// it requires a 1 positional parameters is a function that will receives a provider ref object automatically and this function will call by the riverpod package
final mealsProvider = Provider((ref) {
  // inside of this function we want to return a value that we want to provide to our widgets
  return dummyMeals; // for now we provide our dummy meals
});
