# Build FreeIOE Package with prebuilt toolchains

This is a [GitHub Action](https://github.com/features/actions) that will
build a [FreeIOE package](https://github.com/freeioe/freeioe) using the prebuilt [toolchains](https://github.com/freeioe/freeioe_dockers/).

## Usage

```yaml
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the action will run. Triggers the workflow on push or pull request
# events but only for the master branch
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v2

      - uses: freeioe/freeioe_build_action@v1.1
        with:
          action: skynet

      - uses: actions/upload-artifact@v2
        with:
          name: output_files
          # path: ${{ steps.build.outputs.filename }}
          path: ${{ github.workspace }}/__output/**/*

```
