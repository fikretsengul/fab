/// Enum for defining app styles.
///
/// Important distinction, Style is not Theme.
/// Style contains of Light Theme and AppColorScheme, Dark Theme and AppColorScheme
///
/// In most cases you will need only "normal" type. This class becomes useful
/// when app needs to define many styles eg. normal, pro, premium.
enum AppThemeType {
  system,
  user,
}
