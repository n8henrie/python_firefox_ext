# $version = "v0.23.1/debug"
$version = "v0.23.1/full"

$urls = @(
    "https://cdn.jsdelivr.net/pyodide/${version}/pyodide.js"
    "https://cdn.jsdelivr.net/pyodide/${version}/pyodide.asm.js"
    "https://cdn.jsdelivr.net/pyodide/${version}/pyodide.asm.wasm"
    "https://cdn.jsdelivr.net/pyodide/${version}/python_stdlib.zip"
    "https://cdn.jsdelivr.net/pyodide/${version}/repodata.json"
)

# Remove-Item -Recurse ./runtime/*
$urls | ForEach-Object {
    $filename = (Split-Path [uri]$_ -leaf)
    $path = "runtime/$filename"
    if (Test-Path -path $path -PathType Leaf) {
        Write-Host "$path exists"
    } else {
        Write-Host "downloading $_"
        Invoke-WebRequest "$_" -outfile "$path"
    }
}