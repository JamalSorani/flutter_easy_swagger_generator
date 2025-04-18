import 'package:either_dart/either.dart';
import '../../infrastructure/models/category_get_by_id_model.dart';
import '../../infrastructure/models/category_add_model.dart';
import '../../infrastructure/models/category_modify_model.dart';
import '../../infrastructure/models/category_get_all_categories_by_parent_category_id_model.dart';
import '../../infrastructure/models/category_search_at_categories_model.dart';
import '../../infrastructure/models/category_get_categories_by_search_model.dart';
import '../../infrastructure/models/category_get_all_names_model.dart';
import '../../infrastructure/models/category_delete_model.dart';
import '../entities/category_get_by_id_param.dart';
import '../entities/category_add_param.dart';
import '../entities/category_modify_param.dart';
import '../entities/category_get_all_categories_by_parent_category_id_param.dart';
import '../entities/category_search_at_categories_param.dart';
import '../entities/category_get_categories_by_search_param.dart';
import '../entities/category_get_all_names_param.dart';
import '../entities/category_delete_param.dart';

abstract class CategoryRepository {
  Future<Either<String, CategoryGetByIdModel>> categoryGetById(
      {required CategoryGetByIdParam categoryGetByIdParam});

  Future<Either<String, CategoryAddModel>> categoryAdd(
      {required CategoryAddParam categoryAddParam});

  Future<Either<String, CategoryModifyModel>> categoryModify(
      {required CategoryModifyParam categoryModifyParam});

  Future<Either<String, CategoryGetAllCategoriesByParentCategoryIdModel>>
      categoryGetAllCategoriesByParentCategoryId(
          {required CategoryGetAllCategoriesByParentCategoryIdParam
              categoryGetAllCategoriesByParentCategoryIdParam});

  Future<Either<String, CategorySearchAtCategoriesModel>>
      categorySearchAtCategories(
          {required CategorySearchAtCategoriesParam
              categorySearchAtCategoriesParam});

  Future<Either<String, CategoryGetCategoriesBySearchModel>>
      categoryGetCategoriesBySearch(
          {required CategoryGetCategoriesBySearchParam
              categoryGetCategoriesBySearchParam});

  Future<Either<String, CategoryGetAllNamesModel>> categoryGetAllNames(
      {required CategoryGetAllNamesParam categoryGetAllNamesParam});

  Future<Either<String, CategoryDeleteModel>> categoryDelete(
      {required CategoryDeleteParam categoryDeleteParam});
}
