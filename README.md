# wuxia

Manga Reader built upon the [RumGap](https://github.com/hubble459/rumgap) API.

## Installation (Linux)

1. Download `wuxia-linux.tar.gz` from the [latest release](https://github.com/hubble459/wuxia/releases/latest)
2. Extract it:
   ```bash
   mkdir wuxia && tar -xzf wuxia-linux.tar.gz -C wuxia
   ```
3. Run:
   ```bash
   ./wuxia/wuxia
   ```

> **Dependencies** — make sure `libgtk-3` is installed:
> ```bash
> # Debian/Ubuntu
> sudo apt-get install libgtk-3-0
> # Arch
> sudo pacman -S gtk3
> # Fedora
> sudo dnf install gtk3
> ```

## Development

### Regenerating the gRPC client

The Dart gRPC client in `lib/gen` is generated from rumgap's `.proto` files (`../rumgap/proto`, so this repo must sit next to a `rumgap` checkout).

1. **Install `protoc`** (the Protobuf compiler):
```bash
# Debian/Ubuntu
sudo apt-get install protobuf-compiler
# Arch
sudo pacman -S protobuf
# Fedora
sudo dnf install protobuf-compiler
# macOS
brew install protobuf
```
Verify with `protoc --version` (3.15+ recommended for proto3 `optional` support).

2. Install the Dart protoc plugin and make sure it's on your PATH:
```bash
dart pub global activate protoc_plugin
export PATH="$PATH:$HOME/.pub-cache/bin"
```

3. Clone the Google proto dependencies anywhere, then point the env vars at them (defaults used by gen_google_grpc.sh are /opt/protobuf and /opt/googleapis):
```bash
git clone https://github.com/protocolbuffers/protobuf /opt/protobuf
git clone https://github.com/googleapis/googleapis /opt/googleapis
```

4. Generate the client:
```bash
./gen_grpc_client.sh
```

Run this whenever rumgap's proto/**/*.proto files change.

## Features
- Searching for manga
- Reading chapters
    - List view (webtoon)
- Keeping track of progress
    - Progress of manga (which chapter)
    - Progress of chapter (how far you scrolled)
- Filtering on last read, latest update, manga title etc
- Support for self-hosting the backend (custom API url)
- Accounts
    - Easily log in to access all your manga
- Languages
    - I18n is built-in, so any language can be added
    - Current support for English and (DeepL) Chinese
- Dark Mode

## Roadmap
- [ ] Social 
    - [ ] Friends
    - [ ] Profile Page
        - [ ] Recent Activity (like in MAL)
    - [ ] Custom Avatar
    - [ ] Ratings
    - [ ] Comments
- [ ] Download
- [ ] Groups
- [ ] MAL Integration
- [ ] Optional Email
    - [ ] Forgot password flow
- [x] Add from url
- [x] Open manga in browser
- [x] Open chapter in browser
- [x] Search alternatives
- [ ] Notifications 
    - [ ] Background manga updater
        - [ ] Priority calculator
- [x] Progress per chapter
    - [ ] Daily activity chart
- [ ] Outage report/ handling
    - [ ] Like when a website is down, make the items red or inactive
    - [x] Advise to choose alternatives
- [x] Update app from within settings
- [ ] Tests
- [ ] Periodic Backups
- [ ] Paged Image View
    - [ ] LTR, RTL, Top-Down
- [ ] gRPC SSL
