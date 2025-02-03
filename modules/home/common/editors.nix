{ inputs, pkgs, ... }:
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
  };

  # vscode
  nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;
    extensions = with pkgs.vscode-marketplace; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      dbaeumer.vscode-eslint
      dsvictor94.promela
      eww-yuck.yuck
      esbenp.prettier-vscode
      haskell.haskell
      james-yu.latex-workshop
      jnoortheen.nix-ide
      justusadam.language-haskell
      leonardssh.vscord
      marp-team.marp-vscode
      ms-vscode.hexeditor
      myriad-dreamin.tinymist
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      yoavbls.pretty-ts-errors
    ];
    # this module should be removed imo, it's completely outdated and superseded
    # refer to general vscode config/extensions for haskell setup
    haskell.enable = false;
    # extensions are allowed to be updated, this should allow this
    # note that this sadly causes eval to take longer, even if only whitespace is adjusted for some reason
    # TODO: test whether this works correctly, if not, set to false
    mutableExtensionsDir = true;
    package = pkgs.vscodium;
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
      "[typst]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
    };
  };

  # lsps/formatters
  home.packages = with pkgs; [
    tinymist
    typst
  ];
}
