import 'package:clean_architutre_learn/core/service/network/dio/image_genrate_provider.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/repo/image_genration_repo.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/usecase/image_to_image_uscase.dart';
import 'package:clean_architutre_learn/features/banana/bussiness/usecase/image_to_text_uscase.dart';
import 'package:clean_architutre_learn/features/banana/data/data_source/imagin_datasource.dart';
import 'package:clean_architutre_learn/features/banana/data/repo/image_genration_repo_impl.dart';
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
final genrateImagefrmTextProvider = Provider<ImageToTextUscase>((ref) {
  final repo = ref.read(imaginRepoImplProvider);
  return ImageToTextUscase(repo);
});

