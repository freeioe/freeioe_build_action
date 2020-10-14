# Build FreeIOE Package with prebuilt toolchains

This is a [GitHub Action](https://github.com/features/actions) that will
build a [FreeIOE package](https://github.com/freeioe/freeioe) using the prebuilt [toolchains](https://github.com/freeioe/freeioe_dockers/).

## Usage

```yaml
on:
  push:
    branches:
      - master

jobs:
  build-deb:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - uses: freeioe/freeioe_build_action@v1
        id: build
        with:
		  action: build_skynet_all.sh

      - uses: actions/upload-artifact@v1
        with:
          name: ${{ steps.build.outputs.filename }}
          path: ${{ steps.build.outputs.filename }}
```
