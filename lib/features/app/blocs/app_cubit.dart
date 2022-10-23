import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

@lazySingleton
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.initial());

  void changePageIndex({required int index}) => emit(
        state.copyWith(
          pageIndex: index,
        ),
      );
}
