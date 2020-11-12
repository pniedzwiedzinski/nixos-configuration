with import <nixpkgs> {};

let
  dmenu-man-search = pkgs.writeShellScriptBin "dmenu-man-search" ''
terminal=${TERMINAL:-st}
prompt="-p Manual:"
manual="$(man -k . | ${pkgs.dmenu}/bin/dmenu $prompt | awk '{print $1}')"

if [[ ! -z "$manual" ]]; then
    eval "$($terminal -T "Mansearch - Manual Viewer" -e "man $manual")"
fi

exit 0
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-man-search ];
}
