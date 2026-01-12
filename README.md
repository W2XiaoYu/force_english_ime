# force_english_ime

一个用于 Windows 平台的 Flutter 插件，可以强制控制输入法状态，确保某些输入框只能使用英文输入。完全禁用 IME，防止用户通过快捷键（如 Shift、Ctrl+Space）切换输入法。

A Flutter plugin for Windows that allows you to force English input mode on specific text fields by controlling the Input Method Editor (IME) state. Completely disables IME to prevent users from switching input methods via shortcuts (like Shift, Ctrl+Space).

[![pub package](https://img.shields.io/badge/pub-0.0.1-blue)](https://pub.dev/packages/force_english_ime)
[![license](https://img.shields.io/badge/license-MIT-green)](LICENSE)

## ✨ 功能特性 / Features

- ✅ **完全禁用 IME** - 通过 `ImmAssociateContext` 完全禁用输入法，用户无法通过任何快捷键切换
- ✅ **自动状态管理** - 自动保存和恢复输入法状态
- ✅ **精确状态检测** - 使用 `ImmGetConversionStatus` 准确判断当前输入法模式
- ✅ **零依赖** - 仅使用 Windows IMM API，无额外依赖
- ✅ **易于集成** - 简单的 API，支持 Focus widget 自动控制

- ✅ **Complete IME Disable** - Uses `ImmAssociateContext` to completely disable IME, preventing any shortcut switching
- ✅ **Automatic State Management** - Automatically saves and restores IME state
- ✅ **Accurate Status Detection** - Uses `ImmGetConversionStatus` for precise input mode detection
- ✅ **Zero Dependencies** - Only uses Windows IMM API, no additional dependencies
- ✅ **Easy Integration** - Simple API with automatic Focus widget support

## 📱 平台支持 / Platform Support

| Platform | Support | Note |
|----------|---------|------|
| Windows  | ✅ | Fully supported |
| macOS    | ❌ | Not applicable |
| Linux    | ❌ | Not applicable |
| Android  | ❌ | Not applicable |
| iOS      | ❌ | Not applicable |

## 📦 安装 / Installation

在 `pubspec.yaml` 中添加依赖：

Add dependency in `pubspec.yaml`:

```yaml
dependencies:
  force_english_ime: ^0.0.1
```

然后运行 / Then run:

```bash
flutter pub get
```

## 🚀 快速开始 / Quick Start

### 基本使用 / Basic Usage

```dart
import 'package:force_english_ime/force_english_ime.dart';

final _imePlugin = ForceEnglishIme();

// 检查是否为英文输入法 / Check if English IME
bool isEnglish = await _imePlugin.isEnglishIme();
print('Is English mode: $isEnglish');

// 强制切换到英文输入法 / Force English input
await _imePlugin.forceEnglishInput();

// 恢复原始输入法 / Restore original IME
await _imePlugin.restoreOriginalIme();
```

### 在 TextField 中使用 / Use with TextField

最常见的使用场景是在需要英文输入的输入框中自动控制输入法：

The most common use case is to automatically control IME in text fields that require English input:

```dart
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _imePlugin = ForceEnglishIme();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
        controller: _emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
          hintText: 'example@email.com',
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
```

## 📖 使用案例 / Use Cases

### 案例 1：邮箱输入表单 / Case 1: Email Input Form

```dart
import 'package:flutter/material.dart';
import 'package:force_english_ime/force_english_ime.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _imePlugin = ForceEnglishIme();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                _imePlugin.forceEnglishInput();
              } else {
                _imePlugin.restoreOriginalIme();
              }
            },
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'your.email@example.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email submitted')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

### 案例 2：登录表单（用户名 + 密码）/ Case 2: Login Form (Username + Password)

```dart
import 'package:flutter/material.dart';
import 'package:force_english_ime/force_english_ime.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _imePlugin = ForceEnglishIme();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildEnglishOnlyField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    IconData? icon,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          _imePlugin.forceEnglishInput();
        } else {
          _imePlugin.restoreOriginalIme();
        }
      },
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEnglishOnlyField(
                controller: _usernameController,
                label: 'Username',
                hint: 'Enter your username',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildEnglishOnlyField(
                controller: _passwordController,
                label: 'Password',
                hint: 'Enter your password',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle login
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logging in...')),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 案例 3：URL/链接输入 / Case 3: URL/Link Input

```dart
import 'package:flutter/material.dart';
import 'package:force_english_ime/force_english_ime.dart';

class UrlInputWidget extends StatefulWidget {
  const UrlInputWidget({Key? key}) : super(key: key);

  @override
  State<UrlInputWidget> createState() => _UrlInputWidgetState();
}

class _UrlInputWidgetState extends State<UrlInputWidget> {
  final _imePlugin = ForceEnglishIme();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

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
        controller: _urlController,
        decoration: const InputDecoration(
          labelText: 'Website URL',
          hintText: 'https://example.com',
          prefixIcon: Icon(Icons.link),
          border: OutlineInputBorder(),
          helperText: 'Enter a valid URL starting with http:// or https://',
        ),
        keyboardType: TextInputType.url,
      ),
    );
  }
}
```

### 案例 4：创建可复用的 EnglishOnlyTextField 组件 / Case 4: Reusable EnglishOnlyTextField Component

```dart
import 'package:flutter/material.dart';
import 'package:force_english_ime/force_english_ime.dart';

/// 一个只允许英文输入的 TextField 组件
/// A TextField component that only allows English input
class EnglishOnlyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const EnglishOnlyTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<EnglishOnlyTextField> createState() => _EnglishOnlyTextFieldState();
}

class _EnglishOnlyTextFieldState extends State<EnglishOnlyTextField> {
  final _imePlugin = ForceEnglishIme();

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
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// 使用示例 / Usage example:
class MyPage extends StatelessWidget {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EnglishOnlyTextField(
      controller: _emailController,
      labelText: 'Email',
      hintText: 'your@email.com',
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || !value.contains('@')) {
          return 'Invalid email';
        }
        return null;
      },
    );
  }
}
```

### 案例 5：代码编辑器 / Case 5: Code Editor

```dart
import 'package:flutter/material.dart';
import 'package:force_english_ime/force_english_ime.dart';

class CodeEditorWidget extends StatefulWidget {
  const CodeEditorWidget({Key? key}) : super(key: key);

  @override
  State<CodeEditorWidget> createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<CodeEditorWidget> {
  final _imePlugin = ForceEnglishIme();
  final _codeController = TextEditingController(
    text: '// Enter your code here\nvoid main() {\n  print("Hello World");\n}',
  );

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey[200],
          child: Row(
            children: [
              const Icon(Icons.code),
              const SizedBox(width: 8),
              const Text('Code Editor', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                _imePlugin.forceEnglishInput();
              } else {
                _imePlugin.restoreOriginalIme();
              }
            },
            child: TextField(
              controller: _codeController,
              maxLines: null,
              expands: true,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

## 🔧 API 文档 / API Reference

### ForceEnglishIme 类 / Class

主要的插件类，提供输入法控制功能。

Main plugin class providing IME control functionality.

#### 方法 / Methods

##### `Future<bool> isEnglishIme()`

检查当前输入法是否为英文模式（字母数字模式）。

Check if the current input method is in English mode (alphanumeric mode).

**返回值 / Returns:**
- `true` - 当前为英文模式 / Currently in English mode
- `false` - 当前为中文/IME 模式 / Currently in Chinese/IME mode

**示例 / Example:**
```dart
final isEnglish = await ForceEnglishIme().isEnglishIme();
if (isEnglish) {
  print('Already in English mode');
}
```

##### `Future<bool> forceEnglishInput()`

强制切换到英文输入模式，通过完全禁用 IME 实现。

Force switch to English input mode by completely disabling IME.

**功能 / Features:**
- 获取当前焦点控件 / Gets currently focused control
- 保存当前 IME 上下文 / Saves current IME context
- 禁用 IME（用户无法通过快捷键切换）/ Disables IME (users cannot switch via shortcuts)

**返回值 / Returns:**
- `true` - 成功禁用 IME / Successfully disabled IME
- `false` - 失败（通常是因为没有焦点控件）/ Failed (usually because no focused control)

**示例 / Example:**
```dart
final success = await ForceEnglishIme().forceEnglishInput();
if (success) {
  print('IME disabled, English input mode activated');
}
```

##### `Future<bool> restoreOriginalIme()`

恢复调用 `forceEnglishInput()` 之前保存的 IME 状态。

Restore the IME state that was saved before calling `forceEnglishInput()`.

**返回值 / Returns:**
- `true` - 成功恢复 / Successfully restored
- `false` - 失败 / Failed

**示例 / Example:**
```dart
await ForceEnglishIme().restoreOriginalIme();
print('Original IME restored');
```

##### `Future<String?> getPlatformVersion()`

获取平台版本信息（用于调试）。

Get platform version information (for debugging).

**返回值 / Returns:**
- Windows 版本字符串，例如 "Windows 10+" / Windows version string, e.g., "Windows 10+"

## ⚙️ 工作原理 / How It Works

### 技术实现 / Technical Implementation

该插件使用 Windows IMM (Input Method Manager) API 来控制输入法：

This plugin uses Windows IMM (Input Method Manager) API to control the IME:

#### 核心 API / Core APIs

1. **`ImmAssociateContext(hwnd, NULL)`** - 完全禁用 IME
   - 将窗口的 IME 上下文设置为 NULL
   - 用户无法通过任何快捷键（Shift、Ctrl+Space 等）切换输入法
   - Completely disables IME by setting window's IME context to NULL
   - Users cannot switch input methods via any shortcuts

2. **`ImmGetConversionStatus()`** - 获取输入法转换状态
   - 检查 `IME_CMODE_ALPHANUMERIC` 标志位
   - 准确判断当前是否为英文模式
   - Checks `IME_CMODE_ALPHANUMERIC` flag
   - Accurately determines if currently in English mode

3. **`GetFocus()`** - 获取当前焦点控件
   - 而不是使用整个窗口句柄
   - 确保只影响当前输入框
   - Instead of using the entire window handle
   - Ensures only affects current input field

### 状态管理流程 / State Management Flow

```
用户点击输入框 (User clicks input field)
        ↓
    获得焦点 (Gains focus)
        ↓
Focus.onFocusChange(true)
        ↓
forceEnglishInput()
        ↓
保存当前 IME 上下文 (Save current IME context)
        ↓
禁用 IME (Disable IME)
        ↓
用户只能输入英文 (User can only input English)
用户按 Shift 无效 (User presses Shift - no effect)
        ↓
用户离开输入框 (User leaves input field)
        ↓
    失去焦点 (Loses focus)
        ↓
Focus.onFocusChange(false)
        ↓
restoreOriginalIme()
        ↓
恢复原 IME 上下文 (Restore original IME context)
        ↓
用户可以正常使用中文输入 (User can use Chinese input normally)
```

## 🎯 使用场景 / Use Cases

| 场景 / Scenario | 说明 / Description |
|----------------|-------------------|
| 📧 邮箱输入 / Email Input | 确保邮箱地址格式正确，不包含中文字符 / Ensure email format is correct without Chinese characters |
| 👤 用户名输入 / Username Input | 用户名通常只允许英文字母和数字 / Usernames typically only allow English letters and numbers |
| 🔗 URL 输入 / URL Input | 网址必须是英文字符 / URLs must be English characters |
| 💻 代码编辑 / Code Editing | 代码编写需要英文环境 / Code writing requires English environment |
| 🔑 API Key 输入 / API Key Input | API 密钥通常是英文字符 / API keys are typically English characters |
| 📱 手机号验证 / Phone Verification | 国际手机号格式 / International phone number format |
| 🏦 银行卡号 / Bank Card Number | 银行卡号只包含数字 / Bank card numbers only contain digits |
| 🎫 优惠码输入 / Coupon Code Input | 优惠码通常是英文和数字组合 / Coupon codes are typically English and numbers |

## ⚠️ 注意事项 / Important Notes

### 系统要求 / System Requirements

1. **平台限制 / Platform Limitation**
   - ✅ 仅支持 Windows 平台 / Only supports Windows platform
   - ❌ macOS、Linux、Android、iOS 不适用 / Not applicable for macOS, Linux, Android, iOS

2. **版本要求 / Version Requirements**
   - Flutter SDK: ≥ 3.3.0
   - Dart SDK: ≥ 3.10.4
   - Windows 10 或更高版本推荐 / Windows 10 or higher recommended

### 最佳实践 / Best Practices

1. **始终成对使用 / Always Use in Pairs**
   ```dart
   // ✅ 正确 / Correct
   Focus(
     onFocusChange: (hasFocus) {
       if (hasFocus) {
         _imePlugin.forceEnglishInput();  // 获得焦点时禁用 / Disable on focus
       } else {
         _imePlugin.restoreOriginalIme(); // 失去焦点时恢复 / Restore on blur
       }
     },
     child: TextField(...),
   )

   // ❌ 错误：没有恢复 / Wrong: No restore
   Focus(
     onFocusChange: (hasFocus) {
       if (hasFocus) {
         _imePlugin.forceEnglishInput();
       }
       // 缺少 else 分支！/ Missing else branch!
     },
     child: TextField(...),
   )
   ```

2. **处理异常 / Handle Exceptions**
   ```dart
   try {
     await _imePlugin.forceEnglishInput();
   } catch (e) {
     print('Failed to disable IME: $e');
     // 可以选择显示错误提示 / Optionally show error message
   }
   ```

3. **资源清理 / Resource Cleanup**
   ```dart
   @override
   void dispose() {
     // 确保在页面销毁时恢复 IME / Ensure IME is restored when page is disposed
     _imePlugin.restoreOriginalIme();
     super.dispose();
   }
   ```

## 🐛 故障排除 / Troubleshooting

### 常见问题 / Common Issues

**Q1: 调用 `forceEnglishInput()` 后仍然可以输入中文？**
**Q1: Can still input Chinese after calling `forceEnglishInput()`?**

A: 检查以下几点 / Check the following:
- 确保在获得焦点后调用 / Ensure called after gaining focus
- 确认没有其他代码恢复了 IME / Confirm no other code restored IME
- 尝试重启应用 / Try restarting the app

**Q2: 离开输入框后输入法没有恢复？**
**Q2: IME not restored after leaving the input field?**

A: 确保在 `onFocusChange(false)` 时调用了 `restoreOriginalIme()` / Ensure `restoreOriginalIme()` is called in `onFocusChange(false)`

**Q3: 编译错误 "找不到 imm32.lib"？**
**Q3: Build error "cannot find imm32.lib"?**

A: 这个库是 Windows SDK 的一部分，确保安装了完整的 Visual Studio 和 Windows SDK / This library is part of Windows SDK, ensure Visual Studio and Windows SDK are fully installed

## 📝 更新日志 / Changelog

### 0.0.1 (2024-01-12)

- ✨ 初始版本发布 / Initial release
- ✅ 支持强制英文输入模式 / Support force English input mode
- ✅ 支持自动恢复原输入法 / Support automatic IME restoration
- ✅ 使用 `ImmAssociateContext` 完全禁用 IME / Use `ImmAssociateContext` to completely disable IME
- ✅ 准确的输入法状态检测 / Accurate IME status detection

## 📄 许可证 / License

MIT License

Copyright (c) 2024

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 🤝 贡献 / Contributing

欢迎提交 Issues 和 Pull Requests！

Issues and Pull Requests are welcome!

### 如何贡献 / How to Contribute

1. Fork 本仓库 / Fork this repository
2. 创建您的特性分支 / Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 / Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 / Push to the branch (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request / Open a Pull Request

## 📧 联系方式 / Contact

如有问题或建议，请通过以下方式联系：

For questions or suggestions, please contact via:

- 提交 Issue / Submit an Issue: [GitHub Issues](https://github.com/yourusername/force_english_ime/issues)
- Email: your.email@example.com

## 🙏 致谢 / Acknowledgments

- 感谢 Windows IMM API 文档 / Thanks to Windows IMM API documentation
- 感谢所有贡献者 / Thanks to all contributors
- 灵感来源于实际开发中的需求 / Inspired by real-world development needs

---

Made with ❤️ by Flutter Community
