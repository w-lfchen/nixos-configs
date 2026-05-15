{ config, lib, ... }:
let
  cfg = config.hardware.nvidia;
in
{
  # mirror the nixos module api
  options.hardware.nvidia.enable = lib.mkEnableOption "nvidia";

  config = lib.mkIf cfg.enable { };
}
