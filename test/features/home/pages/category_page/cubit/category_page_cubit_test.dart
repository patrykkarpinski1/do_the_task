import 'package:bloc_test/bloc_test.dart';
import 'package:do_the_task/app/core/enums.dart';
import 'package:do_the_task/features/home/pages/category_page/cubit/category_page_cubit.dart';
import 'package:do_the_task/models/category_model.dart';
import 'package:do_the_task/repositories/item_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late CategoryPageCubit sut;
  late MockItemsRepository itemsRepository;

  setUp(() {
    itemsRepository = MockItemsRepository();
    sut = CategoryPageCubit(itemsRepository: itemsRepository);
  });
  group('start', () {
    final mockCategories = [
      CategoryModel('title1', '1', 'images1'),
      CategoryModel('title2', '2', 'images2'),
      CategoryModel('title3', '3', 'images3'),
    ];
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getCategories())
            .thenAnswer((_) async => mockCategories);
      });
      blocTest<CategoryPageCubit, CategoryPageState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          CategoryPageState(
            status: Status.loading,
            categories: [],
          ),
          CategoryPageState(status: Status.success, categories: mockCategories)
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getCategories())
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<CategoryPageCubit, CategoryPageState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          CategoryPageState(
            status: Status.loading,
            categories: [],
          ),
          CategoryPageState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('getCategoryWithID', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getCategory(id: '1')).thenAnswer(
          (_) async => CategoryModel('title1', '1', 'images1'),
        );
      });
      blocTest<CategoryPageCubit, CategoryPageState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.getCategoryWithID('1'),
        expect: () => [
          CategoryPageState(
            status: Status.loading,
            selectCategories: null,
          ),
          CategoryPageState(
            status: Status.success,
            selectCategories: CategoryModel('title1', '1', 'images1'),
          )
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getCategory(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<CategoryPageCubit, CategoryPageState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.getCategoryWithID('1'),
        expect: () => [
          CategoryPageState(
            status: Status.loading,
            selectCategories: null,
          ),
          CategoryPageState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
}
