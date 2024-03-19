{
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
    rails-dev = "docked bin/dev";
    rails-shell = "docker exec -it $(docker ps | grep rails | awk \"{print \$1}\") bash";
    bundle = "docked bundle";
    yarn = "docked yarn";
    rake = "docked rake";
    gem = "docked gem";
    credentials-edit = "docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit\"";
    credentials-edit-dev = "docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit --environment development\"";
    credentials-edit-test = "docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit --environment test\"";
    credentials-edit-prod = "docked bash -c \"apt-get install -y vim && EDITOR=vim rails credentials:edit --environment production\"";

    # Work
    tg = "terragrunt";
    k = "kubectl";
  };

  git = {
    co = "checkout";
    br = "branch";
    ci = "commit -S";
    unstage = "reset HEAD --";
    l = "log --oneline --graph";
    lp = "log --oneline --graph -p";
    st = "status -s";
    df = "diff";
    dfs = "diff --staged";
    sha = "rev-parse HEAD";
  };

  functions = ''
    function tns(){
      tmux new-session -A -s $1 \; split-window -h \; send-keys "$2" C-m \;
    }

    function tfp() {
      if [ "$1" != "" ]; then
        ENVIRONMENTS=(development dev staging stage qa production prod)
        if [[ ''${ENVIRONMENTS[(r)\$1]} == "$1" ]]; then
          export TF_WORKSPACE="$1"
          export TF_VAR_FILE="-var-file=vars.$1.tfvars"
          export TF_EXTRA_ARGS="''${@: (($#-1)),2}"
        else
          export TF_EXTRA_ARGS="''${@: (($#-1)),1}"
        fi
      fi
      terraform plan ''${TF_VAR_FILE} -lock=false ''${TF_EXTRA_ARGS}
      unset TF_WORKSPACE TF_VAR_FILE TF_EXTRA_ARGS
    }

    function tfa() {
      if [ "$1" != "" ]; then
        ENVIRONMENTS=(development dev staging stage qa production prod)
        if [[ ''${ENVIRONMENTS[(r)\$1]} == "$1" ]]; then
          export TF_WORKSPACE="$1"
          export TF_VAR_FILE="-var-file=vars.$1.tfvars"
          export TF_EXTRA_ARGS="''${@: (($#-1)),2}"
        else
          export TF_EXTRA_ARGS="''${@: (($#-1)),1}"
        fi
      fi
      terraform apply ''${TF_VAR_FILE} ''${TF_EXTRA_ARGS}
      unset TF_WORKSPACE TF_VAR_FILE TF_EXTRA_ARGS
    }

    function tfd() {
      if [ "$1" != "" ]; then
        ENVIRONMENTS=(development dev staging stage qa production prod)
        if [[ ''${ENVIRONMENTS[(r)$1]} == "$1" ]]; then
          export TF_WORKSPACE="$1"
          export TF_VAR_FILE="-var-file=vars.$1.tfvars"
          export TF_EXTRA_ARGS="''${@: (($#-1)),2}"
        else
          export TF_EXTRA_ARGS="''${@: (($#-1)),1}"
        fi
      fi
      terraform destroy ''${TF_VAR_FILE} ''${TF_EXTRA_ARGS}
      unset TF_WORKSPACE TF_VAR_FILE TF_EXTRA_ARGS
    }

    function wtfp() {
      fswatch -r -o -e '.*' -i '\.tf$' -i '\.tfvars$' . | xargs -n1 -I{} zsh -ic "tfp $1"
    }
  '';
}
