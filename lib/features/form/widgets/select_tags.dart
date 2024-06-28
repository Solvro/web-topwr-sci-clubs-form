import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../../utils/context_extensions.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../firebase/repositories/tags_repo.dart';

import '../../topwr_mockup/widgets/my_error_widget.dart';
import 'form_subsection.dart';

class SelectTags extends ConsumerWidget {
  const SelectTags(this.formControl, {super.key});

  final FormArray<bool>? formControl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(remoteTagsRepositoryProvider);
    return switch (tags) {
      AsyncLoading() => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => TagsCheckboxList(
          value.whereNonNull.toList(),
          formControl,
        ),
    };
  }
}

class TagsCheckboxList extends ConsumerWidget {
  const TagsCheckboxList(this.tags, this.formControl, {super.key});
  final List<Tag>? tags;
  final FormArray<bool>? formControl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ReactiveFormArray(
        formArray: formControl,
        builder: (context, formArray, child) {
          return FormSubsection(
            title: context.localize.form_sci_tags,
            errorMessage: context.localize.max3tags,
            onInitState: () {
              formControl?.addAll(
                tags
                        ?.map(
                          (email) => FormControl<bool>(value: false),
                        )
                        .toList() ??
                    [],
              );
            },
            buildChildren: (setError) {
              return [
                for (final iter in IterableZip([
                  formArray.controls,
                  tags ?? [],
                ]))
                  ReactiveCheckboxListTile(
                    key: ValueKey(iter.last?.name),
                    formControl: iter.first as FormControl<bool>?,
                    title: Text(iter.last?.name),
                    onChanged: (control) {
                      final allTrues =
                          formArray.controls.where((e) => e.value == true);
                      if (allTrues.length > 3) {
                        for (final element in allTrues) {
                          element.setErrors({"": ""});
                        }
                        setError(true);
                      } else {
                        for (final element in allTrues) {
                          element.setErrors({});
                        }
                        setError(false);
                      }
                    },
                  ),
              ];
            },
          );
        });
  }
}
