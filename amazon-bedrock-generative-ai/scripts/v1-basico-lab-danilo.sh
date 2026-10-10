#!/bin/bash

# V1 - Chatbot Básico com Converse API
# Laboratório Danilo — Estudos de IA e Amazon Bedrock
# Demonstra o uso apenas do system prompt (tudo em um lugar)

# Configurar profile AWS
export AWS_PROFILE='DIGITE AQUI SEU PROFILE AWS'
# Exemplo: export AWS_PROFILE=seattle

# Usar inference profile (cross-region) - prefixo "us."
MODEL_ID="ADICIONE AQUI O MODELO DA SUA IA"
REGION="us-east-1"

# Exemplo: MODEL_ID="us.anthropic.claude-sonnet-4-5-20250929-v1:0"

# System prompt: comportamento + contexto (tudo junto na V1)
# Contexto: assistente do laboratório pessoal de estudos de IA/Bedrock do Danilo
COMPORTAMENTO="COMPORTE-SE COMO UM ASSISTENTE TÉCNICO DE ESTUDOS DE IA NA AWS. \nVocê auxilia o Danilo no seu laboratório pessoal de estudos de Amazon Bedrock e IA generativa.\nLimite-se a falar sobre os tópicos do laboratório: Amazon Bedrock, LLMs, RAG, Agentes e Guardrails.\nO laboratório cobre desde o primeiro converse via CLI até assistentes com RAG, tools e guardrails."
CONTEXTO="O que posso estudar neste laboratório de Amazon Bedrock?"
SYSTEM_PROMPT="$COMPORTAMENTO. $CONTEXTO"

echo "🤖 Assistente do Lab Danilo - V1 Básico (Converse API)"
echo "======================================================="
echo ""
echo "📝 System Prompt: $SYSTEM_PROMPT"
echo ""
echo "⏳ Enviando para o Bedrock..."
echo ""

# Invocar Bedrock usando Converse API
# User message é apenas "Olá" (dummy) - tudo está no system
RESPONSE=$(aws bedrock-runtime converse \
  --region $REGION \
  --model-id $MODEL_ID \
  --system "[{\"text\":\"$SYSTEM_PROMPT\"}]" \
  --messages '[{"role":"user","content":[{"text":"Olá"}]}]' \
  --inference-config '{"maxTokens":512,"temperature":0.7}' \
  --output json)

# Extrair resposta
ASSISTANT_RESPONSE=$(echo $RESPONSE | jq -r '.output.message.content[0].text')

echo "🧠 Assistente:"
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
