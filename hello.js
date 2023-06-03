"use strict";

window.encodeURIComponent = () => null;


(async function() {
    let base = browser.runtime.getURL(".")
    const pyodide = await loadPyodide({indexURL: base + "runtime"})
    const script = await fetch(base + "hello.py").then(resp => resp.text())

    pyodide.runPython(script)
})()