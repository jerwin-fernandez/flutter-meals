import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

// so we need to move our Filter type here so that it will be manage here, this was from the /screens/filters.dart
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterMealsNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterMealsNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  // so we create a new method that accepts a mal of Filter and value
  void setFilters(Map<Filter, bool> chosenFilters) {
    // and simply reassign the state
    state = chosenFilters;
  }
}

// this contains all the filters, we should have renamed this filtersProvider
final filterMealsProvider =
    StateNotifierProvider<FilterMealsNotifier, Map<Filter, bool>>(
  (ref) => FilterMealsNotifier(),
);

// add a new provider that will hold the filtered meal list
// it is a simple Provider and not a StateNotifierProvider because we will not create a state notifier class
final filteredMealsProvider = Provider((ref) {
  // we watch the mealsProvider so we get an access to the state
  // this ensure that every time the meals is updated then this function or code here will be re-executed so that we can return an updated filtered meals so that any widgets that is listening to the filteredMealsProvider will also be re-executed or rebuild
  final meals = ref.watch(mealsProvider);

  // we do the same with activeFilters+
  final activeFilters = ref.watch(filterMealsProvider);

  // we are doing this filtering logic here and return the filtered meals
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
