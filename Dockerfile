FROM debian:bookworm-slim AS build
ARG GODOT_VERSION=4.3
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl unzip libfontconfig1 libgl1 libx11-6 libxcursor1 libxinerama1 libxrandr2 libxi6 libasound2 libpulse0 && rm -rf /var/lib/apt/lists/*
RUN curl -fL --retry 3 -o /tmp/godot.zip "https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip" \
    && unzip /tmp/godot.zip -d /usr/local/bin \
    && mv /usr/local/bin/Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot \
    && chmod +x /usr/local/bin/godot \
    && mkdir -p /root/.local/share/godot/export_templates/${GODOT_VERSION}.stable \
    && curl -fL --retry 3 -o /tmp/templates.zip "https://code.ultrablob.me/ultrablob/godot-export-template-web-only/releases/download/${GODOT_VERSION}-stable/godot-${GODOT_VERSION}-web-only.tpz" \
    && unzip /tmp/templates.zip -d /root/.local/share/godot/export_templates/${GODOT_VERSION}.stable \
    && rm /tmp/godot.zip /tmp/templates.zip
WORKDIR /game
COPY . .
RUN sed -i '/^version_control\//d' project.godot && godot --headless --editor --import && mkdir -p /export && godot --headless --export-release Web /export/index.html

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /export/ /usr/share/nginx/html/
EXPOSE 80
