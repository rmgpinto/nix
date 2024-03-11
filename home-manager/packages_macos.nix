{ pkgs }: 
  with pkgs; [
    raycast
    # qemu # podman dependency
    podman
  ]