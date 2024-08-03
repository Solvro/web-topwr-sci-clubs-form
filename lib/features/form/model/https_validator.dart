import "package:reactive_forms_annotations/reactive_forms_annotations.dart";

class HttpsValidator extends Validator<String> {
  const HttpsValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<String> control) {
    final error = <String, dynamic>{ValidationMessage.pattern: true};
    final pattern = RegExp(
      r"https?://(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)",
    );
    return pattern.allMatches(control.value ?? "").isNotEmpty ? null : error;
  }
}
