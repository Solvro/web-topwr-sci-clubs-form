import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../form/model/form_model.dart';
import 'mockup_frame.dart';

class ShowPreviewFAB extends StatelessWidget {
  const ShowPreviewFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final form = ReactiveSciClubFormModelForm.of(context)!;
    return FloatingActionButton.extended(
      onPressed: () {
        showAdaptiveDialog(
          context: context,
          builder: (context) => SciClubFormModelFormInheritedStreamer(
            form: form,
            stream: form.form.statusChanged,
            child: Stack(
              children: [
                ModalBarrier(
                  color: context.colorTheme.blackMirage.withOpacity(0.8),
                ),
                const Center(child: MockupFrame()),
              ],
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
    );
  }
}
