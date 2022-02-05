import json


def read_conf_file(file_name):
    with open(file_name) as f:
        contents = f.read()
        return contents


def generate_nginx_conf(servers_file_name: str, nginx_conf_file_name: str):
    with open(servers_file_name) as f:
        nginx_conf = read_conf_file("nginx.conf.template")
        c = f.read()
        servers_input = json.loads(c)

        all_servers = ""
        for server in servers_input:
            server_conf = ""
            if server["https"] == True:
                server_conf = read_conf_file("https-server.template")
            else:
                server_conf = read_conf_file("http-server.template")

            server_conf = server_conf.replace("$_SERVER_NAME_$", server["server_name"])
            server_conf = server_conf.replace(
                "$_UPSTREAM_PORT_$", server["upstream_port"]
            )
            all_servers += server_conf

        new_conf = nginx_conf.replace("$$$_SERVERS_$$$", all_servers)
        print(new_conf)

        out_file = open(nginx_conf_file_name, "x")
        out_file.write(new_conf)
        out_file.close()


if __name__ == "__main__":
    generate_nginx_conf(
        servers_file_name="servers.json", nginx_conf_file_name="nginx.conf"
    )
