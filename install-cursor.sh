#!/bin/bash
set -euo pipefail

# Language detection (default: en)
LANG_CODE="${LANG:-en}"
case "$LANG_CODE" in
  ru*) L=ru ;;
  de*) L=de ;;
  fr*) L=fr ;;
  es*) L=es ;;
  zh*) L=zh ;;
  pt*) L=pt ;;
  *)   L=en ;;
esac

# Messages (icons removed)
msg_fetch_link_en="Fetching Cursor download link..."
msg_fetch_link_ru="Получаем ссылку для скачивания Cursor..."
msg_fetch_link_de="Cursor-Download-Link wird abgerufen..."
msg_fetch_link_fr="Récupération du lien de téléchargement de Cursor..."
msg_fetch_link_es="Obteniendo enlace de descarga de Cursor..."
msg_fetch_link_zh="获取 Cursor 下载链接..."
msg_fetch_link_pt="Obtendo link de download do Cursor..."

msg_fail_link_en="Failed to get download link."
msg_fail_link_ru="Не удалось получить ссылку для скачивания."
msg_fail_link_de="Download-Link konnte nicht abgerufen werden."
msg_fail_link_fr="Échec de l'obtention du lien de téléchargement."
msg_fail_link_es="No se pudo obtener el enlace de descarga."
msg_fail_link_zh="获取下载链接失败。"
msg_fail_link_pt="Falha ao obter o link de download."

msg_downloading_en="Downloading latest Cursor version..."
msg_downloading_ru="Скачиваем последнюю версию Cursor..."
msg_downloading_de="Lade neueste Cursor-Version herunter..."
msg_downloading_fr="Téléchargement de la dernière version de Cursor..."
msg_downloading_es="Descargando la última versión de Cursor..."
msg_downloading_zh="正在下载最新的 Cursor 版本..."
msg_downloading_pt="Baixando a versão mais recente do Cursor..."

msg_file_empty_en="Downloaded file is empty."
msg_file_empty_ru="Скачанный файл пустой."
msg_file_empty_de="Die heruntergeladene Datei ist leer."
msg_file_empty_fr="Le fichier téléchargé est vide."
msg_file_empty_es="El archivo descargado está vacío."
msg_file_empty_zh="下载的文件为空。"
msg_file_empty_pt="O arquivo baixado está vazio."

msg_not_appimage_en="File does not look like an AppImage."
msg_not_appimage_ru="Файл не похож на AppImage."
msg_not_appimage_de="Datei sieht nicht wie eine AppImage aus."
msg_not_appimage_fr="Le fichier ne ressemble pas à une AppImage."
msg_not_appimage_es="El archivo no parece ser un AppImage."
msg_not_appimage_zh="文件看起来不像 AppImage。"
msg_not_appimage_pt="O arquivo não parece ser um AppImage."

msg_installing_en="Installing Cursor to"
msg_installing_ru="Устанавливаем Cursor в"
msg_installing_de="Installiere Cursor nach"
msg_installing_fr="Installation de Cursor dans"
msg_installing_es="Instalando Cursor en"
msg_installing_zh="正在安装 Cursor 到"
msg_installing_pt="Instalando Cursor em"

msg_icon_en="Downloading Cursor SVG icon..."
msg_icon_ru="Скачиваем SVG‑иконку Cursor..."
msg_icon_de="Lade Cursor SVG-Icon herunter..."
msg_icon_fr="Téléchargement de l'icône SVG de Cursor..."
msg_icon_es="Descargando el icono SVG de Cursor..."
msg_icon_zh="正在下载 Cursor SVG 图标..."
msg_icon_pt="Baixando o ícone SVG do Cursor..."

msg_icon_fail_en="Failed to download icon"
msg_icon_fail_ru="Не удалось скачать иконку"
msg_icon_fail_de="Symbol konnte nicht heruntergeladen werden"
msg_icon_fail_fr="Échec du téléchargement de l'icône"
msg_icon_fail_es="No se pudo descargar el icono"
msg_icon_fail_zh="图标下载失败"
msg_icon_fail_pt="Falha ao baixar o ícone"

msg_launcher_en="Updating launcher"
msg_launcher_ru="Обновляем ярлык"
msg_launcher_de="Launcher wird aktualisiert"
msg_launcher_fr="Mise à jour du lanceur"
msg_launcher_es="Actualizando el lanzador"
msg_launcher_zh="正在更新启动器"
msg_launcher_pt="Atualizando o lançador"

msg_cache_en="Updating local applications cache..."
msg_cache_ru="Обновляем кэш приложений (локально)..."
msg_cache_de="Aktualisiere lokalen Anwendungscache..."
msg_cache_fr="Mise à jour du cache des applications locales..."
msg_cache_es="Actualizando la caché de aplicaciones locales..."
msg_cache_zh="正在更新本地应用缓存..."
msg_cache_pt="Atualizando o cache de aplicativos locais..."

