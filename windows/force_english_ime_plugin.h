#ifndef FLUTTER_PLUGIN_FORCE_ENGLISH_IME_PLUGIN_H_
#define FLUTTER_PLUGIN_FORCE_ENGLISH_IME_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace force_english_ime {

class ForceEnglishImePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ForceEnglishImePlugin(HWND window);

  virtual ~ForceEnglishImePlugin();

  // Disallow copy and assign.
  ForceEnglishImePlugin(const ForceEnglishImePlugin&) = delete;
  ForceEnglishImePlugin& operator=(const ForceEnglishImePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

 private:
  // IME control methods
  bool IsEnglishIme();
  bool ForceEnglishInput();
  bool RestoreOriginalIme();

  // Store the Flutter window handle
  HWND flutter_window_;

  // Store the original IME context
  HIMC saved_imc_ = NULL;
  bool ime_disabled_ = false;
};

}  // namespace force_english_ime

#endif  // FLUTTER_PLUGIN_FORCE_ENGLISH_IME_PLUGIN_H_
