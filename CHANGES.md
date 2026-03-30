# Changelog

## 2026-03-30 — Fork from web-p24c

- Forked from [softwarewrighter/web-p24c](https://github.com/softwarewrighter/web-p24c)
  to [sw-embed/web-sw-cor24-pascal](https://github.com/sw-embed/web-sw-cor24-pascal)
- Renamed package to `web-sw-cor24-pascal`
- Updated path dependencies to use consolidated sw-embed repos:
  - `cor24-emulator` → `../sw-cor24-emulator`
  - `pa24r` → `../sw-cor24-pcode/assembler`
  - `pl24r` → `../sw-cor24-pcode/linker`
- Updated build.rs p24p compiler path to `../sw-cor24-pascal/compiler/src`
- Updated Trunk.toml public_url to `/web-sw-cor24-pascal/`
- Updated GitHub URLs throughout to sw-embed organization
- Updated README with new canonical project links
- Streamlined CLAUDE.md for reorganized project structure
