import filecmp
from scripts.generate_nginx_conf import generate_nginx_conf


def test_generate_nginx_conf_one_server(tmpdir):
    path = tmpdir.mkdir("tmp")
    nginx_conf = f"{path}/actual-one-server-nginx.conf"
    generate_nginx_conf(
        servers_file_name="tests/pinned-inputs/one-server.json",
        nginx_conf_file_name=nginx_conf,
    )
    assert filecmp.cmp(
        "tests/pinned-results/expected-one-server-nginx.conf", nginx_conf
    )


def test_generate_nginx_conf_multiple_servers(tmpdir):
    path = tmpdir.mkdir("tmp")
    nginx_conf = f"{path}/actual-multiple-servers-nginx.conf"
    generate_nginx_conf(
        servers_file_name="tests/pinned-inputs/multiple-servers.json",
        nginx_conf_file_name=nginx_conf,
    )
    assert filecmp.cmp(
        "tests/pinned-results/expected-multiple-servers-nginx.conf", nginx_conf
    )
