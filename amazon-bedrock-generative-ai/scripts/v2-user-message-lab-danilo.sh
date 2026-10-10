#!/bin/bash

# V2 - Separação: System + User Message
# Laboratório Danilo — Estudos de IA e Amazon Bedrock
# Demonstra a separação correta entre comportamento (system) e contexto (user)

# Configurar profile AWS
export AWS_PROFILE='DIGITE AQUI SEU PROFILE AWS'

# Usar inference profile (cross-region) - prefixo "us."
MODEL_ID="ADICIONE AQUI O MODELO DA SUA IA"
REGION="us-east-1"

# System prompt: apenas o comportamento do assistente
SYSTEM_PROMPT="COMPORTE-SE COMO UM ASSISTENTE TÉCNICO DE ESTUDOS DE IA NA AWS. \nVocê auxilia o Danilo no seu laboratório pessoal de estudos de Amazon Bedrock e IA generativa.\nLimite-se a falar sobre os tópicos do laboratório: Amazon Bedrock, LLMs, RAG, Agentes e Guardrails.\nLimite sua resposta a 40 palavras. \nEvite o uso de emojis e use um tom técnico e didático nas mensagens."

# User message: a mensagem real do usuário
USER_MESSAGE="O que é RAG e como ele funciona com o Amazon Bedrock?"

echo "🤖 Assistente do Lab Danilo - V2 User Message"
echo "==============================================="
echo ""
echo "📝 System (comportamento):"
echo -e "$SYSTEM_PROMPT"
echo ""
echo "💬 User (mensagem):"
echo "$USER_MESSAGE"
echo ""
echo "⏳ Enviando para o Bedrock..."
echo ""

# Criar JSON do system usando jq (mais seguro)
SYSTEM_JSON=$(jq -n --arg text "$SYSTEM_PROMPT" '[{text: $text}]')

# Criar JSON das messages usando jq
MESSAGES_JSON=$(jq -n --arg text "$USER_MESSAGE" '[{role: "user", content: [{text: $text}]}]')

# Invocar Bedrock usando Converse API
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
