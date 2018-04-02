defmodule Books.Servers do
  def all do
    [
      %{name: "🇭🇰svip21", host: "svip21.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇭🇰svip22", host: "svip22.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇭🇰svip23", host: "svip23.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇯🇵svip24", host: "svip24.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇷🇺svip25", host: "svip25.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇷🇺svip26", host: "svip26.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇦🇺svip27", host: "svip27.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇦🇺svip28", host: "svip28.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇺🇸svip29", host: "svip29.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇺🇸svip30", host: "svip30.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇬🇧svip31", host: "svip31.mm1080p.rocks", port: 555, socks5_tls: true},
      %{name: "🇬🇧svip32", host: "svip32.mm1080p.rocks", port: 555, socks5_tls: true}
    ]
  end

  def socks5_tls do
    Enum.filter(all(), fn s -> s.socks5_tls end)
  end
end
