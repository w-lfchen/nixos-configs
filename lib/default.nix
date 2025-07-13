{ lib, ... }:
rec {
  # a basic function to transform a directory to a set to access paths through set element access
  # for an example, see how the flake handles the `modules` directory
  # file endings are removed as they interfere with set access
  dirToSet = path: (lib.mapAttrs' (resolveDir path) (builtins.readDir path));

  # helper function for `dirToSet` to transform the attrset produced by `builtins.readDir`
  resolveDir =
    path: name: value:
    if value == "directory" then
      # recurse by calling dirToSet, adding the path to the name, recursing in the directory structure as well
      {
        inherit name;
        value = dirToSet (path + ("/" + name));
      }
    else if value == "regular" then
      # files stop recursion
      # as long as infinite nesting of directories is impossible, the recursion will never be infinite
      # removes the file ending by simply truncating everything after the first `.`
      {
        name = builtins.head (lib.splitString "." name);
        value = (path + ("/" + name));
      }
    else
      # currently not my use case so i didn't bother implementing this, sorry
      builtins.throw "dirTreeToSet doesn't support symlinks";
  # see https://github.com/NixOS/nixpkgs/blob/e56e0beed4312a89b60fe312ee2241f7a1627f76/lib/trivial.nix#L1141
  hexStringToBinString =
    let
      binDigits = {
        "0" = "0000";
        "1" = "0001";
        "2" = "0010";
        "3" = "0011";
        "4" = "0100";
        "5" = "0101";
        "6" = "0110";
        "7" = "0111";
        "8" = "1000";
        "9" = "1001";
        "a" = "1010";
        "b" = "1011";
        "c" = "1100";
        "d" = "1101";
        "e" = "1110";
        "f" = "1111";
      };
      toBinDigit = d: binDigits.${lib.toLower (builtins.toString d)};
    in
    i: lib.concatMapStrings toBinDigit (lib.stringToCharacters i);
  # expects the input string to be binary, will pad and uphold any padding
  binStringToHexString =
    let
      hexDigits = {
        "0000" = "0";
        "0001" = "1";
        "0010" = "2";
        "0011" = "3";
        "0100" = "4";
        "0101" = "5";
        "0110" = "6";
        "0111" = "7";
        "1000" = "8";
        "1001" = "9";
        "1010" = "a";
        "1011" = "b";
        "1100" = "c";
        "1101" = "d";
        "1110" = "e";
        "1111" = "f";
      };
      toHexDigit = d: hexDigits.${d};
    in
    s:
    let
      modlen = lib.mod (builtins.stringLength s) 4;
      padded-s =
        if modlen == 0 then
          s
        else if modlen == 1 then
          "000" + s
        else if modlen == 2 then
          "00" + s
        else if modlen == 3 then
          "0" + s
        else
          abort "lib.mod returned an incorrect value";
      range = lib.range 0 (builtins.stringLength padded-s / 4 - 1);
    in
    lib.concatMapStrings (index: toHexDigit (builtins.substring (index * 4) 4 padded-s)) range;
  # converts a given string to a v5 uuid, attempting to conform to rfc 9562
  stringToUuidv5 = (
    s:
    let
      hash = builtins.hashString "sha1" s;
      binary =
        # 00 is just padding to make the length be a multiple of 4; the last bytes are discarded anyways
        binStringToHexString ("10" + (hexStringToBinString (builtins.substring 15 (-1) hash)) + "00");
    in
    (builtins.substring 0 8 hash)
    + "-"
    + (builtins.substring 8 4 hash)
    + "-5"
    + (builtins.substring 12 3 hash)
    + "-"
    + (builtins.substring 0 4 binary)
    + "-"
    + (builtins.substring 4 12 binary)
  );
}
