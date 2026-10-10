# Laboratório Danilo — Referências e boas práticas

Este documento reúne as principais referências técnicas usadas no laboratório e boas práticas adotadas nos estudos e experimentos.

## Documentação oficial

- [Amazon Bedrock — User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html)
- [Amazon Bedrock — API Reference](https://docs.aws.amazon.com/bedrock/latest/APIReference/welcome.html)
- [AWS SDK for JavaScript v3](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/)
- [Anthropic — Prompt Engineering Guide](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview)
- [Anthropic — Claude Model Overview](https://docs.anthropic.com/en/docs/about-claude/models/overview)

## Boas práticas adotadas neste laboratório

### Segurança
- Credenciais AWS gerenciadas via perfis (`~/.aws/credentials`), nunca hardcoded
- Roles IAM com princípio do menor privilégio
- Dados sensíveis armazenados no Secrets Manager ou Parameter Store

### Custo
- Monitoramento de tokens consumidos por experimento
- Uso de cache de prompt onde aplicável para reduzir custo
- Preferência por modelos menores em testes e prototipação

### Qualidade de prompt
- System prompt explícito em todas as chamadas
- Separação clara entre instrução e dado
- Testes com diferentes temperaturas para avaliar consistência

### Organização do código
- Scripts organizados por versão/etapa em `scripts/sdk-node/`
- Variáveis de ambiente via `.env` (nunca commitadas)
- README por projeto com objetivo, pré-requisitos e como executar

## Redes

- **GitHub** — [github.com/drlima85/AWS-CLOUD-PROJECTS](https://github.com/drlima85/AWS-CLOUD-PROJECTS)
- **LinkedIn** — [linkedin.com/in/danilo-lima-9ba0375a](https://www.linkedin.com/in/danilo-lima-9ba0375a/)
