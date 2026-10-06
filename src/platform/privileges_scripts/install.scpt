on run {daemon_file, agent_file, user}

  set prefs_dir to "/Users/" & user & "/Library/Preferences/com.carriez.RustDesk/"
  set prefs_toml to quoted form of (prefs_dir & "RustDesk.toml")
  set prefs2_toml to quoted form of (prefs_dir & "RustDesk2.toml")
  set prefs_dest_dir to quoted form of "/var/root/Library/Preferences/com.carriez.RustDesk/"

  set daemon_label to "com.carriez.RustDesk_service"
  set agent_label to "com.carriez.RustDesk_server"
  set daemon_dest to "/Library/LaunchDaemons/" & daemon_label & ".plist"
  set agent_dest to "/Library/LaunchAgents/" & agent_label & ".plist"

  set sh1 to "echo " & quoted form of daemon_file & " > " & quoted form of daemon_dest & " && chown root:wheel " & quoted form of daemon_dest & ";"

  set sh2 to "echo " & quoted form of agent_file & " > " & quoted form of agent_dest & " && chown root:wheel " & quoted form of agent_dest & ";"

  set sh3 to "cp -rf " & prefs_toml & " " & prefs_dest_dir & ";"

  set sh4 to "cp -rf " & prefs2_toml & " " & prefs_dest_dir & ";"

  set sh5 to "launchctl bootout " & quoted form of ("system/" & daemon_label) & " 2>/dev/null || launchctl unload -w " & quoted form of daemon_dest & " 2>/dev/null || true; launchctl bootstrap system " & quoted form of daemon_dest & " 2>/dev/null || launchctl load -w " & quoted form of daemon_dest & ";"

  set sh to sh1 & sh2 & sh3 & sh4 & sh5

  do shell script sh with prompt "RustDesk wants to install daemon and agent" with administrator privileges
end run
