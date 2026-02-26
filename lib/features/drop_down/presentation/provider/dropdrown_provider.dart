// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DropdownSelection<T> extends StateNotifier<T?> {
//   DropdownSelection() : super(null);

//   void select(T value) => state = value;
//   void clear() => state = null;
// }

// // Generic provider factory
// AutoDisposeStateNotifierProviderFamily<DropdownSelection<T>, T?, String>
//     dropdownSelectionProvider<T>() {
//   return StateNotifierProvider.family
//       .autoDispose<DropdownSelection<T>, T?, String>(
//     (ref, key) => DropdownSelection<T>(),
//   );
// }

// class DropdownSelection<T> extends StateNotifier<T?> {
//   DropdownSelection() : super(null);

//   void select(T value) => state = value;
//   void clear() => state = null;
// }

// /// Generic provider family for dropdown selections
// StateNotifierProviderFamily<DropdownSelection<T>, T?, String>
//     dropdownSelectionProvider<T>() {
//   return StateNotifierProvider.family<DropdownSelection<T>, T?, String>(
//     (ref, key) => DropdownSelection<T>(),
//   );
// }

import 'package:flutter_riverpod/legacy.dart';

/// Fake data repository for demo (replace with Firestore fetch later)
final dropdownDataProvider = StateProvider<List<String>>((ref) {
  return ['Apple', 'Banana', 'Mango'];
});

/// Selected value
final selectedDropdownValueProvider = StateProvider<String>((ref) => '');