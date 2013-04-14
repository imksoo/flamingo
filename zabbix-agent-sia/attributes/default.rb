default["zabbix_agent"]["pid_file"] = "/var/run/zabbix/zabbix_agentd.pid"
default["zabbix_agent"]["log_file"] = "/var/log/zabbix/zabbix_agentd.log"
default["zabbix_agent"]["log_file_size"] = 0

default["zabbix_agent"]["debug_level"] = 3

default["zabbix_agent"]["source_ip"] = nil

default["zabbix_agent"]["enable_remote_commands"] = 1 #default:0(not allowed), 1:(allowed)
default["zabbix_agent"]["log_remote_commands"] = 1 #default:0(disabled), 1:(enabled)

default["zabbix_agent"]["server"] = "10.3.12.105,127.0.0.1" #comma delimited IP addresses
default["zabbix_agent"]["server_active"] = "10.3.12.105" #comma delimited IP:port list

default["zabbix_agent"]["listen_port"] = 10050 #default:10050
default["zabbix_agent"]["listen_ip"] = "0.0.0.0" #default:0.0.0.0
default["zabbix_agent"]["start_agents"] = 3 #default:3

default["zabbix_agent"]["refresh_active_checks"] = 120 #sec, default:120

default["zabbix_agent"]["buffer_send"] = 5 #default:5
default["zabbix_agent"]["buffer_size"] = 100 #default:100
default["zabbix_agent"]["max_lines_per_second"] = 100 #default:100

default["zabbix_agent"]["allow_root"] = 0 #default:0(do not allow), 1(allow)

default["zabbix_agent"]["timeout"] = 3 #sec, default:3

default["zabbix_agent"]["include"] = ["/etc/zabbix/zabbix_agentd.d/"] 

default["zabbix_agent"]["unsafe_user_parameters"] = 0 #default:0(do not allow), 1(allow)
default["zabbix_agent"]["user_parameter"] = [] #Format: "<key>,<shell command>"

