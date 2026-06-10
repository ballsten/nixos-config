# enable gtk theme
{ ... }:
{
  gtk = {
    enable = true;
    # TODO: remove due to stylix
    # colorScheme = "dark";
    # TODO: removing due to error in latest update
    # gtk4.theme = null;
  };
}
