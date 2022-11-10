# :newspaper: Changelog

All notable changes to this project will be documented in this file.

## [1.0.0+5](https://github.com/fikretsengul/flutter_advanced_boilerplate/compare/b26dbb2..526ae91) - 2022-11-10

### Upcoming enhancements

- Codemagic configuration is not completed yet. CI & CD implementation will be completed.
- `isar` local storage solution will be implemented instead of `hive` with an example feature.

### New features

- ['Permission handling'](https://github.com/fikretsengul/flutter_advanced_boilerplate/issues/14) system implemented for only mobile and an example added about image picker.
- `shimmer` added for skeletons, `keframe` added for performance, `url_strategy` added to remove '#' from the url of the web version, `image_picker` added for image picker example, `permission_handler` added in order to manage permissions on only mobile.

### Enhancements

- Web support enhanced.
- `Constants` in utils and `widgets` in presentations of features refactored.
- Performance optimized for lag caused by builds, such as page switches or rapid scrolling of complex lists, through frame-splitting rendering via `keframe`.
- `Skeleton loading` implemented for loading widgets via `shimmer`.

### Bug Fixes

- ['AuthCubit close when app still using'](https://github.com/fikretsengul/flutter_advanced_boilerplate/issues/12) issue fixed.
- ['Login screen - takes hitting tab twice to move to password field on web'](https://github.com/fikretsengul/flutter_advanced_boilerplate/issues/9) issue fixed.

## [1.0.0+4](https://github.com/fikretsengul/flutter_advanced_boilerplate/compare/aa4432a..b26dbb2) - 2022-11-05

### New features

- Web support added. (Custom svg icons & fonts not supported by canvaskit renderer.)
- State persistance example added with the new theme system by using `hydrated_storage`.

### Bug Fixes

- Android minimum and compile sdk versions updated for `flutter_secure_storage`.
- `hive` storage removed for now.
- Bugs fixed.

### Changed features

- The theme system was buggy so I rewrote it using bloc purely. So the `adaptive_theme` package is no longer needed.
- `internet_connection_checker` replaced with `internet_connection_checker_plus` to support web.
- `json_theme` added for encoding and decoding theme data.
- `hydrated_bloc` updated from 8.1.0 to 9.0.0.
- `ionicons` removed for web canvaskit support.
- `universal_platform` added to identify all platforms.
- `json_theme` to easily convert theme data toJson and fromJson.

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
