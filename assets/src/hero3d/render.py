import asyncio, base64, io, sys, pathlib, http.server, threading, functools
from playwright.async_api import async_playwright
from PIL import Image

HERE = pathlib.Path(__file__).parent
MODE, W, H, N, FPS, OUT = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5]), sys.argv[6]
THREE = HERE / "node_modules/three/build"

async def main():
    async with async_playwright() as p:
        b = await p.chromium.launch(args=["--use-gl=angle", "--use-angle=swiftshader", "--enable-unsafe-swiftshader", "--ignore-gpu-blocklist"])
        pg = await b.new_page(viewport={"width": W, "height": H})
        async def serve(route):
            name = route.request.url.rsplit("/", 1)[-1]
            await route.fulfill(path=str(THREE / name), content_type="text/javascript")
        await pg.route("https://cdn.jsdelivr.net/npm/three@0.187.0/build/*", serve)
        await pg.goto((HERE / "hero3d.html").as_uri())
        await pg.wait_for_function("window.ready === true")
        await pg.evaluate("([m,w,h]) => window.setup(m,w,h)", [MODE, W, H])
        frames = []
        for i in range(N):
            url = await pg.evaluate("(t) => window.frame(t)", i / N)
            frames.append(Image.open(io.BytesIO(base64.b64decode(url.split(",")[1]))).convert("RGBA"))
        await b.close()
    frames[0].save(OUT, save_all=True, append_images=frames[1:], duration=int(1000 / FPS), loop=0, quality=int(__import__("os").environ.get("Q","60")), method=6, lossless=False)
    frames[N // 4].save(OUT + ".preview.png")
    print(OUT, pathlib.Path(OUT).stat().st_size // 1024, "KB")
asyncio.run(main())
