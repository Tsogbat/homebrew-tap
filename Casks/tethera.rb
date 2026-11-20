cask "tethera" do
  version :latest
  sha256 :no_check

  url "https://github.com/Tsogbat/tethera/releases/latest/download/Tethera-macOS.dmg",
      verified: "github.com/Tsogbat/tethera/"
  name "Tethera"
  desc "Terminal for running and supervising AI coding agents"
  homepage "https://tsogbat.github.io/tethera/"

  # Tethera updates itself (signed, checked against the key built into the app).
  auto_updates true
  depends_on macos: ">= :sonoma"

  app "Tethera.app"
  binary "#{appdir}/Tethera.app/Contents/Helpers/tethera"

  # Tethera isn't notarized yet; without this, macOS blocks the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tethera.app"]
  end

  uninstall quit: "com.tethera.app"

  zap trash: [
    "~/Library/Application Support/Tethera",
    "~/Library/Preferences/com.tethera.app.plist",
  ]
end
