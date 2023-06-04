// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:do_the_task/app/cubit/auth_cubit.dart' as _i13;
import 'package:do_the_task/data/remote_data_sources/items_remote_data_source.dart'
    as _i3;
import 'package:do_the_task/features/detalis/cubit/detalis_cubit.dart' as _i15;
import 'package:do_the_task/features/home/pages/add_tasks/cubit/add_task_cubit.dart'
    as _i12;
import 'package:do_the_task/features/home/pages/category_page/cubit/category_page_cubit.dart'
    as _i14;
import 'package:do_the_task/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart'
    as _i10;
import 'package:do_the_task/features/home/pages/notepad/cubit/notepad_cubit.dart'
    as _i6;
import 'package:do_the_task/features/home/pages/tasks/cubit/task_cubit.dart'
    as _i11;
import 'package:do_the_task/repositories/item_repository.dart' as _i4;
import 'package:do_the_task/repositories/login_repository.dart' as _i5;
import 'package:do_the_task/services/notifi_serivice.dart' as _i9;
import 'package:do_the_task/services/notification_preference.dart' as _i7;
import 'package:do_the_task/services/notification_provider.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.ItemsRemoteDataSources>(() => _i3.ItemsRemoteDataSources());
    gh.factory<_i4.ItemsRepository>(() => _i4.ItemsRepository(
        itemsRemoteDataSources: gh<_i3.ItemsRemoteDataSources>()));
    gh.factory<_i5.LoginRepository>(() => _i5.LoginRepository());
    gh.factory<_i6.NotepadCubit>(
        () => _i6.NotepadCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i7.NotificationPreference>(() => _i7.NotificationPreference());
    gh.factory<_i8.NotificationProvider>(
        () => _i8.NotificationProvider(gh<_i7.NotificationPreference>()));
    gh.factory<_i9.NotificationService>(
        () => _i9.NotificationService(gh<_i8.NotificationProvider>()));
    gh.factory<_i10.PhotoNoteCubit>(
        () => _i10.PhotoNoteCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i11.TaskCubit>(
        () => _i11.TaskCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i12.AddTaskCubit>(
        () => _i12.AddTaskCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i13.AuthCubit>(() => _i13.AuthCubit(
          loginRepository: gh<_i5.LoginRepository>(),
          notificationService: gh<_i9.NotificationService>(),
        ));
    gh.factory<_i14.CategoryPageCubit>(() =>
        _i14.CategoryPageCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i15.DetalisCubit>(
        () => _i15.DetalisCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    return this;
  }
}
