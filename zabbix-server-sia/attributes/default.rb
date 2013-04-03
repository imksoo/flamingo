default["zabbix_server"]["node_id"] = 0

default["zabbix_server"]["listen_ip"] = nil
default["zabbix_server"]["listen_port"] = 10051

default["zabbix_server"]["log_file"] = "/var/log/zabbix/zabbix_server.log"
default["zabbix_server"]["log_file_size"] = 0

default["zabbix_server"]["pid_file"] = "/var/run/zabbix/zabbix_server.pid"

default["zabbix_server"]["db_host"] = "localhost"
default["zabbix_server"]["db_name"] = "zabbix"
default["zabbix_server"]["db_user"] = "zabbix"
default["zabbix_server"]["db_password"] = "P@ssw0rd"
default["zabbix_server"]["db_socket"] = "/var/lib/mysql/mysql.sock"
default["zabbix_server"]["db_port"] = nil

default["zabbix_server"]["start_pollers"] = 5
default["zabbix_server"]["start_ipmi_pollers"] = 0
default["zabbix_server"]["start_poller_unreachable"] = 1
default["zabbix_server"]["start_trappers"] = 5
default["zabbix_server"]["start_pingers"] = 1
default["zabbix_server"]["start_discoverers"] = 1
default["zabbix_server"]["start_http_pollers"] = 1

default["zabbix_server"]["java_gateway"] = nil
default["zabbix_server"]["java_gateway_port"] = 10052
default["zabbix_server"]["start_java_pollers"] = 0

default["zabbix_server"]["snmp_trapper_file"] = "/var/log/snmptt/snmptt.log"
default["zabbix_server"]["start_snmp_trapper"] = 0

default["zabbix_server"]["housekeeping_frequency"] = 1 #hour
default["zabbix_server"]["max_housekeeping_delete"] = 500
default["zabbix_server"]["disable_housekeeping"] = 0 #0:enable, 1:disable

default["zabbix_server"]["sender_frequency"] = 30 #sec

default["zabbix_server"]["start_db_syncers"] = 4
default["zabbix_server"]["cache_size"] = 8*4 #default:8MB
default["zabbix_server"]["cache_update_frequency"] = 60 #sec
default["zabbix_server"]["history_cache_size"] = 8*4 #default:8MB
default["zabbix_server"]["history_text_cache_size"] = 16*4 #default:16MB
default["zabbix_server"]["trend_cache_size"] = 4*4 #default:4MB

default["zabbix_server"]["node_no_events"] = 0
default["zabbix_server"]["node_no_history"] = 0

default["zabbix_server"]["timeout"] = 3 #sec
default["zabbix_server"]["trapper_timeout"] = 300 #sec
default["zabbix_server"]["unavailable_delay"] = 60 #sec
default["zabbix_server"]["unreachable_delay"] = 15 #sec
default["zabbix_server"]["unreachable_period"] = 45 #sec

default["zabbix_server"]["alert_scripts_path"] = "/usr/lib/zabbix/alertscripts"
default["zabbix_server"]["external_scripts"] = "/usr/lib/zabbix/externalscripts"

default["zabbix_server"]["fping_location"] = "/usr/sbin/fping"
default["zabbix_server"]["fping6_location"] = "/usr/sbin/fping6"

default["zabbix_server"]["ssh_key_location"] = nil

default["zabbix_server"]["log_slow_queries"] = 1000 #msec, default:0(disabled)

default["zabbix_server"]["tmp_dir"] = "/tmp"
default["zabbix_server"]["include"] = nil

default["zabbix_server"]["start_proxy_pollers"] = 1
default["zabbix_server"]["proxy_config_frequency"] = 3600 #sec
default["zabbix_server"]["proxy_data_frequency"] = 1 #sec
