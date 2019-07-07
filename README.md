# Docker一键V2ray websocket + TLS

* 固定 UUID 
* 默认使用 caddy 自动获取证书
* 自动生成 安卓 v2rayNG vmess链接
* 自动生成 iOS shadowrocket vmess链接
* 自动生成 iOS 二维码

## 使用方法

 * 准备好域名并指向你这台服务器IP
 * 会占用 443 和 80 端口请提前确认没有跑其他的业务 （ lsof -i:80 和 lsof -i:443 能查看）
 * 下面 yourdomain.com 和 testV2ray 分别换成自己的 域名 和 节点名称 (重要)

```
sudo docker run -p 443:443 -p 80:80 --restart=always -v $HOME/.caddy:/root/.caddy ntgeralt/v2raywslts yourdomain.com ntgeralt-V2ray
```

* 跑完请复制保存好自己的 节点信息！（真心忘了或者丢了 sudo docker ps -a 查看 container id 然后 sudo docker stop containerID 重新跑就完事 ）

有问题欢迎提issue， 感谢 sebs.club。参考了 caddy docker 和 v2ray 的 docker 感谢！
