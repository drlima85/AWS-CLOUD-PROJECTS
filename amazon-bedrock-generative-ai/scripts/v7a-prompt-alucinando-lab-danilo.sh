#!/bin/bash

# V7a - Técnicas de Prompt: System Prompt que ALUCINA
# Laboratório Danilo — Estudos de IA e Amazon Bedrock
# Demonstra o problema: sem regra explícita, o modelo inventa informações

export AWS_PROFILE='DIGITE AQUI SEU PROFILE AWS'
MODEL_ID="ADICIONE AQUI O MODELO DA SUA IA"
REGION="us-east-1"

# System prompt SIMPLES — sem proteção contra alucinação
# Contexto: assistente de estudos do laboratório do Danilo
SYSTEM_PROMPT="Você é o assistente do laboratório de estudos de IA do Danilo.
Tom: técnico, didático, direto. Respostas curtas (máximo 30 palavras).

Tópicos cobertos no laboratório:
- Amazon Bedrock: converse API, streaming, cache de prompt
- RAG com Knowledge Base e OpenSearch Serverless
- Guardrails: filtros de conteúdo e proteção de PII"

# Pergunta que vai causar alucinação — tópico fora do escopo do lab
USER_MESSAGE="Qual o preço do Amazon Bedrock para 1 milhão de tokens com o modelo Claude Opus 5?"

echo "🤖 V7a - Prompt que ALUCINA"
echo "============================"
echo ""
echo "📄 System prompt SEM proteção contra alucinação"
echo ""
echo "👤 User: $USER_MESSAGE"
echo ""
echo "⏳ Enviando para o Bedrock..."
echo ""

SYSTEM_JSON=$(jq -n --arg text "$SYSTEM_PROMPT" '[{text: $text}]')
MESSAGES_JSON=$(jq -n --arg text "$USER_MESSAGE" '[{role: "user", content: [{text: $text}]}]')

RESPONSE=$(aws bedrock-runtime converse \
  --region $REGION \
  --model-id $MODEL_ID \
  --system "$SYSTEM_JSON" \
  --messages "$MESSAGES_JSON" \
  --inference-config '{"maxTokens":256,"temperature":0.7}' \
  --output json)

ASSISTANT_RESPONSE=$(echo $RESPONSE | jq -r '.output.message.content[0].text')

echo "🧠 Assistente:"
echo "$ASSISTANT_RESPONSE"
echo ""
echo "⚠️  PROBLEMA: O modelo provavelmente inventou um preço que NÃO está no system prompt."
echo "   Preços de modelos mudam e não foram fornecidos — isso é uma ALUCINAÇÃO."
echo ""
echo "👉 Agora rode o v7b-prompt-corrigido-danilo.sh para ver a correção."
