defmodule Books.Servers do
  import Base 

  def all do
    [
      %{
        name: "🇭🇰香港 svip21",
        host: "svip21.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇭🇰香港 svip22",
        host: "svip22.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇭🇰香港 svip23",
        host: "svip23.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇯🇵日本 svip24",
        host: "svip24.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇷🇺俄罗斯 svip25",
        host: "svip25.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇷🇺俄罗斯 svip26",
        host: "svip26.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇷🇺俄罗斯 svip27",
        host: "svip27.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇷🇺俄罗斯 svip28",
        host: "svip28.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇦🇺美国 svip29",
        host: "svip29.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇦🇺美国 svip30",
        host: "svip30.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇯🇵日本 svip31",
        host: "svip31.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: false
      },
      %{
        name: "🇯🇵日本 svip32",
        host: "svip32.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: false
      },
      %{
        name: "🇰🇷韩国 svip33",
        host: "svip33.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇯🇵日本 svip34",
        host: "svip34.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇯🇵日本 svip35",
        host: "svip35.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      }
    ]
  end

  def socks5_tls do
    Enum.filter(all(), fn s -> s.socks5_tls end)
  end
  
  def ssr_text(port, password) do
    all()
    |> Enum.filter(fn s -> s.ssr end)
    |> Enum.map(fn s -> single_ssr_text(s, port, password) end)
    |> Enum.map_join("\n", fn str -> "ssr://#{url_encode64(str, padding: false)}" end)
    |> e64()
  end

  defp e64(text) do
    url_encode64(text, padding: false)
  end

  defp single_ssr_text(s, port, password) when port > 9680 do
    group = e64("books")
    name = e64("#{s.name}.ssr")
    obfsparam = e64("#{port}:#{password}")
    pass = e64("123456")
    "#{s.host}:443:auth_aes128_md5:aes-256-cfb:tls1.2_ticket_auth:#{pass}/?protoparam=#{obfsparam}&remarks=#{name}&group=#{group}"
  end

  defp single_ssr_text(s, port, password)  do
    group = e64("books")
    name = e64("#{s.name}.ssr")
    "#{s.host}:#{port}:auth_aes128_md5:aes-256-cfb:tls1.2_ticket_auth:#{e64(password)}/?remarks=#{name}&group=#{group}"
  end
end
