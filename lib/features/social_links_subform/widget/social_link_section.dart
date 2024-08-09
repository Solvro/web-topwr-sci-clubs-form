import "dart:async";

import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../form/model/form_model.dart";
import "../../form/widgets/form_fields.dart";
import "link_field.dart";

class SocialLinkSection extends StatefulWidget {
  const SocialLinkSection(
    this.model, {
    super.key,
    required this.removeCallback,
  });
  final SocialUrlForm model;
  final VoidCallback? removeCallback;

  @override
  State<SocialLinkSection> createState() => _SocialLinkSectionState();
}

class _SocialLinkSectionState extends State<SocialLinkSection> {
  StreamSubscription? subs;
  @override
  void initState() {
    subs = widget.model.urlControl?.valueChanges
        .listen((event) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    unawaited(subs?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          LinkField(
            formControl: widget.model.urlControl,
            widget.model.model,
            context.localize.url_field,
            hintText:
                // ignore: avoid_redundant_argument_values
                null, // TODO(simon-the-shark): fix this when flutter fixes hint
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: widget.removeCallback,
                icon: Icon(
                  Icons.remove_circle,
                  color: context.colorTheme.orangePomegranade,
                ),
              ),
            ),
          ),
          if (!widget.model.model.isUrlEmail)
            MyFormField(
              formControl: widget.model.nameControl,
              context.localize.url_name_field,
              hintText: context.localize.link_display_hint,
            ),
        ],
      ),
    );
  }
}
