##!/usr/bin/env bash

set -Eeuf -o pipefail

# readonly VERSION="v0.23.1/debug"
readonly VERSION="v0.23.1/full"

main() {
  mkdir -p ./runtime
  urls=(
    "https://cdn.jsdelivr.net/pyodide/${VERSION}/pyodide.js"
    "https://cdn.jsdelivr.net/pyodide/${VERSION}/pyodide.asm.js"
    "https://cdn.jsdelivr.net/pyodide/${VERSION}/pyodide.asm.wasm"
    "https://cdn.jsdelivr.net/pyodide/${VERSION}/python_stdlib.zip"
    "https://cdn.jsdelivr.net/pyodide/${VERSION}/repodata.json"
  )

  for url in "${urls[@]}"; do
    local filename
    filename=$(basename "${url}")
    local path="runtime/${filename}"
    if [[ -f "${path}" ]]; then
      printf '%s exists\n' "${path}"
    else
      printf 'downloading %s\n' "${path}"
      curl "${url}" > "${path}"
    fi
  done
}
main "$@"
