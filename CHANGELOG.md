# Changelog / 更新日志

All notable changes to this project will be documented in this file.

本文件记录了此项目的所有重要更改。

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2] - 2026-01-12

### Fixed / 修复

- 📝 Fixed LICENSE file containing generic TODO placeholder / 修复 LICENSE 文件包含 TODO 占位符的问题
- ✅ Added complete MIT License text / 添加完整的 MIT License 文本

### Changed / 变更

- 📖 Split README into separate English and Chinese versions / 将 README 拆分为独立的英文版和中文版
- 🎯 Simplified documentation for better readability / 简化文档以提高可读性
- 🔗 Added mutual links between English and Chinese documentation / 在中英文文档之间添加相互链接
- 📚 Moved detailed examples to example/ directory reference / 将详细示例移至 example/ 目录引用

### Documentation / 文档

- README.md - Concise English version / 简洁的英文版本
- README_CN.md - Concise Chinese version / 简洁的中文版本
- Both versions include quick start guide and core API reference / 两个版本都包含快速开始指南和核心 API 参考

## [0.0.1] - 2026-01-12

### Added / 新增

- ✨ Initial release of force_english_ime plugin / force_english_ime 插件首次发布
- ✅ Support for forcing English input mode on Windows / 支持在 Windows 上强制英文输入模式
- ✅ Automatic IME state save and restore functionality / 自动保存和恢复输入法状态功能
- ✅ Complete IME disable using `ImmAssociateContext(hwnd, NULL)` / 使用 `ImmAssociateContext(hwnd, NULL)` 完全禁用 IME
- ✅ Accurate IME status detection using `ImmGetConversionStatus` / 使用 `ImmGetConversionStatus` 准确检测输入法状态
- ✅ Focus widget integration for automatic control / Focus widget 集成实现自动控制
- 📖 Comprehensive documentation with Chinese and English / 完整的中英文文档
- 📝 Multiple use case examples (email, login, URL, code editor) / 多个使用案例（邮箱、登录、URL、代码编辑器）

### Features / 功能特性

- **`forceEnglishInput()`** - Force English input by completely disabling IME / 通过完全禁用 IME 强制英文输入
- **`restoreOriginalIme()`** - Restore original IME state / 恢复原始输入法状态
- **`isEnglishIme()`** - Check if current IME is in English mode / 检查当前输入法是否为英文模式
- **`getPlatformVersion()`** - Get Windows platform version / 获取 Windows 平台版本

### Technical Implementation / 技术实现

- Uses Windows IMM (Input Method Manager) API / 使用 Windows IMM（输入法管理器）API
- Prevents IME switching via keyboard shortcuts (Shift, Ctrl+Space, etc.) / 防止通过键盘快捷键切换输入法
- Supports per-control IME management / 支持按控件管理输入法
- Zero external dependencies / 零外部依赖

### Platform Support / 平台支持

- ✅ Windows 10 and above / Windows 10 及以上版本
- ✅ Windows 8 / Windows 8
- ✅ Windows 7 / Windows 7

### Documentation / 文档

- Complete README with installation guide / 完整的 README 和安装指南
- 5 practical use cases / 5 个实用案例
- API reference documentation / API 参考文档
- Troubleshooting guide / 故障排除指南
- Best practices / 最佳实践

[0.0.2]: https://github.com/W2XiaoYu/force_english_ime/releases/tag/v0.0.2
[0.0.1]: https://github.com/W2XiaoYu/force_english_ime/releases/tag/v0.0.1