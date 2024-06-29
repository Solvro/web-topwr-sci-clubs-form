import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/form_model.dart';

part 'form_widgets_states.freezed.dart';

@freezed
sealed class FormWidgetState with _$FormWidgetState {
  const factory FormWidgetState.activeForm(
    SciClubFormModel data,
  ) = ActiveForm;

  const factory FormWidgetState.loading() = Loading;

  const factory FormWidgetState.saved(
    SciClubFormModel data,
  ) = Saved;
}
