# Stack: Flutter 3.47.5 (web) + nginx 1.27 | File: Dockerfile
# Two stages, so the ~4 GB Flutter SDK never reaches the image that runs.
# The SDK is pinned to an exact version and pulled from Google's own release
# storage, so the build does not drift when a new stable ships.
FROM debian:bookworm-slim AS build

ARG FLUTTER_VERSION=3.47.5
ENV PATH="/opt/flutter/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
      curl ca-certificates git unzip xz-utils \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" \
      -o /tmp/flutter.tar.xz \
 && tar xf /tmp/flutter.tar.xz -C /opt \
 && rm /tmp/flutter.tar.xz \
 && git config --global --add safe.directory /opt/flutter \
 && flutter --version

WORKDIR /app
# Dependencies first, so this layer is reused while only lib/ changes.
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .
ARG BUILD_STAMP=unset
RUN flutter build web --release --dart-define=BUILD_STAMP="${BUILD_STAMP}"

FROM nginx:1.27-alpine
COPY --from=build /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
