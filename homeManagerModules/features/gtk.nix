# enable gtk theme
{ ... }:
{
  gtk = {
    enable = true;
    # NOTE: remove due to stylix
    # colorScheme = "dark";
    gtk4.theme = null;
  };
}
