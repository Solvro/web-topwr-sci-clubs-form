import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../firebase_save/services/submit_service.dart';
import '../model/form_model.dart';
import 'form_widgets_states.dart';

part 'form_widget_controller.g.dart';

@riverpod
class FormWidgetController extends _$FormWidgetController {
  @override
  FormWidgetState build() {
    return const FormWidgetState(
      state: FormViewState.form,
      data: SciClubFormModel(),
    );
  }

  void submit(SciClubFormModel model) async {
    state = FormWidgetState(
      state: FormViewState.loading,
      data: model,
    );
    final service = ref.read(submitServiceProvider);
    await service.submitSciClub(model);
    state = FormWidgetState(
      state: FormViewState.saved,
      data: model,
    );
  }
}
