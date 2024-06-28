import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/form_model.dart';

part 'form_widgets_states.freezed.dart';

enum FormViewState {
  form,
  loading,
  saved,
}

@freezed
class FormWidgetState with _$FormWidgetState {
  const factory FormWidgetState({
    required FormViewState state,
    required SciClubFormModel data,
  }) = _FormWidgetState;
}
