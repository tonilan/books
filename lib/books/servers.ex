defmodule Books.Servers do
  import Base 

  def all do
    [
      %{
        name: "🇭🇰香港 21无限流量 HKT ",
        host: "svip21.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇭🇰香港 22无限流量 HKT",
        host: "svip22.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇭🇰香港 23无限流量 HKT",
        host: "svip23.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇷🇺俄国 24无限流量",
        host: "svip24.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇷🇺俄国 25无限流量",
        host: "svip25.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇷🇺俄国 26无限流量",
        host: "svip26.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇷🇺俄国 27无限流量",
        host: "svip27.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇰🇷韩国 28无限流量 SK",
        host: "svip28.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇰🇷韩国 29无限流量 SK",
        host: "svip29.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇺🇸美国 30无限流量 SuperNCP",
        host: "svip30.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇺🇸美国 31无限流量 SuperNCP",
        host: "svip31.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇺🇸美国 32流量珍贵 GIA CN2",
        host: "svip32.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇺🇸美国 33流量珍贵 GIA CN2",
        host: "svip33.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇯🇵日本 34无限流量 IIJ",
        host: "svip34.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇯🇵日本 35无限流量 IIJ",
        host: "svip35.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇷🇺伯力 36流量珍贵",
        host: "svip36.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      },
      %{
        name: "🇷🇺伯力 37流量珍贵",
        host: "svip37.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        vmess: true
      }
    ]
  end

  def socks5_tls do
    Enum.filter(all(), fn s -> s.socks5_tls end)
  end

  def ssr_server do
    Enum.filter(all(), fn s -> s.ssr end)
  end

  def vmess_server do
    Enum.filter(all(), fn s -> s.vmess end)
  end
  
  def ssr_text(port, password) do
    ssr_server()
    |> Enum.map(fn s -> single_ssr_text(s, port, password) end)
    |> Enum.map_join("\n", fn str -> "ssr://#{url_encode64(str, padding: false)}" end)
    |> e64()
  end

  def quantumult_ssr_text(port, password) do
    ssr_server()
    |> Enum.map(fn s -> quantumult_single_ssr_text(s, port, password) end)
    |> Enum.join("\n")
  end

  def quantumult_single_ssr_text(s, port, password) when port > 9680 or port < 9000 do
    protocol_param = "#{port}:#{password}"
    "#{s.name} = shadowsocksr, #{s.host}, 443, aes-256-cfb, #{password}, group=books, protocol=auth_aes128_md5, protocol_param=#{protocol_param}, obfs=tls1.2_ticket_auth"
  end

  def quantumult_single_ssr_text(s, port, password) do
    "#{s.name} = shadowsocksr, #{s.host}, #{port}, aes-256-cfb, #{password}, group=books, protocol=auth_aes128_md5, obfs=tls1.2_ticket_auth"
  end

  defp e64(text) do
    url_encode64(text, padding: false)
  end

  defp single_ssr_text(s, port, password) when port > 9680 or port < 9000 do
    group = e64("books")
    name = e64(s.name)
    obfsparam = e64("#{port}:#{password}")
    pass = e64("123456")
    "#{s.host}:443:auth_aes128_md5:aes-256-cfb:tls1.2_ticket_auth:#{pass}/?protoparam=#{obfsparam}&remarks=#{name}&group=#{group}"
  end

  defp single_ssr_text(s, port, password)  do
    group = e64("books")
    name = e64(s.name)
    "#{s.host}:#{port}:auth_aes128_md5:aes-256-cfb:tls1.2_ticket_auth:#{e64(password)}/?remarks=#{name}&group=#{group}"
  end
end
