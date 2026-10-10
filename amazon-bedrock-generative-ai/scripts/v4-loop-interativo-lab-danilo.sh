#!/bin/bash

# V4 - Loop Interativo com Histórico
# Laboratório Danilo — Estudos de IA e Amazon Bedrock
# Demonstra conversação contínua mantendo histórico de mensagens

# Configurar profile AWS
export AWS_PROFILE='DIGITE AQUI SEU PROFILE AWS'

# Usar inference profile (cross-region) - prefixo "us."
MODEL_ID="ADICIONE AQUI O MODELO DA SUA IA"
REGION="us-east-1"

# Ler system prompt de arquivo externo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEM_PROMPT=$(cat "$SCRIPT_DIR/prompt-valendo-lab-danilo.txt")
SYSTEM_JSON=$(jq -n --arg text "$SYSTEM_PROMPT" '[{text: $text}]')

# Inicializar histórico de mensagens vazio
MESSAGES_JSON='[]'

echo "🤖 Assistente do Lab Danilo - V4 Loop Interativo"
echo "=================================================="
echo ""
echo "📄 System prompt carregado de: prompt-valendo-lab-danilo.txt"
echo "💡 Digite 'sair' para encerrar"
echo ""

while true; do
  # Ler input do usuário
  echo -n "👤 Você: "
  read USER_INPUT

  # Verificar se quer sair
  if [[ "$USER_INPUT" == "sair" ]]; then
    echo "👋 Até logo! Bons estudos."
    break
  fi

  # Adicionar mensagem do usuário ao histórico
  MESSAGES_JSON=$(echo "$MESSAGES_JSON" | jq --arg text "$USER_INPUT" '. += [{role: "user", content: [{text: $text}]}]')

  # Invocar Bedrock
  RESPONSE=$(aws bedrock-runtime converse \
    --region $REGION \
    --model-id $MODEL_ID \
    --system "$SYSTEM_JSON" \
    --messages "$MESSAGES_JSON" \
    --inference-config '{"maxTokens":512,"temperature":0.7}' \
    --output json)

  # Extrair resposta do assistente
  ASSISTANT_RESPONSE=$(echo $RESPONSE | jq -r '.output.message.content[0].text')

  # Adicionar resposta do assistente ao histórico
  MESSAGES_JSON=$(echo "$MESSAGES_JSON" | jq --arg text "$ASSISTANT_RESPONSE" '. += [{role: "assistant", content: [{text: $text}]}]')

  # Mostrar resposta
  echo ""
  echo "🧠 Assistente:"
  echo "$ASSISTANT_RESPONSE"
  echo ""

  # Métricas (opcional, descomente para depuração)
  # INPUT_TOKENS=$(echo $RESPONSE | jq -r '.usage.inputTokens')
  # OUTPUT_TOKENS=$(echo $RESPONSE | jq -r '.usage.outputTokens')
  # echo "📊 Tokens: $INPUT_TOKENS in / $OUTPUT_TOKENS out"
  # echo ""
done
