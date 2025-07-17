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

msg_invalid_json_en="Invalid response (not JSON):"
msg_invalid_json_ru="Некорректный ответ (не JSON):"
msg_invalid_json_de="Ungültige Antwort (kein JSON):"
msg_invalid_json_fr="Réponse invalide (pas du JSON):"
msg_invalid_json_es="Respuesta no válida (no es JSON):"
msg_invalid_json_zh="无效响应（不是 JSON）："
msg_invalid_json_pt="Resposta inválida (não é JSON):"

msg_function_added_en="Function added to"
msg_function_added_ru="Функция добавлена в"
msg_function_added_de="Funktion hinzugefügt zu"
msg_function_added_fr="Fonction ajoutée à"
msg_function_added_es="Función añadida a"
msg_function_added_zh="函数已添加到"
msg_function_added_pt="Função adicionada a"

msg_restart_shell_en="Restart your terminal or run 'source' to use it."
msg_restart_shell_ru="Перезапустите терминал или выполните 'source', чтобы использовать."
msg_restart_shell_de="Starten Sie Ihr Terminal neu oder führen Sie 'source' aus, um es zu verwenden."
msg_restart_shell_fr="Redémarrez votre terminal ou exécutez 'source' pour l'utiliser."
msg_restart_shell_es="Reinicie su terminal o ejecute 'source' para usarlo."
msg_restart_shell_zh="重新启动终端或运行 'source' 以使用。"
msg_restart_shell_pt="Reinicie seu terminal ou execute 'source' para usar."

msg_function_exists_en="Function already exists in"
msg_function_exists_ru="Функция уже существует в"
msg_function_exists_de="Funktion existiert bereits in"
msg_function_exists_fr="La fonction existe déjà dans"
msg_function_exists_es="La función ya existe en"
msg_function_exists_zh="函数已存在于"
msg_function_exists_pt="A função já existe em"

msg_skipping_en=", skipping."
msg_skipping_ru=", пропускаем."
msg_skipping_de=", wird übersprungen."
msg_skipping_fr=", ignoré."
msg_skipping_es=", omitiendo."
msg_skipping_zh=", 跳过。"
msg_skipping_pt=", pulando."

msg_check_projects_en="Check out our other projects:"
msg_check_projects_ru="Посмотрите другие наши проекты:"
msg_check_projects_de="Schauen Sie sich unsere anderen Projekte an:"
msg_check_projects_fr="Découvrez nos autres projets :"
msg_check_projects_es="Mira nuestros otros proyectos:"
msg_check_projects_zh="查看我们的其他项目："
msg_check_projects_pt="Confira nossos outros projetos:"

# Remove all msg_website_* variables
# Add a single constant
WEBSITE_URL="https://api.langie.uk"

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
  echo "❌ $(msg msg_invalid_json)"
  exit 1
fi

DOWNLOAD_URL=$(echo "$RAW_JSON" | jq -r '.downloadUrl')

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

# Unified shell config messages
msg_shell_func_added_en="Cursor function added to"
msg_shell_func_added_ru="Функция Cursor добавлена в"
msg_shell_func_added_de="Cursor-Funktion hinzugefügt zu"
msg_shell_func_added_fr="Fonction Cursor ajoutée à"
msg_shell_func_added_es="Función Cursor añadida a"
msg_shell_func_added_zh="Cursor 函数已添加到"
msg_shell_func_added_pt="Função Cursor adicionada a"

msg_shell_func_exists_en="Cursor function already exists in"
msg_shell_func_exists_ru="Функция Cursor уже существует в"
msg_shell_func_exists_de="Cursor-Funktion existiert bereits in"
msg_shell_func_exists_fr="La fonction Cursor existe déjà dans"
msg_shell_func_exists_es="La función Cursor ya existe en"
msg_shell_func_exists_zh="Cursor 函数已存在于"
msg_shell_func_exists_pt="A função Cursor já existe em"

msg_shell_restart_en="Restart your terminal or run 'source' to use it."
msg_shell_restart_ru="Перезапустите терминал или выполните 'source', чтобы использовать."
msg_shell_restart_de="Starten Sie Ihr Terminal neu oder führen Sie 'source' aus, um es zu verwenden."
msg_shell_restart_fr="Redémarrez votre terminal ou exécutez 'source' pour l'utiliser."
msg_shell_restart_es="Reinicie su terminal o ejecute 'source' para usarlo."
msg_shell_restart_zh="重新启动终端或运行 'source' 以使用。"
msg_shell_restart_pt="Reinicie seu terminal ou execute 'source' para usar."

msg_shell_skipping_en=", skipping."
msg_shell_skipping_ru=", пропускаем."
msg_shell_skipping_de=", wird übersprungen."
msg_shell_skipping_fr=", ignoré."
msg_shell_skipping_es=", omitiendo."
msg_shell_skipping_zh=", 跳过。"
msg_shell_skipping_pt=", pulando."

msg_shell_func_add_start_en="Adding Cursor function to your shell config..."
msg_shell_func_add_start_ru="Добавление функции Cursor в ваш shell-конфиг..."
msg_shell_func_add_start_de="Füge die Cursor-Funktion zu deiner Shell-Konfiguration hinzu..."
msg_shell_func_add_start_fr="Ajout de la fonction Cursor à votre configuration shell..."
msg_shell_func_add_start_es="Agregando la función Cursor a tu configuración de shell..."
msg_shell_func_add_start_zh="正在将 Cursor 函数添加到您的 shell 配置..."
msg_shell_func_add_start_pt="Adicionando a função Cursor à sua configuração do shell..."

# Add cursor() to shell config
echo "🔧 $(msg msg_shell_func_add_start)"

if [[ -n "${ZSH_VERSION:-}" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ -n "${BASH_VERSION:-}" ]]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.bashrc" # default fallback
fi

# Add only if not present
if ! grep -qE '^\s*(function\s+)?cursor\s*\(\)' "$SHELL_RC"; then
  cat <<EOF >> "$SHELL_RC"

# Launch Cursor with background process
cursor() {
  nohup "$APP_PATH" --no-sandbox "\$@" >/dev/null 2>&1 &
}
EOF
  echo "✅ $(msg msg_shell_func_added) $SHELL_RC. $(msg msg_shell_restart)"
else
  echo "ℹ️ $(msg msg_shell_func_exists) $SHELL_RC$(msg msg_shell_skipping)"
fi

echo ""
echo "🚀 $(msg msg_check_projects)"
echo "🌐 $WEBSITE_URL"

# After icon install
if command -v gtk-update-icon-cache &>/dev/null; then
  gtk-update-icon-cache "$HOME/.local/share/icons" || true
fi
