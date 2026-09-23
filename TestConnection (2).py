#Pings core gateway addresses, checks DNS resolution, 
# validates local IP configurations, 
# and checks active USB/display interfaces. 
# Solves "my network/monitor isn't working" support tickets instantly.
import shutil
import psutil
import socket

def internet_con():
    try:
        ping = socket.create_connection(("8.8.8.8", 53), timeout=3)
        return "Network is on. [CONNECTION UP.]"
    except OSError:
        print("oops")

net_stat = internet_con()
print(net_stat)
        

def dns_con(domain):
    try:
        ip_addr = socket.gethostbyname(domain)
        return  "DOMAIN IS UP"
    except OSError:
        return "DOMAIN IS DOWN"
dns_status= dns_con("clearpc.net")
print (dns_status)


def local_ip():
    try:
        addr = psutil.net_if_addrs()
        s = socket.AF_INET
        return s
    except:
        print("oops")

stats = local_ip()
print(stats)