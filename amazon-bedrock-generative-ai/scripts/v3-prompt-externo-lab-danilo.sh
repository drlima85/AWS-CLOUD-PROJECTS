#!/bin/bash

# V3 - Prompt Externo
# Laboratório Danilo — Estudos de IA e Amazon Bedrock
# Demonstra leitura de system prompt de arquivo externo (mais legível e reutilizável)

# Configurar profile AWS
export AWS_PROFILE='DIGITE AQUI SEU PROFILE AWS'

# Usar inference profile (cross-region) - prefixo "us."
MODEL_ID="ADICIONE AQUI O MODELO DA SUA IA"
REGION="us-east-1"

# Ler system prompt de arquivo externo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEM_PROMPT=$(cat "$SCRIPT_DIR/system-prompt.txt")

# User message
USER_MESSAGE="Explique o que é o Amazon Bedrock e quais modelos estão disponíveis."

echo "🤖 Assistente do Lab Danilo - V3 Prompt Externo"
echo "================================================="
echo ""
echo "📄 System prompt carregado de: system-prompt.txt"
echo ""
echo "💬 User:"
echo "$USER_MESSAGE"
echo ""
echo "⏳ Enviando para o Bedrock..."
echo ""

# Criar JSON usando jq
SYSTEM_JSON=$(jq -n --arg text "$SYSTEM_PROMPT" '[{text: $text}]')
MESSAGES_JSON=$(jq -n --arg text "$USER_MESSAGE" '[{role: "user", content: [{text: $text}]}]')

# Invocar Bedrock
RESPONSE=$(aws bedrock-runtime converse \
  --region $REGION \
  --model-id $MODEL_ID \
  --system "$SYSTEM_JSON" \
  --messages "$MESSAGES_JSON" \
  --inference-config '{"maxTokens":512,"temperature":0.7}' \
  --output json)

# Extrair resposta
ASSISTANT_RESPONSE=$(echo $RESPONSE | jq -r '.output.message.content[0].text')

echo "Assistente:"
echo "$ASSISTANT_RESPONSE"
echo ""

# Métricas
INPUT_TOKENS=$(echo $RESPONSE | jq -r '.usage.inputTokens')
OUTPUT_TOKENS=$(echo $RESPONSE | jq -r '.usage.outputTokens')
TOTAL_TOKENS=$(echo $RESPONSE | jq -r '.usage.totalTokens')

echo "📊 Métricas:"
echo "  Input tokens: $INPUT_TOKENS"
echo "  Output tokens: $OUTPUT_TOKENS"
echo "  Total tokens: $TOTAL_TOKENS"
