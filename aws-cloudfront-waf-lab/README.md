---
author: Danilo Lima
tags:
- AWS
- CloudFront
- WAF
- CDN
- Security
title: Imersão AWS & IA — Dia 3 — CloudFront, WAF e Segurança de Borda
---

# Imersão AWS & IA — Dia 3: CloudFront, WAF e Segurança de Borda

> Desafio adicional, realizado durante o evento **Imersão AWS & IA**,
> conduzido por [Henrylle Maia](https://www.linkedin.com/in/henrylle/).

------------------------------------------------------------------------

## 🎯 Objetivo do Dia 3

A partir da aplicação em Alta Disponibilidade construída no
[Dia 2](../aws-ha-cicd-alb-lab), adicionar uma camada de performance
(CDN) e segurança de borda, protegendo a aplicação antes que o tráfego
malicioso chegue às instâncias.

------------------------------------------------------------------------

## 🚀 Atividades Realizadas

- Configuração do **Amazon CloudFront** como CDN à frente do Application
  Load Balancer, adicionando cache e melhoria de performance de entrega
- Proteção do **Application Load Balancer (ALB)** com configurações
  estratégicas de **Security Group**, restringindo o acesso direto
- Implementação do **AWS WAF (Web Application Firewall)** na CDN, para
  mitigar e conter ataques na borda antes que atinjam a aplicação

------------------------------------------------------------------------

## ☁️ Tecnologias

Amazon CloudFront · AWS WAF · Application Load Balancer (ALB) ·
Security Groups (AWS)

------------------------------------------------------------------------

## 🎯 Competências Demonstradas

- Arquitetura de CDN com Amazon CloudFront
- Segurança de borda (edge security) com AWS WAF
- Hardening de Load Balancer via Security Groups
- Defesa em profundidade (defense in depth) em arquiteturas web na AWS

------------------------------------------------------------------------

## 👨‍💻 Autor

**Danilo Lima**

Lab realizado durante a Imersão AWS & IA, conduzida por
[Henrylle Maia](https://www.linkedin.com/in/henrylle/) e equipe.
