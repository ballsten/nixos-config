# greetd feature to enable a login screen using regreet
{
  ...
}:
{
  programs.regreet = {
    enable = true;
    cageArgs = [
      "-m"
      "last"
    ];
  };

}
