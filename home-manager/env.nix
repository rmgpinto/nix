{ username }: {
  PATH = "/etc/profiles/per-user/${username}/bin:$PATH";
  # Disable direnv warnings
  DIRENV_WARN_TIMEOUT = 0;
  # Disable direnv log
  DIRENV_LOG_FORMAT = "";
}
