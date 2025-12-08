import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:clean_architutre_learn/core/service/network/dio/image_genrate_provider.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/entities/image_entity.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/repo/image_genration_repo.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/usecase/get_ai_images.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/usecase/image_to_image_uscase.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/usecase/store_ai_images.dart';
import 'package:clean_architutre_learn/features/banana/data/data_source/imagin_datasource.dart';
import 'package:clean_architutre_learn/features/banana/data/repo/image_genration_repo_impl.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/supabase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imaginDatasourceProvider = Provider((ref) {
  final dio = ref.read(dioClientImagineProvider);
  return ImaginDatasource(dio);
});

final imaginRepoImplProvider = Provider<ImageGenrationRepo>((ref) {
  final datasource = ref.read(imaginDatasourceProvider);
  return ImageGenrationRepoImpl(datasource);
});

final gerateImagefrmImageprovider = Provider<ImageToImageUscase>((ref) {
  final repo = ref.read(imaginRepoImplProvider);
  return ImageToImageUscase(repo);
});
// final genrateImagefrmTextProvider = Provider<ImageToTextUscase>((ref) {
//   final repo = ref.read(imaginRepoImplProvider);
//   return ImageToTextUscase(repo);
// });
// final imageLoadingProvider = StateProvider((ref) => false);

class ImaginNotifier extends StateNotifier<AsyncValue<Uint8List?>> {
  ImaginNotifier(
    this._imaggenration,
    this.ref, //this._imageGenrationFromText
  ) : super(const AsyncData(null));
  final ImageToImageUscase _imaggenration;
  final Ref ref;
  // final ImageToTextUscase _imageGenrationFromText;
  Future<void> getImageFromImage(String prompt, String imagepath) async {
    state = const AsyncValue.loading();
    try {
      final image = await _imaggenration(prompt, imagepath);
      image.fold((failure) => debugPrint('Error: ${failure.message}'), (image) {
        state = AsyncData(image);
      });
    } catch (e, st) {
      log('Error on $e');
      state = AsyncValue.error(e, st);
    }
  }

  // Future<void> getImageFromText(String prompt) async {
  //   try {
  //     final image = await _imageGenrationFromText(prompt: prompt);
  //     image.fold((faliure) => debugPrint(faliure.message.toString()), (image) {
  //       state = AsyncData(image);
  //     });
  //   } catch (e) {
  //     log('Error on $e');
  //   }
  // }

  void clear() => state = AsyncData(Uint8List(0));
}

final imaginNotifierProvider =
    StateNotifierProvider<ImaginNotifier, AsyncValue<Uint8List?>>((ref) {
      final imaggenration = ref.read(gerateImagefrmImageprovider);
      // final imageGenrationFromText = ref.read(genrateImagefrmTextProvider);
      return ImaginNotifier(
        imaggenration,
        ref, // imageGenrationFromText
      );
    });

final getImagesSupaBaseProvider = Provider(
  (ref) => GetStoredAiImages(ref.read(chatSupabaseRepositoryProvider)),
);
final addImageSupaBaseProvider = Provider(
  (ref) => StoreAiImages(ref.read(chatSupabaseRepositoryProvider)),
);

class SupabaseImagesNotifier
    extends StateNotifier<AsyncValue<List<UserImageEntity>>> {
  SupabaseImagesNotifier(this._getImage, this._addImages, this.ref)
    : super(const AsyncData([]));
  late final GetStoredAiImages _getImage;
  late final StoreAiImages _addImages;
  final Ref ref;

  // Future<List<UserImageEntity>> build() async {
  //   _getImage = ref.read(getImagesSupaBaseProvider);
  //   _addImages = ref.read(addImageSupaBaseProvider);
  //   return await fetchImages();
  // // }
  // Future<List<UserImageEntity>> fetchImages() async {
  //   state = const AsyncValue.loading();

  //   try {
  //     final result = await _getImage();
  //     final images= result.fold((l) => [], (r) {
  //       return r;
  //     });
  //       state = AsyncData(images);

  //     return images;
  //   } catch (e, st) {
  //     log('Error on $e');
  //     state = AsyncValue.error(e, st);
  //     return [];
  //   }
  // }
  Future<List<UserImageEntity>> fetchImages() async {
    state = const AsyncValue.loading();

    try {
      final result =
          await _getImage(); // Future<Either<Failure, List<UserImageEntity>>>
      final images = result.fold<List<UserImageEntity>>(
        (l) => [],
        (r) => r, // r is already List<UserImageEntity>
      );
      state = AsyncData(images);
      return images;
    } catch (e, st) {
      log('Error on fetchImages: $e');
      state = AsyncValue.error(e, st);
      return [];
    }
  }

  Future<void> addImage(Uint8List bytes) async {
    state = const AsyncValue.loading();
    try {
      //   final previous = state.value ?? [];
      //   state = AsyncValue.data([...previous]);
      final result = await AsyncValue.guard(() async {
        await _addImages(bytes);
        return await fetchImages();
      });
      state = result;
    } catch (e, st) {
      debugPrint(e.toString());
      state = AsyncValue.error(e, st);
    }
  }
}

final supabaseImagesNotifierProvider =
    StateNotifierProvider<
      SupabaseImagesNotifier,
      AsyncValue<List<UserImageEntity>>
    >((ref) {
      final getImage = ref.read(getImagesSupaBaseProvider);
      final addImages = ref.read(addImageSupaBaseProvider);
      return SupabaseImagesNotifier(getImage, addImages, ref);
    });
