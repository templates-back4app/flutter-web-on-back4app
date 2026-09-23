# Flutter Web on Back4app

A Flutter web app, containerised and deployed on Back4app Containers — the free
path to hosting a Flutter build in 2026.

**Measured on 23 September 2026:** `flutter build web --release` compiled in
**17 seconds** locally, and the container image builds the same output from a
pinned Flutter 3.47.5 SDK and serves it with nginx.

Read the article: — link added at publication.

## What is in here

| File | Why |
|---|---|
| `lib/main.dart` | A counter page that prints the `BUILD_STAMP` compiled into it, so you can prove which build is being served |
| `Dockerfile` | Two stages: Flutter 3.47.5 pinned from Google's release storage compiles the web build; nginx serves it. The SDK never ships in the running image |
| `nginx.conf` | SPA fallback to `index.html`, `no-store` on `index.html`, long cache on hashed assets |

## Deploy your own

1. Create a free account at https://www.back4app.com/signup
2. Fork this repository
3. In the dashboard, open **Web Deployment → Deploy a Web App → GitHub repository**
4. Pick your fork, leave the Dockerfile path as the repository root, and deploy
5. Open the URL it gives you and check the build stamp

The stamp is computed inside the image build. Back4app Containers has no field
for Docker build arguments, so a value passed from the dashboard would never
reach `--dart-define`; computing it in the `RUN` step means it is always the
real build moment.

## Run it locally

```
flutter build web --release --dart-define=BUILD_STAMP="$(date -u +%Y-%m-%dT%H:%MZ)"
docker build -t flutter-web .
docker run --rm -p 8080:80 flutter-web
```

MIT licensed.
