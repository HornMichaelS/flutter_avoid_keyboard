# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

No unreleased changes.

## [0.2.3] - 2021-06-08

### Added

- Github issue templates

### Fixed

- Prevent internal timeout exception from escaping.

## [0.2.2] - 2021-06-06

### Changed

- Wrapped the view in a `ClipRect` so that the contents would be clipped when they move.
  - This prevents the contents of the view from colliding with surrounding views which
    aren't wrapped.

### Fixed

- Formatting error in Changelog.
- Layout bug related to positioning a viewport within an unsized parent.
  - Use `AnimatedContainer` with `transform`, rather than a `Scrollable` widget.

## [0.2.1] - 2021-06-05

### Fixed

- Typo in Readme.
- Removed extraneous print statement.

## [0.2.0] - 2021-06-05

### Added

- Option to specify spacing between the top of the keyboard and the bottom of the 
  focused text field.

### Changed

- No longer require `focusNodes` field on `AvoidKeyboard` widget.

### Fixed

- Fixed bug in detecting when the focused field changed from one active node to another.
- Ordering of Changelog entries

## [0.1.1] - 2021-06-05

### Changed

- Improved pubspec.yaml description field

## [0.1.0] - 2021-06-04

### Added

- README.md explaining the motivation and usage for the package.
- Dart library containing the `AvoidKeyboard` widget
- An example app under /example

[0.1.0]: https://github.com/HornMichaelS/flutter_avoid_keyboard/releases/tag/v0.1.0-alpha
[0.1.1]: https://github.com/HornMichaelS/flutter_avoid_keyboard/compare/v0.1.0-alpha...v0.1.1-alpha
[0.2.0]: https://github.com/HornMichaelS/flutter_avoid_keyboard/compare/v0.1.1-alpha...v0.2.0-alpha
[0.2.1]: https://github.com/HornMichaelS/flutter_avoid_keyboard/compare/v0.2.0-alpha...v0.2.1-alpha
[0.2.2]: https://github.com/HornMichaelS/flutter_avoid_keyboard/compare/v0.2.1-alpha...v0.2.2
[0.2.3]: https://github.com/HornMichaelS/flutter_avoid_keyboard/compare/v0.2.2...v0.2.3
[Unreleased]: https://github.com/HornMichaelS/flutter_avoid_keyboard/compare/v0.2.3...HEAD
