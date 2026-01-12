#include "force_english_ime_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>
#include <imm.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

#pragma comment(lib, "imm32.lib")

namespace force_english_ime {

// static
void ForceEnglishImePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "force_english_ime",
          &flutter::StandardMethodCodec::GetInstance());

  // Get the Flutter window handle
  HWND window = registrar->GetView()->GetNativeWindow();
  auto plugin = std::make_unique<ForceEnglishImePlugin>(window);

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

ForceEnglishImePlugin::ForceEnglishImePlugin(HWND window)
    : flutter_window_(window) {}

ForceEnglishImePlugin::~ForceEnglishImePlugin() {}

void ForceEnglishImePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success(flutter::EncodableValue(version_stream.str()));
  } else if (method_call.method_name().compare("isEnglishIme") == 0) {
    bool is_english = IsEnglishIme();
    result->Success(flutter::EncodableValue(is_english));
  } else if (method_call.method_name().compare("forceEnglishInput") == 0) {
    bool success = ForceEnglishInput();
    result->Success(flutter::EncodableValue(success));
  } else if (method_call.method_name().compare("restoreOriginalIme") == 0) {
    bool success = RestoreOriginalIme();
    result->Success(flutter::EncodableValue(success));
  } else {
    result->NotImplemented();
  }
}

// Check if the current IME is in English mode (alphanumeric mode)
bool ForceEnglishImePlugin::IsEnglishIme() {
  // If we disabled IME completely, it's in English mode
  if (ime_disabled_) {
    return true;
  }

  HWND hwnd = GetForegroundWindow();
  if (hwnd == NULL) {
    return true; // Default to true if no window
  }

  HIMC imc = ImmGetContext(hwnd);
  if (imc == NULL) {
    return true; // No IME context means English mode
  }

  DWORD conversion = 0;
  DWORD sentence = 0;

  if (!ImmGetConversionStatus(imc, &conversion, &sentence)) {
    ImmReleaseContext(hwnd, imc);
    return true; // Failed to get status, assume English
  }

  ImmReleaseContext(hwnd, imc);

  // Check if in alphanumeric mode (English)
  return (conversion & IME_CMODE_ALPHANUMERIC) != 0;
}

// Force the input to English mode by disabling IME completely
bool ForceEnglishImePlugin::ForceEnglishInput() {
  // Get the currently focused window/control
  HWND hwnd = GetFocus();
  if (hwnd == NULL) {
    return false;
  }

  // If already disabled on a different window, restore first
  if (ime_disabled_) {
    if (saved_imc_ != NULL && IsWindow(flutter_window_)) {
      ImmAssociateContext(flutter_window_, saved_imc_);
    }
    saved_imc_ = NULL;
    flutter_window_ = NULL;
    ime_disabled_ = false;
  }

  // Disable IME by associating NULL context
  // This prevents user from switching IME with Shift or any other shortcuts
  saved_imc_ = ImmAssociateContext(hwnd, NULL);
  ime_disabled_ = true;
  flutter_window_ = hwnd;

  return true;
}

// Restore the original IME context
bool ForceEnglishImePlugin::RestoreOriginalIme() {
  if (ime_disabled_ && IsWindow(flutter_window_) && saved_imc_ != NULL) {
    ImmAssociateContext(flutter_window_, saved_imc_);

    ime_disabled_ = false;
    flutter_window_ = NULL;
    saved_imc_ = NULL;
    return true;
  }

  // Clean up state even if restoration fails
  if (ime_disabled_) {
    ime_disabled_ = false;
    flutter_window_ = NULL;
    saved_imc_ = NULL;
  }

  return true;
}

}  // namespace force_english_ime
