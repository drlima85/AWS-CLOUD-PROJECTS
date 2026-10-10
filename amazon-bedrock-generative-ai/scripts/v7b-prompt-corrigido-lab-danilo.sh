#!/bin/bash

# V7b - Técnicas de Prompt: System Prompt CORRIGIDO
# Laboratório Danilo — Estudos de IA e Amazon Bedrock
# Demonstra a solução: constraints + grounding + fallback behavior

export AWS_PROFILE='DIGITE AQUI SEU PROFILE AWS'
MODEL_ID="ADICIONE AQUI O MODELO DA SUA IA"
REGION="us-east-1"

# System prompt COM proteção contra alucinação (constraints + grounding + fallback)
SYSTEM_PROMPT="Você é o assistente do laboratório de estudos de IA do Danilo.
Tom: técnico, didático, direto. Respostas curtas (máximo 30 palavras).

Tópicos cobertos no laboratório:
- Amazon Bedrock: converse API, streaming, cache de prompt
- RAG com Knowledge Base e OpenSearch Serverless
- Guardrails: filtros de conteúdo e proteção de PII

REGRA CRÍTICA: NUNCA invente preços, valores, datas ou informações que não estejam EXPLICITAMENTE escritos acima. Se perguntarem sobre qualquer dado que não consta aqui, responda: \"Não tenho essa informação no contexto do laboratório. Consulte a documentação oficial em docs.aws.amazon.com/bedrock.\""

# Mesma pergunta do v7a
USER_MESSAGE="Qual o preço do Amazon Bedrock para 1 milhão de tokens com o modelo Claude Opus 5?"

echo "🤖 V7b - Prompt CORRIGIDO"
echo "=========================="
echo ""
echo "📄 System prompt COM proteção contra alucinação"
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
echo "✅ CORRIGIDO: O modelo agora recusa inventar dados e direciona para a fonte oficial."
echo ""
echo "📚 Técnicas usadas:"
echo "   1. Constraints  — regras rígidas do que NÃO fazer"
echo "   2. Grounding     — ancorar respostas apenas nos dados fornecidos"
echo "   3. Fallback      — comportamento padrão quando não sabe a resposta"
