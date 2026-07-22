---
author: Danilo Lima
tags:
- AWS
- ECS
- ALB
- CI/CD
- HTTPS
- HighAvailability
title: Imersão AWS & IA — Dia 2 — Alta Disponibilidade, ALB e CI/CD
---

# Imersão AWS & IA — Dia 2: Alta Disponibilidade, ALB e CI/CD

> Desafio prático guiado, realizado durante o evento **Imersão AWS & IA**,
> conduzido por [Henrylle Maia](https://www.linkedin.com/in/henrylle/).

------------------------------------------------------------------------

## 🎯 Objetivo do Dia 2

Evoluir a aplicação do [Dia 1](../aws-ecs-ecr-rds-lab) para rodar em
Alta Disponibilidade na AWS, com deploy contínuo sem downtime e acesso
via domínio personalizado com HTTPS.

------------------------------------------------------------------------

## 🚀 Atividades Realizadas

- Execução de uma aplicação Node.js com React em Alta Disponibilidade no ECS
- Deploy sem downtime (zero-downtime deployment) usando ECS
- Configuração de **Application Load Balancer (ALB)** e **Target Group**
  para distribuição de tráfego entre as instâncias da aplicação
- Construção de um pipeline **CI/CD** na AWS: push no branch `main`
  dispara o deploy automaticamente
- Configuração de domínio personalizado com **HTTPS** para a aplicação

------------------------------------------------------------------------

## ☁️ Tecnologias

Amazon ECS · Application Load Balancer (ALB) · Target Group · CI/CD ·
Node.js · React · HTTPS / Certificados · DNS (domínio personalizado)

------------------------------------------------------------------------

## 🎯 Competências Demonstradas

- Arquitetura de Alta Disponibilidade em containers (ECS)
- Deploy contínuo sem downtime
- Balanceamento de carga com ALB e Target Groups
- Pipeline CI/CD acionado por push em branch
- Configuração de domínio próprio com HTTPS

------------------------------------------------------------------------

## 👨‍💻 Autor

**Danilo Lima**

Lab realizado durante a Imersão AWS & IA, conduzida por
[Henrylle Maia](https://www.linkedin.com/in/henrylle/).
