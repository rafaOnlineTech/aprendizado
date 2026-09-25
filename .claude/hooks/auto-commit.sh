#!/bin/bash
# Faz commit e push automático após cada modificação de arquivo feita pelo Claude.
set -e
cd "$CLAUDE_PROJECT_DIR"

file=$(jq -r '.tool_input.file_path // .tool_input.notebook_path // empty')
rel=${file#"$CLAUDE_PROJECT_DIR"/}

git add -A
git diff --cached --quiet && exit 0

git commit -q -m "Atualiza ${rel:-arquivos}"
git push -q origin HEAD
