# :newspaper: Changelog

All notable changes to this project will be documented in this file.

## [1.0.0+4](https://github.com/fikretsengul/flutter_advanced_boilerplate/compare/XXXXXXX..aa4432a) - 2022-11-05 - NOT COMPLETED

### Upcoming enhancements

- Codemagic configuration is not completed yet. CI & CD implementation will be completed and documented.
- `isar` local storage solution will be implemented instead of `hive` with an example feature.
- NOTE: I'm also open to new feature or improvement requests. You can suggest by creating an issue.

### New features

- Web and web icon support added.
- State persistance example added with the new theme system by using `hydrated_storage`.

### Bug Fixes

- Custom golden test fixed.
- Android min and compile sdk versions updated for `flutter_secure_storage`.
- `hive` storage removed for now.
- Bugs fixed.

### Changed features

- The theme system was buggy so I rewrote it using bloc purely. So the `adaptive_theme` package is no longer needed.
- `internet_connection_checker` replaced with `internet_connection_checker_plus` to support web.
- `json_theme` added for encoding and decoding theme data.
- `hydrated_bloc` updated from 8.1.0 to 9.0.0.

## [1.0.0+3](https://github.com/fikretsengul/flutter_advanced_boilerplate/compare/b8bb7bf..aa4432a) - 2022-11-03

### Changed features

- Secure storage initialization and usage for token storage simplified also some bugs fixed.
- Packages updated.
- Q&A section added to README.nd and CHANGELOG.md file created.

## [1.0.0+2](https://github.com/fikretsengul/flutter_advanced_boilerplate/compare/4e68479..b8bb7bf) - 2022-10-31

### New features

- `r_resources` added to make asset usage type-safe.
- `reactive_forms` added to get form with validation functionality.
- Custom widgets (button, segmented control, textfield) are created. (More of them will be added in the future.)
- Authentication cubit and screen created with login/logout feature and token saving system implemented.
- BLoC and Golden tests implemented.

### Changed features

- `easy_localization` replaced with `slang` to make language system type-safe and be able to use it in tests.
- Bugs fixed.

## 1.0.0+1 - 2022-10-23

- Boilerplate initialized.
