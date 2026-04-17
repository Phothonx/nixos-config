# Extentions : Check about:support for extension/add-on ID strings.
# Policies : Check about:policies#documentation for options. https://mozilla.github.io/policy-templates/
# Preferences : Check about:config for options.
# https://ryantm.github.io/nixpkgs/builders/packages/firefox/
# https://github.com/yokoffing/Betterfox
{...}: {
  perSystem = {pkgs, ...}: {
    packages.firefox = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPoliciesFiles = [(pkgs.writeText "custom-policies.json" (builtins.readFile ./policies.json))];
      extraPrefsFiles = [(pkgs.writeText "custom-prefs.js" (builtins.readFile ./user.js))];
    };
  };
}
