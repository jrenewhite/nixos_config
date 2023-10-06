{ pkgs }:

pkgs.vscode-with-extensions.override {
  vscodeExtensions = with pkgs.vscode-extensions; [
    # ... common extensions from nixpkgs ...
      bbenoist.nix
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # # ... extensions from vscode marketplace ...
    # {
    #   name = "example-extension";
    #   publisher = "example-publisher";
    #   version = "1.2.3";
    #   sha256 = "sha256-value";  # replace with the correct sha256
    # }
    # ... more extensions ...
  ];
}

