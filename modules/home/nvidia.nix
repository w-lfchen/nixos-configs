# hm module for nvidia on hyprland
_: {
  wayland.windowManager.hyprland.settings = {
    cursor.no_hardware_cursors = true;
    # librewolf freezing could be an issue, see https://github.com/hyprwm/Hyprland/issues/7327
    # see https://github.com/hyprwm/Hyprland/issues/4857
    # issues to keep in mind: https://github.com/hyprwm/Hyprland/issues/7560 https://github.com/hyprwm/Hyprland/issues/7205
    render = {
      explicit_sync = 1;
      explicit_sync_kms = 1;
      direct_scanout = false;
    };
    # fixes
    # https://github.com/Rdeisenroth/dotfiles/blob/c3c02c9ee95d99883dfe09c5fb64195abae89a6f/dot_config/hypr/environment.conf
    # thank you ruben for making the nvidia wayland journey a bit less painful <3
    env = [
      # Nvidia
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"

      "NVD_BACKEND,direct"

      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      # tearing
      "WLR_DRM_NO_ATOMIC,1"
      "__GL_GSYNC_ALLOWED,1"
      "__GL_VRR_ALLOWED,1"
      # qt
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORMTHEME,qt5ct:qt6ct"
      # Firefox Hardware accelleration stuff
      "MOZ_DISABLE_RDD_SANDBOX, 1"
      "EGL_PLATFORM, wayland"
      "MOZ_ENABLE_WAYLAND, 1"
      # java
      "_JAVA_AWT_WM_NONEREPARENTING,1"
      # other
      "CLUTTER_BACKEND,wayland"
      "GTK_USE_PORTAL,1"
    ];
  };
}
