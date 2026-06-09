{ inputs, ... }: {

  additions = final: _prev: {
    # import ../pkgs final.pkgs;
  };

  modifications = final: prev: {
    valkey = prev.valkey.overrideAttrs (oldAttrs: {
      doCheck = false;
    });
  };
}
