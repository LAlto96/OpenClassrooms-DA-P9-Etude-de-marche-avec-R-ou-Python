# shell.nix
{ pkgs ? import <nixpkgs> {} }:
let
  my-python-packages = ps: with ps; [
    numpy 
    scipy
    pandas
    matplotlib
    seaborn
    scikit-learn
    ipykernel
    jupyter
    notebook
    (
      buildPythonPackage rec {
        pname = "yellowbrick";
        version = "1.5";
        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-maYzbdLnzlhqjN5nlmt5xRtHnTdZ88CD1+Gf/pSfYHY=";
        };
        doCheck = false;
        propagatedBuildInputs = with pkgs.python3Packages; [
          # Specify dependencies
          numpy
          scipy
          cycler
          matplotlib
          scikit-learn
        ];
      }
    )  ];
  my-python = pkgs.python3.withPackages my-python-packages;
in my-python.env
