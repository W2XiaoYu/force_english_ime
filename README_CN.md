# force_english_ime

[![pub package](https://img.shields.io/badge/pub-0.0.1-blue)](https://pub.dev/packages/force_english_ime)
[![license](https://img.shields.io/badge/license-MIT-green)](LICENSE)

[English Documentation](README.md)

一个用于 Windows 平台的 Flutter 插件，可以强制控制输入法状态，确保某些输入框只能使用英文输入。完全禁用 IME，防止用户通过快捷键（如 Shift、Ctrl+Space）切换输入法。

## 功能特性

- ✅ **完全禁用 IME** - 通过 `ImmAssociateContext` 完全禁用输入法
- ✅ **自动状态管理** - 自动保存和恢复输入法状态
- ✅ **精确检测** - 使用 `ImmGetConversionStatus` 准确判断输入法模式
- ✅ **零依赖** - 仅使用 Windows IMM API
- ✅ **易于集成** - 简单的 API，支持 Focus widget 自动控制

## 平台支持

| 平台     | 支持 |
|---------|------|
| Windows | ✅   |
| macOS   | ❌   |
| Linux   | ❌   |
| Android | ❌   |
| iOS     | ❌   |

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  force_english_ime: ^0.0.1
```

然后运行：

```bash
flutter pub get
```

## 快速开始

### 基本使用

```dart
import 'package:force_english_ime/force_english_ime.dart';

final _imePlugin = ForceEnglishIme();

// 检查是否为英文输入法
bool isEnglish = await _imePlugin.isEnglishIme();

// 强制切换到英文输入法
await _imePlugin.forceEnglishInput();

// 恢复原始输入法
await _imePlugin.restoreOriginalIme();
```

### 在 TextField 中使用

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

## API 文档

### 方法

#### `Future<bool> isEnglishIme()`
检查当前输入法是否为英文模式。

**返回值：** `true` 表示英文模式，`false` 表示中文/IME 模式。

#### `Future<bool> forceEnglishInput()`
通过完全禁用 IME 强制英文输入。

**返回值：** `true` 表示成功，`false` 表示失败。

#### `Future<bool> restoreOriginalIme()`
恢复原始输入法状态。

**返回值：** `true` 表示成功，`false` 表示失败。

## 使用场景

- 📧 邮箱地址输入
- 👤 用户名输入
- 🔗 URL 输入
- 💻 代码编辑器
- 🔑 API 密钥输入
- 更多场景...

## 工作原理

该插件使用 Windows IMM (Input Method Manager) API：

- **`ImmAssociateContext(hwnd, NULL)`** - 完全禁用 IME
- **`ImmGetConversionStatus()`** - 检测输入模式
- **`GetFocus()`** - 获取当前焦点控件

当 IME 被禁用时，用户无法通过任何快捷键（Shift、Ctrl+Space 等）切换输入法。

## 示例

查看 [example](example/) 目录以获取完整的演示应用。

## 系统要求

- Flutter SDK: ≥ 3.3.0
- Dart SDK: ≥ 3.10.4
- 推荐 Windows 10 或更高版本

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件。

## 贡献

欢迎提交 Issues 和 Pull Requests！

## 链接

- [pub.dev](https://pub.dev/packages/force_english_ime)
- [GitHub 仓库](https://github.com/W2XiaoYu/force_english_ime)
- [问题跟踪](https://github.com/W2XiaoYu/force_english_ime/issues)

---

Made with ❤️ for Flutter Community