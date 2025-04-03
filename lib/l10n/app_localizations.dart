import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pl')
  ];

  /// No description provided for @home_screen_greeting.
  ///
  /// In pl, this message translates to:
  /// **'Cześć, miło Cię widzieć'**
  String get home_screen_greeting;

  /// No description provided for @even_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Poniedziałek'**
  String get even_monday;

  /// No description provided for @even_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Wtorek'**
  String get even_tuesday;

  /// No description provided for @even_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzystą Środę'**
  String get even_wednesday;

  /// No description provided for @even_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Czwartek'**
  String get even_thursday;

  /// No description provided for @even_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzysty Piątek'**
  String get even_friday;

  /// No description provided for @even_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzystą Sobotę'**
  String get even_saturday;

  /// No description provided for @even_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Parzystą Niedzielę'**
  String get even_sunday;

  /// No description provided for @odd_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Poniedziałek'**
  String get odd_monday;

  /// No description provided for @odd_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Wtorek'**
  String get odd_tuesday;

  /// No description provided for @odd_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzystą Środę'**
  String get odd_wednesday;

  /// No description provided for @odd_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Czwartek'**
  String get odd_thursday;

  /// No description provided for @odd_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzysty Piątek'**
  String get odd_friday;

  /// No description provided for @odd_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzystą Sobota'**
  String get odd_saturday;

  /// No description provided for @odd_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Nieparzystą Niedzielę'**
  String get odd_sunday;

  /// No description provided for @holiday_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Poniedziałek'**
  String get holiday_monday;

  /// No description provided for @holiday_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Wtorek'**
  String get holiday_tuesday;

  /// No description provided for @holiday_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjną Środę'**
  String get holiday_wednesday;

  /// No description provided for @holiday_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Czwartek'**
  String get holiday_thursday;

  /// No description provided for @holiday_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjny Piątek'**
  String get holiday_friday;

  /// No description provided for @holiday_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjną Sobota'**
  String get holiday_saturday;

  /// No description provided for @holiday_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Wakacyjną Niedzielę'**
  String get holiday_sunday;

  /// No description provided for @exam_monday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Poniedziałek'**
  String get exam_monday;

  /// No description provided for @exam_tuesday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Wtorek'**
  String get exam_tuesday;

  /// No description provided for @exam_wednesday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjną Środę'**
  String get exam_wednesday;

  /// No description provided for @exam_thursday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Czwartek'**
  String get exam_thursday;

  /// No description provided for @exam_friday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjny Piątek'**
  String get exam_friday;

  /// No description provided for @exam_saturday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjną Sobota'**
  String get exam_saturday;

  /// No description provided for @exam_sunday.
  ///
  /// In pl, this message translates to:
  /// **'w Egzaminacyjną Niedzielę'**
  String get exam_sunday;

  /// No description provided for @unknown_day.
  ///
  /// In pl, this message translates to:
  /// **'w ten piękny dzień!'**
  String get unknown_day;

  /// No description provided for @read_more.
  ///
  /// In pl, this message translates to:
  /// **'Czytaj dalej'**
  String get read_more;

  /// No description provided for @whats_up.
  ///
  /// In pl, this message translates to:
  /// **'Co słychać?'**
  String get whats_up;

  /// No description provided for @study_circles.
  ///
  /// In pl, this message translates to:
  /// **'Organizacje Studenckie'**
  String get study_circles;

  /// No description provided for @days.
  ///
  /// In pl, this message translates to:
  /// **'dni'**
  String get days;

  /// No description provided for @to_start_session.
  ///
  /// In pl, this message translates to:
  /// **'do rozpoczęcia sesji'**
  String get to_start_session;

  /// No description provided for @map_button.
  ///
  /// In pl, this message translates to:
  /// **'Mapa'**
  String get map_button;

  /// No description provided for @sections.
  ///
  /// In pl, this message translates to:
  /// **'Wydziały'**
  String get sections;

  /// No description provided for @list.
  ///
  /// In pl, this message translates to:
  /// **'Lista'**
  String get list;

  /// No description provided for @departments.
  ///
  /// In pl, this message translates to:
  /// **'Wydziały'**
  String get departments;

  /// No description provided for @department.
  ///
  /// In pl, this message translates to:
  /// **'Wydział'**
  String get department;

  /// No description provided for @search.
  ///
  /// In pl, this message translates to:
  /// **'Szukaj'**
  String get search;

  /// No description provided for @contact.
  ///
  /// In pl, this message translates to:
  /// **'Kontakt'**
  String get contact;

  /// No description provided for @about_us.
  ///
  /// In pl, this message translates to:
  /// **'O nas'**
  String get about_us;

  /// No description provided for @navigate.
  ///
  /// In pl, this message translates to:
  /// **'Nawiguj'**
  String get navigate;

  /// No description provided for @building_prefix.
  ///
  /// In pl, this message translates to:
  /// **'Budynek'**
  String get building_prefix;

  /// No description provided for @department_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono wydziału'**
  String get department_not_found;

  /// No description provided for @type_sci_circle.
  ///
  /// In pl, this message translates to:
  /// **'Wpisz nazwę koła naukowego'**
  String get type_sci_circle;

  /// No description provided for @sci_circle_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono organizacji studenckich'**
  String get sci_circle_not_found;

  /// No description provided for @all.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie'**
  String get all;

  /// No description provided for @parkings_title.
  ///
  /// In pl, this message translates to:
  /// **'Parkingi'**
  String get parkings_title;

  /// No description provided for @parkings_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono parkingu'**
  String get parkings_not_found;

  /// No description provided for @building_not_found.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono budynku'**
  String get building_not_found;

  /// No description provided for @buildings_title.
  ///
  /// In pl, this message translates to:
  /// **'Budynki'**
  String get buildings_title;

  /// No description provided for @freePlaces.
  ///
  /// In pl, this message translates to:
  /// **'Wolne miejsca'**
  String get freePlaces;

  /// No description provided for @noChartData.
  ///
  /// In pl, this message translates to:
  /// **'Dane wykresów są niedostępne w nocy'**
  String get noChartData;

  /// No description provided for @offlineParkings.
  ///
  /// In pl, this message translates to:
  /// **'Błąd połączenia: niestety, moduł parkingów nie może poprawnie działać bez połączenia internetowego'**
  String get offlineParkings;

  /// No description provided for @refresh.
  ///
  /// In pl, this message translates to:
  /// **'Odśwież'**
  String get refresh;

  /// No description provided for @offline_error_message.
  ///
  /// In pl, this message translates to:
  /// **'Wystąpił błąd podczas pobierania danych dotyczących '**
  String get offline_error_message;

  /// No description provided for @offline_try_again.
  ///
  /// In pl, this message translates to:
  /// **'Spróbuj ponownie później'**
  String get offline_try_again;

  /// No description provided for @offline_news.
  ///
  /// In pl, this message translates to:
  /// **'wiadomości'**
  String get offline_news;

  /// No description provided for @offline_sci_clubs.
  ///
  /// In pl, this message translates to:
  /// **'organizacji studenckich'**
  String get offline_sci_clubs;

  /// No description provided for @offline_buildings.
  ///
  /// In pl, this message translates to:
  /// **'budynków'**
  String get offline_buildings;

  /// No description provided for @offline_departments.
  ///
  /// In pl, this message translates to:
  /// **'wydziałów'**
  String get offline_departments;

  /// No description provided for @offline_academic_calendar.
  ///
  /// In pl, this message translates to:
  /// **'kalendarza akademickiego'**
  String get offline_academic_calendar;

  /// No description provided for @form_sci_club_name.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa koła/organizacji'**
  String get form_sci_club_name;

  /// No description provided for @form_sci_short_desc.
  ///
  /// In pl, this message translates to:
  /// **'Krótki opis'**
  String get form_sci_short_desc;

  /// No description provided for @form_sci_desc.
  ///
  /// In pl, this message translates to:
  /// **'Opis'**
  String get form_sci_desc;

  /// No description provided for @drag_and_drop.
  ///
  /// In pl, this message translates to:
  /// **'Przeciągnij i upuść zdjęcie'**
  String get drag_and_drop;

  /// No description provided for @or_choose_btn_msg.
  ///
  /// In pl, this message translates to:
  /// **'Lub wybierz plik'**
  String get or_choose_btn_msg;

  /// No description provided for @allowed_ext.
  ///
  /// In pl, this message translates to:
  /// **'Dopuszczalne rozszerzenia: '**
  String get allowed_ext;

  /// No description provided for @form_logo.
  ///
  /// In pl, this message translates to:
  /// **'Logo koła/organizacji'**
  String get form_logo;

  /// No description provided for @form_cover.
  ///
  /// In pl, this message translates to:
  /// **'Zdjęcie cover'**
  String get form_cover;

  /// No description provided for @form_sci_club_department.
  ///
  /// In pl, this message translates to:
  /// **'Wydział'**
  String get form_sci_club_department;

  /// No description provided for @cultural_agenda_type.
  ///
  /// In pl, this message translates to:
  /// **'Agenda kultury'**
  String get cultural_agenda_type;

  /// No description provided for @stud_media_type.
  ///
  /// In pl, this message translates to:
  /// **'Media studenckie'**
  String get stud_media_type;

  /// No description provided for @stud_org_type.
  ///
  /// In pl, this message translates to:
  /// **'Organizacja studencka'**
  String get stud_org_type;

  /// No description provided for @sci_circle_type.
  ///
  /// In pl, this message translates to:
  /// **'Koło naukowe'**
  String get sci_circle_type;

  /// No description provided for @form_sci_type.
  ///
  /// In pl, this message translates to:
  /// **'Rodzaj organizacji'**
  String get form_sci_type;

  /// No description provided for @form_sci_tags.
  ///
  /// In pl, this message translates to:
  /// **'Kategorie tematyczne (max. 3)'**
  String get form_sci_tags;

  /// No description provided for @max3tags.
  ///
  /// In pl, this message translates to:
  /// **'Możesz wybrać maksymalnie 3 tagi'**
  String get max3tags;

  /// No description provided for @form_sci_social_links.
  ///
  /// In pl, this message translates to:
  /// **'Kontakt i sociale'**
  String get form_sci_social_links;

  /// No description provided for @url_field.
  ///
  /// In pl, this message translates to:
  /// **'Email lub link do socialek'**
  String get url_field;

  /// No description provided for @url_name_field.
  ///
  /// In pl, this message translates to:
  /// **'Tekst wyświetlający się (opcjonalne)'**
  String get url_name_field;

  /// No description provided for @add_social_link_btn.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj email/link'**
  String get add_social_link_btn;

  /// No description provided for @link_field_hint.
  ///
  /// In pl, this message translates to:
  /// **'np. https://facebook.com/knsolvro lub kn.solvro@pwr.edu.pl'**
  String get link_field_hint;

  /// No description provided for @link_display_hint.
  ///
  /// In pl, this message translates to:
  /// **'np. facebook.com/knsolvro lub `mój super link`'**
  String get link_display_hint;

  /// No description provided for @form_sci_desc_hint.
  ///
  /// In pl, this message translates to:
  /// **'Wprowadź tu swój super opis swojego super koła/organizacji'**
  String get form_sci_desc_hint;

  /// No description provided for @form_err_req.
  ///
  /// In pl, this message translates to:
  /// **'To pole jest wymagane. Nie możesz zostawić go pustego.'**
  String get form_err_req;

  /// No description provided for @form_err_email.
  ///
  /// In pl, this message translates to:
  /// **'Nie jest to poprawny email'**
  String get form_err_email;

  /// No description provided for @form_err_https_pattrn.
  ///
  /// In pl, this message translates to:
  /// **'Linki url muszą mieć format https://google.com'**
  String get form_err_https_pattrn;

  /// No description provided for @form_title.
  ///
  /// In pl, this message translates to:
  /// **'Ankieta kół/organizacji do aplikacji mobilnej ToPWR'**
  String get form_title;

  /// No description provided for @form_desc1.
  ///
  /// In pl, this message translates to:
  /// **'ToPWR to aplikacja mobilna stworzona przez studentów dla studentów Politechniki Wrocławskiej, tworzona przez KN Solvro. Licznik dni do sesji, mapka kampusu, informacje o dziekanatach, kółkach naukowych i licznik wolnych miejsc parkingowych na żywo - wszystko, co trzeba w jednym miejscu. Life made easy. 🚀'**
  String get form_desc1;

  /// No description provided for @form_desc2.
  ///
  /// In pl, this message translates to:
  /// **'Zapraszamy do wypełnienia informacji o Waszym kole naukowym, organizacji studenckiej, mediach lub agendzie. Dane zbieramy do specjalnej sekcji w aplikacji, gdzie będzie można wyszukać Wasze koło i przeczytać czym się zajmujecie. Organizacje, które skorzystają z tej ankiety, będą miały też wyższy priorytet podczas wyszukiwania. Wprowadzane dane można na bieżąco obserwować w podglądzie aplikacji. Można spojrzeć jak wprowadzone dane będą prezentować się na kafelku na ekranie domowym, na liście kół/organizacji oraz w widoku szczegółowym. '**
  String get form_desc2;

  /// No description provided for @form_desc3.
  ///
  /// In pl, this message translates to:
  /// **'Możliwy jest wielokrotny zapis i powrót do wprowadzonych wcześniej informacji, które to zostaną wdrożone do aplikacji dopiero we wrześniu. Zmiany w przyszłości będą oczywiście nadal możliwe, ale ta ankieta nie jest spięta na żywo z aplikacją i ewentualne zmiany będą wymagały szybkiego kontaktu z naszym zespołem.'**
  String get form_desc3;

  /// No description provided for @form_desc4.
  ///
  /// In pl, this message translates to:
  /// **'Dzięki za poświęcony czas i z chęcią usłyszymy każdy feedback.'**
  String get form_desc4;

  /// No description provided for @submit.
  ///
  /// In pl, this message translates to:
  /// **'Wyślij zmiany'**
  String get submit;

  /// No description provided for @default_name.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa koła'**
  String get default_name;

  /// No description provided for @guest_page.
  ///
  /// In pl, this message translates to:
  /// **'Witamy w ankiecie ToPWR dla kół naukowych i innych organizacji studenckich na Politechnice Wrocławskiej!'**
  String get guest_page;

  /// No description provided for @guest_page2.
  ///
  /// In pl, this message translates to:
  /// **'ToPWR to aplikacja mobilna stworzona przez studentów z KN Solvro dla wszystkich studentów Politechniki Wrocławskiej. Licznik dni do sesji, mapka kampusu, informacje o dziekanatach, kołach naukowych i licznik wolnych miejsc parkingowych na żywo - wszystko, co trzeba w jednym miejscu. Life made easy. 🚀'**
  String get guest_page2;

  /// No description provided for @guest_page3.
  ///
  /// In pl, this message translates to:
  /// **'Poprzez tę ankietę zbieramy dane o wszystkich kołach naukowych, organizacjach studenckich, mediach i agendach. W miarę publicznej dostępności waszych danych kontaktowych, rozesłaliśmy specjalne dedykowane linki do edycji danych o Waszej organizacji. Jeśli nie otrzymaliście jeszcze dostępu do naszej ankiety, skontaktujcie się z nami czym prędzej!'**
  String get guest_page3;

  /// No description provided for @contact_landing.
  ///
  /// In pl, this message translates to:
  /// **'Skontaktuj się'**
  String get contact_landing;

  /// No description provided for @read_more_landing.
  ///
  /// In pl, this message translates to:
  /// **'Przeczytaj więcej'**
  String get read_more_landing;

  /// No description provided for @wrong_link.
  ///
  /// In pl, this message translates to:
  /// **'Ups! Zły link ://'**
  String get wrong_link;

  /// No description provided for @wrong_link_desc.
  ///
  /// In pl, this message translates to:
  /// **'Niestety podany link nie jest prawidłowy. Proszę skontaktuj się z nami aby to wyjaśnić.'**
  String get wrong_link_desc;

  /// No description provided for @write_email.
  ///
  /// In pl, this message translates to:
  /// **'Napisz maila'**
  String get write_email;

  /// No description provided for @text404.
  ///
  /// In pl, this message translates to:
  /// **'Ups :// Chyba się zgubiłeś, bo nie ma takiej strony.'**
  String get text404;

  /// No description provided for @take_me_home.
  ///
  /// In pl, this message translates to:
  /// **'Zabierz mnie do domu'**
  String get take_me_home;

  /// No description provided for @done_page.
  ///
  /// In pl, this message translates to:
  /// **'Wysłano twoją odpowiedź!'**
  String get done_page;

  /// No description provided for @done_page2.
  ///
  /// In pl, this message translates to:
  /// **'Wprowadzone informacje zostały zapisane. Gdy tylko nadejdzie potrzeba korekcji umieszczonych danych, można tu wrócić i dokonać odpowiednich zmian. Po tym jak informacje zostaną wdrożone do aplikacji, edycja będzie wymagała kontaktu z naszym zespołem.'**
  String get done_page2;

  /// No description provided for @back_to_edit.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj swoją odpowiedź'**
  String get back_to_edit;

  /// No description provided for @saving.
  ///
  /// In pl, this message translates to:
  /// **'Zapisujemy...'**
  String get saving;

  /// No description provided for @wait_here.
  ///
  /// In pl, this message translates to:
  /// **'Prosimy o chwilkę cierpliwości i pozostanie na tej stronie'**
  String get wait_here;

  /// No description provided for @show_preview.
  ///
  /// In pl, this message translates to:
  /// **'Podgląd'**
  String get show_preview;

  /// No description provided for @dept_form_info.
  ///
  /// In pl, this message translates to:
  /// **'Aby zmienić wydział, skontaktuj się z nami'**
  String get dept_form_info;

  /// No description provided for @form_use_cover_as_preview.
  ///
  /// In pl, this message translates to:
  /// **'Użyj zdjęcia cover do podglądu na widoku domowym i szczegółach wydziału (Włączone = cover, wyłączone = logo)'**
  String get form_use_cover_as_preview;

  /// No description provided for @no_address.
  ///
  /// In pl, this message translates to:
  /// **'Brak adresu'**
  String get no_address;

  /// No description provided for @student_medias.
  ///
  /// In pl, this message translates to:
  /// **' Media studenckie'**
  String get student_medias;

  /// No description provided for @cultural_agendas.
  ///
  /// In pl, this message translates to:
  /// **'Agendy kultury'**
  String get cultural_agendas;

  /// No description provided for @scientific_cirlces.
  ///
  /// In pl, this message translates to:
  /// **'Koła naukowe'**
  String get scientific_cirlces;

  /// No description provided for @student_organizations.
  ///
  /// In pl, this message translates to:
  /// **'Organizacje studenckie'**
  String get student_organizations;

  /// No description provided for @org_types.
  ///
  /// In pl, this message translates to:
  /// **'Rodzaje organizacji'**
  String get org_types;

  /// No description provided for @categories.
  ///
  /// In pl, this message translates to:
  /// **'Kategorie tematyczne'**
  String get categories;

  /// No description provided for @filters.
  ///
  /// In pl, this message translates to:
  /// **'Filtry'**
  String get filters;

  /// No description provided for @clear.
  ///
  /// In pl, this message translates to:
  /// **'Wyczyść'**
  String get clear;

  /// No description provided for @filters_didnt_found_anything.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono żadnych filtrów'**
  String get filters_didnt_found_anything;

  /// No description provided for @stud_council_type.
  ///
  /// In pl, this message translates to:
  /// **'Samorząd'**
  String get stud_council_type;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
