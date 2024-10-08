import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../auth/models/auth_state.dart";
import "../../auth/repository/remote_auth_repo.dart";
import "../../firebase/repositories/sci_clubs_repo.dart";
import "../../firebase/services/adapter_service.dart";
import "../../firebase/services/submit_service.dart";
import "../../topwr_mockup/features/bottom_nav_bar/bottom_nav_bar_controller.dart";
import "../../topwr_mockup/features/navigator/navigator/nested_navigator.dart";
import "../model/form_model.dart";
import "form_widgets_states.dart";

part "form_widget_controller.g.dart";

@riverpod
class FormWidgetController extends _$FormWidgetController {
  @override
  Future<FormWidgetState> build() async {
    final auth = await ref.watch(remoteAuthRepoProvider.future);
    if (auth is Logged) {
      final club = await ref
          .watch(sciClubsRepoProvider.notifier)
          .getClubForUser(auth.user);
      if (club != null) {
        final adapter = ref.watch(adapterServiceProvider);
        return FormWidgetState.activeForm(
          await adapter.fromFirebaseToForm(club),
        );
      }
      return const FormWidgetState.activeForm(SciClubFormModel());
    }
    return const FormWidgetState.loading();
  }

  Future<void> submit(SciClubFormModel model) async {
    state = const AsyncData(FormWidgetState.saving());
    final service = ref.read(submitServiceProvider);
    await service.submitSciClub(model);
    state = AsyncData(FormWidgetState.saved(model));
  }

  Future<void> backToEditing() async {
    state = const AsyncLoading();
    await Future.sync(() {
      ref.invalidate(navigatorProvider);
      ref.invalidate(bottomNavBarControllerProvider);
      ref.invalidateSelf();
    });
  }
}
