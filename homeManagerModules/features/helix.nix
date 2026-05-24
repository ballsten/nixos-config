# Helix configuration
{
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        auto-format = true;
        end-of-line-diagnostics = "hint";
        bufferline = "multiple";

        lsp = {
          enable = true;
          display-messages = true;
        };
        inline-diagnostics.cursor-line = "warning";
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "nixfmt";
      }
    ];
  };
}
