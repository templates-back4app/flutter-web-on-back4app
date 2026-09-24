# flutter-web-on-back4app

[![Deploy on Back4app](https://img.shields.io/badge/Deploy%20on-Back4app-1568B8?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTEyIDJMMiA3djEwbDEwIDUgMTAtNVY3eiIvPjwvc3ZnPg==)](https://www.back4app.com/signup?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app)

**A Flutter web build in a container, served by nginx on Back4app Containers — the free path to hosting Flutter output in 2026.**  Two Docker stages: a pinned SDK compiles the build, nginx serves it, and the SDK never ships in the running image. Nothing to provision, patch or keep running.

Measured on September 23, 2026: `flutter build web --release` compiled in **17 s** locally, and the container build on the platform ran **9 min 13 s** to Ready. Every number in the article comes from this exact code.

> **Read the article:** [How to Host a Flutter Web App With Docker, Without Managing a Server](https://www.back4app.com/blog/host-a-flutter-web-app-with-docker?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app)

## What it does

`lib/main.dart` is a counter page that prints the `BUILD_STAMP` compiled into it, so you can prove which build is being served rather than guessing at a cache.

The stamp is computed inside the image build on purpose. Back4app Containers has no field for Docker build arguments, so a value passed from the dashboard would never reach `--dart-define`; computing it in the `RUN` step means it is always the real build moment.

## What we measured

| Measurement | Result |
|---|---|
| `flutter build web --release`, locally | 17 s |
| Container build on the platform | 9 min 13 s, ending Ready |
| Dockerfile detection | automatic — no build command, start command or port to set |
| Unknown route | 200, the SPA fallback in `nginx.conf` |
| `index.html` | `no-store, must-revalidate` |
| Hashed assets | `public, immutable`, 30 days |

Three free-plan limits taken from the dashboard rather than inferred: the URL lasts 60 minutes per deploy, autodeploy on push is paid, and there is no field for Docker build arguments.

## Files

- `lib/main.dart` — the page, and the build stamp that proves which build you are looking at.
- `Dockerfile` — two stages: Flutter 3.47.5 pinned from Google's release storage, then nginx 1.27.
- `nginx.conf` — SPA fallback to `index.html`, `no-store` on `index.html`, long cache on hashed assets.
- `test/widget_test.dart` — two passing widget tests.

## Deploy your own

1. **Create a free account.** Sign up at [https://www.back4app.com/signup?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app](https://www.back4app.com/signup?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app).
2. **Fork this repository.**
3. **Web Deployment → Deploy a Web App → GitHub repository.** Pick your fork, leave the Dockerfile path as the repository root, and deploy.
4. Open the URL it gives you and check the build stamp at the bottom of the page.

On the free plan the container's URL lives 60 minutes per deploy, and autodeploy on push is a paid feature — redeploy from the dashboard while you are testing.

## Run locally

```bash
flutter build web --release --dart-define=BUILD_STAMP="$(date -u +%Y-%m-%dT%H:%MZ)"
docker build -t flutter-web .
docker run --rm -p 8080:80 flutter-web
# then open http://localhost:8080
```

## What the platform gives you

Containers build the Dockerfile, run the image behind HTTPS on a public URL and redeploy on push. The same account also gives you a managed Parse Server with a database, REST and GraphQL APIs and Cloud Code, for when the Flutter app needs a backend. Documentation: [https://www.back4app.com/docs-containers?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app](https://www.back4app.com/docs-containers?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app) · [https://www.back4app.com/docs?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app](https://www.back4app.com/docs?utm_source=github&utm_medium=repo&utm_campaign=flutter-web-on-back4app).

## License

MIT.