msg_cleanup_en="Cleaning up temporary files"
msg_cleanup_ru="Удаляем временное"
msg_cleanup_de="Bereinige temporäre Dateien"
msg_cleanup_fr="Nettoyage des fichiers temporaires"
msg_cleanup_es="Limpiando archivos temporales"
msg_cleanup_zh="清理临时文件"
msg_cleanup_pt="Limpando arquivos temporários"

msg_success_en="Cursor installed at"
msg_success_ru="Cursor установлен в"
msg_success_de="Cursor installiert in"
msg_success_fr="Cursor installé dans"
msg_success_es="Cursor instalado en"
msg_success_zh="Cursor 已安装在"
msg_success_pt="Cursor instalado em"

msg_ready_en="and ready to use!"
msg_ready_ru="и готов к использованию!"
msg_ready_de="und ist einsatzbereit!"
msg_ready_fr="et prêt à l'emploi !"
msg_ready_es="y listo para usar!"
msg_ready_zh="，可以使用！"
msg_ready_pt="e pronto para usar!"

# Helper to echo message or fallback to English
function msg() {
  local key="$1"
  local var="${key}_$L"
  local fallback="${key}_en"
  echo "${!var:-${!fallback}}"
}

# Paths and constants
APP_DIR="$HOME/.local/bin"
APP_NAME="cursor.AppImage"
APP_PATH="$APP_DIR/$APP_NAME"
DESKTOP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$DESKTOP_DIR/cursor.desktop"
ICON_URL="https://static.cdnlogo.com/logos/c/23/cursor.svg"
ICON_PATH="$HOME/.local/share/icons/cursor.svg"
API_URL="https://cursor.com/api/download?platform=linux-x64&releaseTrack=stable"
TMP_DIR="$(mktemp -d)"

mkdir -p "$APP_DIR" "$DESKTOP_DIR" "$(dirname "$ICON_PATH")"

# Fetch download link
echo "⬇️ $(msg msg_fetch_link)"

RAW_JSON=$(curl -fsSL "$API_URL" || echo "")
if [[ -z "$RAW_JSON" ]]; then
  echo "❌ $(msg msg_fail_link)"
  exit 1
fi

if ! echo "$RAW_JSON" | jq empty &>/dev/null; then
  echo "❌ Invalid response (not JSON):"
  echo "$RAW_JSON"
  exit 1
fi

DOWNLOAD_URL=$(curl -s -H "User-Agent: Mozilla" "$API_URL" | jq -r '.downloadUrl')

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "❌ $(msg msg_fail_link)"
  exit 1
fi

# Download AppImage
echo "📥 $(msg msg_downloading)"
curl -fL -o "$TMP_DIR/$APP_NAME" "$DOWNLOAD_URL"

# File check
if [[ ! -s "$TMP_DIR/$APP_NAME" ]]; then
  echo "❌ $(msg msg_file_empty)"
  exit 1
fi

if ! file "$TMP_DIR/$APP_NAME" | grep -q "AppImage"; then
  echo "❌ $(msg msg_not_appimage)"
  exit 1
fi

# Install
echo "🔄 $(msg msg_installing) $APP_PATH..."
chmod +x "$TMP_DIR/$APP_NAME"
mv "$TMP_DIR/$APP_NAME" "$APP_PATH"

# Icon
echo "🖼 $(msg msg_icon)"
if [[ ! -f "$ICON_PATH" ]]; then
  curl -fL -o "$ICON_PATH" "$ICON_URL" || echo "⚠️ $(msg msg_icon_fail)"
fi

# .desktop file
echo "🖇 $(msg msg_launcher) $DESKTOP_FILE..."
tee "$DESKTOP_FILE" > /dev/null <<EOF
[Desktop Entry]
Name=Cursor AI
Exec=$APP_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;
Terminal=false
EOF

echo "🔃 $(msg msg_cache)"
command -v update-desktop-database &>/dev/null && update-desktop-database "$HOME/.local/share/applications" || true

# Cleanup
echo "🧹 $(msg msg_cleanup)"
rm -rf "$TMP_DIR"

# Done
echo "✅ $(msg msg_success) $APP_PATH $(msg msg_ready)"

# Add cursor() to shell config
echo "🔧 Adding cursor() function to your shell config..."

if [[ -n "${ZSH_VERSION:-}" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ -n "${BASH_VERSION:-}" ]]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.bashrc" # default fallback
fi

# Add only if not present
if ! grep -q 'function cursor()' "$SHELL_RC"; then
  cat <<EOF >> "$SHELL_RC"

# Launch Cursor with background process
cursor() {
  nohup "$APP_PATH" --no-sandbox "\$@" >/dev/null 2>&1 &
}
EOF
  echo "✅ Function added to $SHELL_RC. Restart your terminal or run 'source $SHELL_RC' to use it."
else
  echo "ℹ️ Function already exists in $SHELL_RC, skipping."
fi


echo ""
echo "🚀 Check out our other projects:"
echo "🌐 https://api.langie.uk"
