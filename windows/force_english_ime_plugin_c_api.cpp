#include "include/force_english_ime/force_english_ime_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "force_english_ime_plugin.h"

void ForceEnglishImePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  force_english_ime::ForceEnglishImePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
