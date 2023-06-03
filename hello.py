import asyncio

import js
from pyodide.ffi import to_js


def d2o(d):
    """dict to js object"""
    return js.Object.fromEntries(to_js(d))


async def browser_script():
    print("browser_script")

    if not hasattr(js.browser, "tabs"):
        return

    js_result = await js.browser.tabs.query(d2o({"currentWindow": True}))
    result = js_result.to_py()

    for tab in result:
        print(tab["id"], tab["title"])

    print(f"You are on {js.document.location}")

    url = "https://n8henrie.com/2023/06/write-a-firefox-extension-in-python"
    await js.browser.tabs.create(d2o({"url": url}))


def content_script():
    print("content_script")
    js.document.body.style.border = "5px solid red"
    print(f"You are on {js.document.location}")


async def main():
    if hasattr(js.browser.extension, "getBackgroundPage"):
        await browser_script()
    content_script()


if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
