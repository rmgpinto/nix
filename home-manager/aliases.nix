{ pkgs }: {
  shell = {
    # Personal
    zs = "source ~/.zshrc";
    diff = "diff --color=auto";
    grep = "grep --color=auto";
    myip = "curl -4 https://ifconfig.co";
    flushdns = "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
    g = "git";
    tf = "terraform";
    docked = "docker run --rm -it -v \${PWD}:/rails -v ruby-bundle-cache:/bundle -p 3000:3000 -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/rails/cli";
    rails = "docked rails";
    rails-dev ="docked bin/dev";
    rails-shell="docker exec -it $(docker ps | grep rails | awk \"{print \$1}\") bash";
    bundle = "docked bundle";
    yarn = "docked yarn";
    rake = "docked rake";
    gem = "docked gem";
    credentials-edit = "docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit\"";
    credentials-edit-dev="docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit --environment development\"";
    credentials-edit-test="docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit --environment test\"";
    credentials-edit-prod="docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit --environment production\"";

    # Work
    tg = "terragrunt";
    k = "kubectl";
  };
}