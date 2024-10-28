_: {
  # not really happy with this but it's enough for now.
  # maybe use rofi or eww instead
  programs.wlogout = {
    enable = true;
    layout = [
      {
        action = "systemctl poweroff";
        keybind = "h";
        label = "shutdown";
        text = "";
      }
      {
        action = "systemctl reboot";
        keybind = "r";
        label = "reboot";
        text = "";
      }
      {
        action = "systemctl suspend";
        keybind = "u";
        label = "suspend";
        text = "";
      }
    ];
    style = ''
      * {
        background-image: none;
        box-shadow: none;
        font-size: 100px;
        font-family: FiraCode Nerd Font Propo;
      }

      window {
        background-color: rgba(17, 17, 27, 0.8);
      }

      button {
        background-color: #313244;
        margin: 50px;
        margin-left: 600px;
        margin-right: 600px;
        text-decoration-color: #cdd6f4;
        color: #cdd6f4;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active {
        background-color: #45475a;
      }
    '';
  };
}
