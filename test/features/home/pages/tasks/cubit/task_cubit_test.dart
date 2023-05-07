import 'package:bloc_test/bloc_test.dart';
import 'package:do_the_task/app/core/enums.dart';
import 'package:do_the_task/features/home/pages/tasks/cubit/task_cubit.dart';
import 'package:do_the_task/models/task_model.dart';
import 'package:do_the_task/repositories/item_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late TaskCubit sut;
  late MockItemsRepository itemsRepository;
  final mockTasks = [
    TaskModel(
      text: 'text',
      id: 'id',
      categoryId: '1',
      releaseDate: DateTime.utc(2022),
    ),
    TaskModel(
      text: 'text22',
      id: 'id22',
      categoryId: '1',
      releaseDate: DateTime.utc(2022),
    ),
    TaskModel(
      text: 'text223',
      id: 'id223',
      categoryId: '1',
      releaseDate: DateTime.utc(2022),
    ),
  ];

  setUp(() {
    itemsRepository = MockItemsRepository();
    sut = TaskCubit(itemsRepository: itemsRepository);
  });
  group('getTasks', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.getTasks(categoryId: '1'))
            .thenAnswer((_) async => mockTasks);
      });
      blocTest<TaskCubit, TaskState>(
        'emits Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.getTasks('1'),
        expect: () => [
          TaskState(
            status: Status.loading,
            tasks: [],
          ),
          TaskState(status: Status.success, tasks: mockTasks)
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.getTasks(categoryId: '1'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<TaskCubit, TaskState>(
        'emits Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.getTasks('1'),
        expect: () => [
          TaskState(
            status: Status.loading,
            tasks: [],
          ),
          TaskState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error'),
        ],
      );
    });
  });
  group('deleteTask', () {
    group('success', () {
      setUp(() {
        when(() => itemsRepository.deleteTask(id: '1'))
            .thenAnswer((_) async => []);
      });
      blocTest<TaskCubit, TaskState>(
        'remove',
        build: () => sut,
        act: (cubit) => cubit.remove(documentID: '1'),
        expect: () => [],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => itemsRepository.deleteTask(id: '1'))
            .thenThrow(Exception('test-exception-error'));
        when(() => itemsRepository.getTasks(categoryId: '1'))
            .thenAnswer((_) async => mockTasks);
      });
      blocTest<TaskCubit, TaskState>(
        'emits Status.error with an error message when deletion fails',
        build: () => sut,
        act: (cubit) => cubit.remove(documentID: '1', categoryId: '1'),
        expect: () => [
          TaskState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
          TaskState(
            status: Status.loading,
            tasks: [],
          ),
          TaskState(status: Status.success, tasks: mockTasks)
        ],
      );
    });
  });
}
