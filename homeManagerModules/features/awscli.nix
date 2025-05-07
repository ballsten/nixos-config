##
# Aws CLI configuration
##
{
  ...
}:
{
  programs.awscli = {
    enable = true;
    settings = {
      "profile default" = {
        "sso_session" = "ballsten-sso";
        "sso_account_id" = 235711458550;
        "sso_role_name" = "PowerUserAccess";
        "region" = "us-east-2";
      };
      "sso-session ballsten-sso" = {
        "sso_start_url" = "https://ballsten.awsapps.com/start/#";
        "sso_region" = "us-east-2";
        "sso_registration_scope" = "sso:account:access";
      };
    };
  };
}
