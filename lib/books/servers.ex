defmodule Books.Servers do
  import Base 

  def all do
    [
      %{
        name: "🇭🇰svip21香港",
        host: "svip21.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇭🇰svip22香港",
        host: "svip22.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇭🇰svip23香港",
        host: "svip23.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇯🇵svip24日本",
        host: "svip24.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: false
      },
      %{
        name: "🇷🇺svip25俄罗斯",
        host: "svip25.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇷🇺svip26俄罗斯",
        host: "svip26.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇦🇺svip27美国",
        host: "svip27.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: false
      },
      %{
        name: "🇦🇺svip28美国",
        host: "svip28.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: false
      },
      %{
        name: "🇺🇸svip29澳洲",
        host: "svip29.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇺🇸svip30澳洲",
        host: "svip30.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: true
      },
      %{
        name: "🇬🇧svip31英国",
        host: "svip31.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: false
      },
      %{
        name: "🇬🇧svip32英国",
        host: "svip32.mm1080p.rocks",
        s5_port: 555,
        socks5_tls: true,
        ssr: false
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

  defp single_ssr_text(s, port, password) do
    group = e64("books")
    "#{s.host}:#{port}:auth_aes128_md5:aes-256-cfb:tls1.2_ticket_auth:#{e64(password)}/?remarks=#{e64(s.name)}&group=#{group}"
  end
end
