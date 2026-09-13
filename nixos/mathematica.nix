
{pkgs, ...}:

let
  mathematica1501 = pkgs.mathematica.override {
    source = pkgs.requireFile {
     name = "Wolfram_15.0.1.sh";

     sha256 =
      "0nq3mb0s797xdf4yi8fca3yybw1p1cxp9pqh9zjfzg627h60588l";

      message = ''
      Wolfram_15.0.1.sh is missing from the Nix store.
      '';


      hashMode = "recursive";
      };
     };
     in
     {
     environment.systemPackages = [
     mathematica1501
     ];
 }
