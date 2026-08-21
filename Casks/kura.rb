cask "kura" do
  version "0.1.2"
  sha256 "6274ba9bf52e334240f8df577b09730f9ee8f1446046dec2e51d810263e0e468"

  url "https://github.com/dinggi5/kura/releases/download/v#{version}/Kura_#{version}_aarch64.dmg",
      verified: "github.com/dinggi5/kura/"
  name "Kura"
  # "local-only" 라고 쓰지 않는다 — 키는 이 맥을 안 떠나지만 잔액 조회·송금은
  # 사용자가 고른 RPC 서버로 나가고, 거래는 공개 체인에 남는다.
  desc "Non-custodial EVM wallet for AI agent payments over x402"
  homepage "https://github.com/dinggi5/kura"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Apple Silicon 전용 빌드다. Intel 맥에서 조용히 설치돼 안 열리는 것보다
  # 설치 단계에서 막히는 편이 낫다.
  depends_on arch: :arm64
  depends_on macos: :big_sur

  # 앱이 스스로 업데이트한다(0.1.2~). 이게 있어야 brew 가 Kura 를 건드리지 않고,
  # 그래야 위 uninstall launchctl: 이 안 돌아서 자동 시작 설정이 안 지워진다.
  # 새로 설치하는 사람은 캐스크로 받으므로 version·sha256 은 계속 갱신한다.
  auto_updates true

  app "Kura.app"

  # 메뉴바 상주 앱이라 삭제 전에 종료시켜야 한다. 자동 시작을 켜 뒀으면
  # tauri-plugin-autostart 가 만든 LaunchAgent 도 함께 내린다.
  #
  # ⚠️ launchctl 라벨은 번들 ID 가 아니라 "Kura" 다. tauri-plugin-autostart 는
  # app_name 을 안 주면 package_info().name(= productName)을 쓰고, LaunchAgent
  # 모드에서는 auto-launch 가 그 이름을 그대로 Label 과 plist 파일명에 넣는다
  # (auto-launch 0.5.0 macos.rs — 실행파일명으로 바꾸는 분기는 로그인 항목 전용).
  # 번들 ID 를 적으면 조용히 아무것도 안 내려서, 지운 뒤에도 자동 시작이 남는다.
  uninstall launchctl: "Kura",
            quit:      "com.dinggi5.kura"

  # ⚠️ 여기에 "~/.jigap" 를 넣지 않는다 — 의도적이다.
  #
  # 그 폴더에는 암호화된 개인키(wallet.enc)가 들어 있고, 12단어 백업이 없으면
  # 지우는 순간 자산이 영구히 사라진다. zap 은 사용자가 명시적으로 부르는
  # 명령이긴 하지만, `brew uninstall --zap` 한 줄과 "돈이 영영 없어짐" 사이에
  # 확인 절차가 하나도 없다.
  #
  # 남는 파일 몇 개는 사용자가 직접 지울 수 있지만, 없어진 키는 누구도 되돌릴 수
  # 없다. 비대칭이 이렇게 크면 청소가 덜 되는 쪽을 고른다.
  #
  # 이 주석은 설치한 사람에게 안 보이므로, README "지우기" 절에 "앱을 지워도 지갑은
  # 남는다"와 안전하게 지우는 절차를 함께 적어 뒀다.
  zap trash: [
    "~/Library/Application Support/com.dinggi5.kura",
    "~/Library/Caches/com.dinggi5.kura",
    "~/Library/HTTPStorages/com.dinggi5.kura",
    "~/Library/LaunchAgents/Kura.plist",
    "~/Library/Saved Application State/com.dinggi5.kura.savedState",
    "~/Library/WebKit/com.dinggi5.kura",
  ]
end
