{
  description = ''The Fast-Light Tool Kit'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."fltk-master".dir   = "master";
  inputs."fltk-master".owner = "nim-nix-pkgs";
  inputs."fltk-master".ref   = "master";
  inputs."fltk-master".repo  = "fltk";
  inputs."fltk-master".type  = "github";
  inputs."fltk-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."fltk-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}