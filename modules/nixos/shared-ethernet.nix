# module to add networkmanager connections for configuring ethernet interfaces
# they either share their connection or be in the default auto mode
# they are named "<interface-name>-auto" and "<interface-name>-shared"
# currently, no uuids are set for the connections.
{ config, lib, ... }:
let
  cfg = config.networking.shared-ethernet;
in
{
  options.networking.shared-ethernet = {
    enable = lib.mkEnableOption "interface generation";
    interfaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        List of interfaces to generate connections for.
      '';
      example = [
        "eth0"
        "eth1"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.ensureProfiles.profiles = lib.mergeAttrsList (
        builtins.map (
          iname:
          let
            auto-string = iname + "-auto";
            shared-string = iname + "-shared";
          in
          {
            ${auto-string} = {
              connection = {
                id = auto-string;
                autoconnect-priority = 0;
                interface-name = iname;
                type = "ethernet";
                uuid = lib.stringToUuidv5 auto-string;
              };
              ipv4.method = "auto";
              ipv6 = {
                addr-gen-mode = "default";
                method = "auto";
              };
            };
            ${shared-string} = {
              connection = {
                id = shared-string;
                autoconnect-priority = 0;
                interface-name = iname;
                type = "ethernet";
                uuid = lib.stringToUuidv5 shared-string;
              };
              ipv4.method = "shared";
              ipv6 = {
                addr-gen-mode = "default";
                method = "shared";
              };
            };
          }
        ) cfg.interfaces
      );
      # shared wired connection requires dhcp and dns, so the respective ports must be opened
      firewall.interfaces = lib.genAttrs cfg.interfaces (iname: {
        allowedUDPPorts = [
          53
          67
        ];
      });
    };
  };
}
