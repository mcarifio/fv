# eget ollama/ollama
# brew install ollama

guard command ollama; or return 0
mkdir -p ~/.config/ollama/models
set -Ux OLLAMA_MODELS "$HOME/.config/ollama/models"




