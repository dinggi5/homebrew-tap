# dinggi5/homebrew-tap

[dinggi5](https://github.com/dinggi5) 가 만든 맥 앱을 Homebrew 로 설치하는 탭입니다.

## Kura

AI 에이전트를 위한 로컬 EVM 지갑 — [dinggi5/kura](https://github.com/dinggi5/kura)

```sh
brew install --cask dinggi5/tap/kura
```

업데이트는 `brew upgrade --cask dinggi5/tap/kura`, 삭제는
`brew uninstall --cask dinggi5/tap/kura` 입니다.

> ⚠️ 앱을 지워도 지갑 파일(`~/.jigap`)은 **일부러 남깁니다.** 12단어 백업이 없는
> 상태에서 지우면 자산이 영구히 사라지기 때문입니다. 자세한 내용은
> Kura README 의 "지우기" 절을 보세요.

## 설치본이 진짜인지

이 탭이 받는 DMG 는 Developer ID 인증서로 서명하고 애플 공증을 받은 파일입니다.
받은 뒤 직접 확인하려면 (`<받은.dmg>` 자리에 실제 경로):

```sh
spctl -a -t open --context context:primary-signature -vv <받은.dmg>
```

`accepted` 와 `source=Notarized Developer ID`, 팀 ID `74ZAMXKVXN` 이 나오면
**이 인증서로 서명됐고 그 뒤 변조되지 않았다**는 뜻입니다. (인증서나 계정이
털리는 경우까지 막아 주지는 않습니다.)
