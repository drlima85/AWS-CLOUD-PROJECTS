# Laboratório Danilo — Roteiro de estudos de IA e Bedrock

Este documento descreve o roteiro de estudos seguido neste laboratório, organizado por etapas temáticas.

## Etapa 1 — Fundamentos de IA generativa na AWS

- O que são LLMs e como funcionam
- Modelos disponíveis no Amazon Bedrock (Claude, Titan, Llama, Mistral, etc.)
- Tokens: o que são, como são cobrados, como otimizar
- Estrutura de um prompt: system prompt, messages, tools
- Técnicas de prompt engineering: zero-shot, few-shot, chain-of-thought
- Parâmetros de inferência: temperatura, top_p, top_k, max_tokens
- Primeiro `converse` via AWS CLI

## Etapa 2 — Recursos do Amazon Bedrock

- Streaming de respostas em tempo real
- Cache de prompt (redução de custo e latência)
- Knowledge Bases: criação e integração com banco vetorial
- OpenSearch Serverless como store vetorial
- Guardrails: filtros de conteúdo, tópicos negados, proteção de PII
- Avaliação de modelos (Model Evaluation)

## Etapa 3 — Integração via SDK

- Configuração do ambiente Node.js com AWS SDK v3
- Chamadas ao Bedrock Runtime com `@aws-sdk/client-bedrock-runtime`
- Tratamento de streaming com `AsyncIterable`
- Integração com Knowledge Base via SDK
- Aplicação de Guardrails programaticamente

## Etapa 4 — Agentes de IA

- Conceito de agentes e Action Groups
- Integração de agentes com funções Lambda
- Orquestração multi-agentes
- MCP Servers especializados por agente
- Projeto prático de agente completo

## Etapa 5 — Projeto final integrado

- Assistente com RAG, tools e guardrails
- Deploy com infraestrutura AWS (ECS, Lambda, S3, OpenSearch)
- Monitoramento com CloudWatch
- Boas práticas de segurança (IAM, Secrets Manager)

## Redes

- **GitHub** — [github.com/drlima85/AWS-CLOUD-PROJECTS](https://github.com/drlima85/AWS-CLOUD-PROJECTS)
- **LinkedIn** — [linkedin.com/in/danilo-lima-9ba0375a](https://www.linkedin.com/in/danilo-lima-9ba0375a/)
