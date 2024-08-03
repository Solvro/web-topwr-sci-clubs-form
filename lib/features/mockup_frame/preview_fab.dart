import "package:flutter/material.dart";
import "package:pointer_interceptor/pointer_interceptor.dart";

import "../../config/config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../form/model/form_model.dart";
import "mockup_frame.dart";

class ShowPreviewFAB extends StatelessWidget {
  const ShowPreviewFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.viewInsetsOf(context).bottom == 0.0;
    if (!showFab) {
      return const SizedBox.shrink();
    }
    final form = ReactiveSciClubFormModelForm.of(context)!;
    return PointerInterceptor(
      child: FloatingActionButton.extended(
        onPressed: () async {
          await showAdaptiveDialog(
            context: context,
            builder: (context) => PointerInterceptor(
              child: SciClubFormModelFormInheritedStreamer(
                form: form,
                stream: form.form.statusChanged,
                child: Stack(
                  children: [
                    ModalBarrier(
                      color: context.colorTheme.blackMirage.withOpacity(0.8),
                    ),
                    const Center(child: MockupFrame()),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: CloseButton(
                          color: context.colorTheme.whiteSoap,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              context.colorTheme.greyPigeon,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        label: Text(context.localize.show_preview),
        icon: const Icon(Icons.smartphone_outlined),
        backgroundColor: context.colorTheme.greyPigeon,
        foregroundColor: context.colorTheme.whiteSoap,
        splashColor: context.colorTheme.orangePomegranade,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(FormFieldConfig.radius),
        ),
      ),
    );
  }
}
