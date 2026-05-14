{
  config,
  inputs,
  pkgs,
  ...
}:
{
  # helix
  catppuccin.helix = {
    enable = true;
    useItalics = true;
  };
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };

  # nvim
  catppuccin.nvim.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
  };

  # vscode
  nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
  programs.vscodium = {
    enable = true;
    # extensions are allowed to be updated, this should allow this
    # note that this sadly causes eval to take longer, even if only whitespace is adjusted for some reason
    # TODO: test whether this works correctly, if not, set to false
    mutableExtensionsDir = true;
    package = pkgs.vscodium;
    profiles.default = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-marketplace; [
        bradlc.vscode-tailwindcss
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        eww-yuck.yuck
        james-yu.latex-workshop
        jnoortheen.nix-ide
        kdl-org.kdl
        leonardssh.vscord
        ms-vscode.hexeditor
        myriad-dreamin.tinymist
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
      ];
      # https://github.com/microsoft/vscode/issues/188624#issuecomment-1652888196
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.fontFamily" =
          "'FiraCode Nerd Font Mono', 'Material Symbols Rounded', 'monospace', monospace";
        "editor.fontLigatures" = true;
        "editor.renderWhitespace" = "all";
        "hexeditor.columnWidth" = 16;
        "hexeditor.defaultEndianness" = "little";
        "hexeditor.inspectorType" = "aside";
        "hexeditor.showDecodedText" = true;
        "latex-workshop.latex.tools" = [
          {
            name = "latexmk";
            command = "latexmk";
            args = [
              "--shell-escape"
              "-synctex=1"
              "-interaction=nonstopmode"
              "-file-line-error"
              "-lualatex"
              #"-pdflatex"
              "-outdir=%OUTDIR%"
              "%DOC%"
            ];
          }
        ];
        "latex-workshop.latexindent.args" = [
          "-c"
          "%DIR%/"
          "%TMPFILE%"
          "-l"
          "-y=defaultIndent: '%INDENT%'"
        ];
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings".nil.formatting.command = [ "nixfmt" ];
        "tinymist.formatterMode" = "typstyle";
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";

        # language settings
        # tinymist (i think it's the culprit) kept wanting to add these
        "[typst]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
        "[typst-code]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
      };
    };
  };

  # zed
  # added through system packages, link config file
  # currently not using the hm module since i'd like the config to be mutable for now and it's mutable options seem weird
  xdg.configFile."zed".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-configs/config/zed-editor";

  # lsps/formatters
  home.packages = with pkgs; [
    tinymist
    typst
  ];
}
