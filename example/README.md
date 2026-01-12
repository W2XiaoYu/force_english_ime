# force_english_ime Example

This example demonstrates how to use the `force_english_ime` plugin to control input methods in Flutter text fields on Windows.

## What This Example Shows

The example app demonstrates forcing English input mode for specific text fields:

- **Email Field**: Forces English input when focused, restores original IME when unfocused
- **Username Field**: Same behavior as email field
- **URL Field**: Forces English input for URL entry
- **Status Display**: Shows current IME status (English/Chinese)
- **Manual Control**: Buttons to manually force English or restore IME

## Running the Example

1. Make sure you're on Windows
2. Run the example:
   ```bash
   flutter run -d windows
   ```

## Key Features Demonstrated

### Automatic IME Control with Focus

```dart
Focus(
  onFocusChange: (hasFocus) {
    if (hasFocus) {
      _imePlugin.forceEnglishInput();
    } else {
      _imePlugin.restoreOriginalIme();
    }
  },
  child: TextField(
    decoration: InputDecoration(labelText: 'Email'),
  ),
)
```

### Manual IME Control

```dart
// Force English input
await _imePlugin.forceEnglishInput();

// Restore original IME
await _imePlugin.restoreOriginalIme();

// Check IME status
bool isEnglish = await _imePlugin.isEnglishIme();
```

## Use Cases

This example shows practical use cases where English-only input is desired:
- Email addresses
- Usernames
- URLs
- API keys
- Code snippets

For more information, see the [main package documentation](https://pub.dev/packages/force_english_ime).