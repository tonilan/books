defmodule Books.Servers do
  import Base 

  def all do
    [
      %{
        name: "🇭🇰HK 21 HKT ",
        host: "svip21.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇭🇰HK 22 HKT",
        host: "svip22.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇭🇰HK 23 HKT",
        host: "svip23.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇷🇺俄国 24无限流量",
        host: "svip24.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇷🇺RU 25",
        host: "svip25.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇷🇺RU 26",
        host: "svip26.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇷🇺RU 27",
        host: "svip27.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇰🇷KR 28 SK",
        host: "svip28.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇰🇷KR 29 SK",
        host: "svip29.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇺🇸US 30 HE",
        host: "svip30.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇺🇸US 31 HE",
        host: "svip31.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇺🇸US 32 GIA CN2",
        host: "svip32.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇺🇸US 33 GIA CN2",
        host: "svip33.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇯🇵JP 34 IIJ",
        host: "svip34.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇯🇵JP 35 IIJ",
        host: "svip35.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇺🇸US 36 GIA CN2",
        host: "svip36.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      },
      %{
        name: "🇺🇸US 37 GIA CN2",
        host: "svip37.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true,
        ss: true,
        vmess: true
      }
    ]
  end

  def socks5_tls do
    Enum.filter(all(), fn s -> s.socks5_tls end)
  end
  
  def ss_server do
    Enum.filter(all(), fn s -> s.ss end)  
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
