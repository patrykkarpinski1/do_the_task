import 'package:do_the_task/features/home/pages/add_tasks/cubit/add_task_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:do_the_task/app/core/enums.dart';
import 'package:do_the_task/models/category_model.dart';
import 'package:do_the_task/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late AddTaskCubit sut;
  late MockItemsRepository itemsRepository;
  final mockCategories = [
    CategoryModel('title1', '1', 'images1'),
    CategoryModel('title2', '2', 'images2'),
    CategoryModel('title3', '3', 'images3'),
  ];

  setUp(() {
    itemsRepository = MockItemsRepository();
    sut = AddTaskCubit(itemsRepository: itemsRepository);
  });
  group('fetch', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getCategories())
            .thenAnswer((_) async => mockCategories);
      });
      blocTest<AddTaskCubit, AddTaskState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.fetch(),
        expect: () => [
          AddTaskState(
            status: Status.loading,
            categories: [],
          ),
          AddTaskState(status: Status.success, categories: mockCategories)
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getCategories())
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<AddTaskCubit, AddTaskState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.fetch(),
        expect: () => [
          AddTaskState(
            status: Status.loading,
            categories: [],
          ),
          AddTaskState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('add', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.addTasks('text', DateTime.utc(2022),
                TimeOfDay.fromDateTime(DateTime.utc(2022)), '1'))
            .thenAnswer((_) async => [
                  'text',
                  DateTime.utc(2022),
                  TimeOfDay.fromDateTime(DateTime.utc(2022)),
                  '1'
                ]);
        when(() => itemsRepository.getCategories())
            .thenAnswer((_) async => mockCategories);
      });
      blocTest<AddTaskCubit, AddTaskState>(
        'emits fetch(). when the saved is true',
        build: () => sut,
        act: (cubit) => cubit.add('text', DateTime.utc(2022),
            TimeOfDay.fromDateTime(DateTime.utc(2022)), '1'),
        expect: () => [
          AddTaskState(saved: true),
          AddTaskState(
            status: Status.loading,
            categories: [],
            saved: true,
          ),
          AddTaskState(
            status: Status.success,
            categories: mockCategories,
            saved: true,
          )
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.addTasks(
            'text',
            DateTime.utc(2022),
            TimeOfDay.fromDateTime(DateTime.utc(2022)),
            '1')).thenThrow(Exception('test-exception-error'));
      });
      blocTest<AddTaskCubit, AddTaskState>(
        'emits Status.error when saved fails',
        build: () => sut,
        act: (cubit) => cubit.add('text', DateTime.utc(2022),
            TimeOfDay.fromDateTime(DateTime.utc(2022)), '1'),
        expect: () => [
          AddTaskState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
}
