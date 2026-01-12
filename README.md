# force_english_ime

[![pub package](https://img.shields.io/badge/pub-0.0.2-blue)](https://pub.dev/packages/force_english_ime)
[![license](https://img.shields.io/badge/license-MIT-green)](LICENSE)

[中文文档](README_CN.md)

A Windows plugin for Flutter that forces English input mode by completely disabling IME. Prevents users from switching input methods via shortcuts like Shift or Ctrl+Space.

## Features

- ✅ **Complete IME Disable** - Uses `ImmAssociateContext` to completely disable IME
- ✅ **Automatic State Management** - Auto-save and restore IME state
- ✅ **Accurate Detection** - Precise input mode detection using `ImmGetConversionStatus`
- ✅ **Zero Dependencies** - Only uses Windows IMM API
- ✅ **Easy Integration** - Simple API with Focus widget support

## Platform Support

| Platform | Support |
|----------|---------|
| Windows  | ✅      |
| macOS    | ❌      |
| Linux    | ❌      |
| Android  | ❌      |
| iOS      | ❌      |

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  force_english_ime: ^0.0.2
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Basic Usage

```dart
import 'package:force_english_ime/force_english_ime.dart';

final _imePlugin = ForceEnglishIme();

// Check if English IME
bool isEnglish = await _imePlugin.isEnglishIme();

// Force English input
await _imePlugin.forceEnglishInput();

// Restore original IME
await _imePlugin.restoreOriginalIme();
```

### Use with TextField

```dart
class EmailInput extends StatefulWidget {
  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  final _imePlugin = ForceEnglishIme();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _imePlugin.forceEnglishInput();
        } else {
          _imePlugin.restoreOriginalIme();
        }
      },
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Email',
          hintText: 'example@email.com',
        ),
      ),
    );
  }
}
```

## API Reference

### Methods

#### `Future<bool> isEnglishIme()`
Check if current IME is in English mode.

**Returns:** `true` if in English mode, `false` otherwise.

#### `Future<bool> forceEnglishInput()`
Force English input by completely disabling IME.

**Returns:** `true` if successful, `false` otherwise.

#### `Future<bool> restoreOriginalIme()`
Restore the original IME state.

**Returns:** `true` if successful, `false` otherwise.

## Use Cases

- 📧 Email input
- 👤 Username input
- 🔗 URL input
- 💻 Code editor
- 🔑 API key input
- And more...

## How It Works

This plugin uses Windows IMM (Input Method Manager) API:

- **`ImmAssociateContext(hwnd, NULL)`** - Completely disables IME
- **`ImmGetConversionStatus()`** - Detects input mode
- **`GetFocus()`** - Gets current focused control

When IME is disabled, users cannot switch input methods via any shortcuts (Shift, Ctrl+Space, etc.).

## Examples

Check out the [example](example/) directory for a complete demo app.

## Requirements

- Flutter SDK: ≥ 3.3.0
- Dart SDK: ≥ 3.10.4
- Windows 10 or higher recommended

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

Issues and Pull Requests are welcome!

## Links

- [pub.dev](https://pub.dev/packages/force_english_ime)
- [GitHub Repository](https://github.com/W2XiaoYu/force_english_ime)
- [Issue Tracker](https://github.com/W2XiaoYu/force_english_ime/issues)

---

Made with ❤️ for Flutter Community