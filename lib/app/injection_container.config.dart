// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:modyfikacja_aplikacja/app/cubit/auth_cubit.dart' as _i10;
import 'package:modyfikacja_aplikacja/data/remote_data_sources/items_remote_data_source.dart'
    as _i3;
import 'package:modyfikacja_aplikacja/features/detalis/cubit/detalis_cubit.dart'
    as _i12;
import 'package:modyfikacja_aplikacja/features/home/pages/add_tasks/cubit/add_task_cubit.dart'
    as _i9;
import 'package:modyfikacja_aplikacja/features/home/pages/category_page/cubit/category_page_cubit.dart'
    as _i11;
import 'package:modyfikacja_aplikacja/features/home/pages/category_page/menu_pages/photo_note/cubit/photo_note_cubit.dart'
    as _i7;
import 'package:modyfikacja_aplikacja/features/home/pages/notepad/cubit/notepad_cubit.dart'
    as _i6;
import 'package:modyfikacja_aplikacja/features/home/pages/tasks/cubit/task_cubit.dart'
    as _i8;
import 'package:modyfikacja_aplikacja/repositories/item_repositories.dart'
    as _i4;
import 'package:modyfikacja_aplikacja/repositories/login_repositories.dart'
    as _i5;

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
    gh.factory<_i7.PhotoNoteCubit>(
        () => _i7.PhotoNoteCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i8.TaskCubit>(
        () => _i8.TaskCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i9.AddTaskCubit>(
        () => _i9.AddTaskCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i10.AuthCubit>(
        () => _i10.AuthCubit(loginRepository: gh<_i5.LoginRepository>()));
    gh.factory<_i11.CategoryPageCubit>(() =>
        _i11.CategoryPageCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    gh.factory<_i12.DetalisCubit>(
        () => _i12.DetalisCubit(itemsRepository: gh<_i4.ItemsRepository>()));
    return this;
  }
}
