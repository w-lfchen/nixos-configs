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
}
