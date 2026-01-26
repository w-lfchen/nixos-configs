{ pkgs, ... }:
{
  /*
    # when added, this creates 2 systemd services, openconnect-tuda-{campus, extern}, which can be enabled as needed in order to get a vpn connection
    networking.openconnect.interfaces =
      lib.genAttrs
        [
          "tuda-campus"
          "tuda-extern"
        ]
        (n: {
          autoStart = false;
          gateway = "vpn.hrz.tu-darmstadt.de";
          passwordFile = <path to password file>;
          protocol = "anyconnect";
          user = "<tu-id>";
          extraOptions.authgroup = lib.strings.removePrefix "tuda-" n;
        });
  */
  # it would be nice if user and (auth)group could be supplied automatically
  # i sadly couldn't get this to work
  # passing just 2 of the 3 needed secrets (group, user, password) to openconnect when invoking it directly worked just fine
  # i couldn't get this to work when using networkmanager, but doing it through networkmanager is probably better
  # just run `nmcli c tuda-vpn up -a` in order to enable vpn (requires logging in)
  networking.networkmanager = {
    ensureProfiles.profiles = {
      "tuda-vpn" = {
        connection = {
          autoconnect = "false";
          id = "tuda-vpn";
          type = "vpn";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };
        vpn = {
          authtype = "password";
          autoconnect-flags = "0";
          certsigs-flags = "0";
          cookie-flags = "2";
          disable_udp = "no";
          enable_csd_trojan = "no";
          gateway = "vpn.hrz.tu-darmstadt.de";
          gateway-flags = "2";
          gwcert-flags = "2";
          lasthost-flags = "0";
          pem_passphrase_fsid = "no";
          prevent_invalid_cert = "no";
          protocol = "anyconnect";
          resolve-flags = "2";
          service-type = "org.freedesktop.NetworkManager.openconnect";
          stoken_source = "disabled";
          xmlconfig-flags = "0";
          password-flags = 0;
        };
        # this might be relevant, but didn't work
        # vpn-secrets = {
        #   "form:main:group_list" = "campus";
        #   "form:main:username" = "<tu-id>";
        #   lasthost = "vpn.hrz.tu-darmstadt.de";
        #   save_passwords = "yes";
        # };
      };
    };
    plugins = with pkgs; [ networkmanager-openconnect ];
  };
}
