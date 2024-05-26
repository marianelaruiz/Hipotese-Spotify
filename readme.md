
# 🎶 Hipóteses - Spotify 🎶

### **Tabela de conteudos**
- [🎶 Hipótese - Spotify 🎶](#-segmentacao-mercado)    
  - [**Introdução**](#introdução)
  - [**Objetivo**](#objetivo)
  - [**Equipe**](#equipe)
  - [**Ficha Técnica**](#ficha-tecnica)
  - [**Fontes de dados**](#fonte-de-dados)
  - [**Ferramentas e Tecnologias**](#ferramentas-e-tecnologias)
  - [**Processamento e análises**](#rocessamento-e-análises)
  - [**Resultados e Conclusões**](#Resultados-e-Conclusões) 
  - [**Google Sheets Dashboard**](#google-sheets-dashboard)
  -[**Referências:**](#referências)
   

---

## 📖 **Introdução**

Num mundo onde a indústria musical é extremamente competitiva e em constante evolução, a capacidade de tomar decisões baseadas em dados tornou-se um ativo inestimável.

Neste contexto, uma gravadora enfrenta o emocionante desafio de **lançar um novo artista** no cenário musical global. Felizmente, ela tem uma ferramenta poderosa em seu arsenal: um extenso conjunto de dados do Spotify com informações sobre as **músicas mais ouvidas em 2023**.

Com base nas hipóteses desenvolvidas pela gravadora, será validado ou refutado através da análise de dados e fornecer recomendações estratégicas com base nas descobertas. 

---


## 🎯 **Objetivo**

Explorar a analise dos dados, destacando como isso ajuda a melhorar a compreensão dos fenômenos, apoiar pesquisas e tomar decisões acertadas.

A gravadora levantou uma série de hipóteses sobre o que faz uma música seja mais ouvida. Essas hipóteses incluem:

- **Hipótese 1:** Músicas com BPM (Batidas Por Minuto) mais altos fazem mais sucesso em termos de número de streams no Spotify.
- **Hipótese 2:** As músicas mais populares no ranking do Spotify também possuem um comportamento semelhante em outras plataformas, como a Deezer.
- **Hipótese 3:** A presença de uma música em um maior número de playlists está correlacionada com um maior número de streams.
- **Hipótese 4:** Artistas com um maior número de músicas no Spotify têm mais streams.
- **Hipótese 5:** As características da música influenciam o sucesso em termos de número de streams no Spotify.

O objetivo principal desta análise é que a **gravadora e o novo artista possam tomar decisões que aumentem suas chances de alcançar o sucesso**.


---

## 🤝 **Equipe**

 - Marianela Ruiz e Thaise Oliveira.
---


## 📰 **Ficha Técnica**

 - https://unruly-whale-fb1.notion.site/P2-Hip-teses-Spotify-13a035f6e34a41419e22860516aa2588
---

## 🔧 **Ferramentas e Tecnologias** 
- Ferramentas de visualização : Power BI.
- Linguagens: SQL e Python.
- Ferramentas: BigQuery, Google Colab.
---

## 📈 **Fontes de dados**
- Principal fonte de dados: https://drive.google.com/drive/folders/1HJXQ14woPBi5YhKOiP1mkXgMl6L8lfLs?usp=sharing
- Manipulação de dados e testes estatísticos em Python(Google Colab): https://colab.research.google.com/drive/1yqDrSCxV1pLNdZte-QVcOxdOQywfsb8J?usp=sharing

---

## 🔎 **Processamento e análises**
Várias etapas foram seguidas para preparar os dados para análise:

- Eliminação de valores nulos para manter a qualidade, a precisão e a confiabilidade da análise, permitindo resultados mais robustos e acionáveis.
- Verificação e remoção de valores duplicados. É necessário investigar e corrigir valores de dados duplicados para manter a integridade dos dados.
- Decidiu-se remover a coluna 'in_shazam_charts' porque é um aplicativo que identifica músicas e foi considerado fora do escopo da análise.
- Decidiu-se remover as colunas 'key' e 'mode' porque elas têm muitos registros com valores nulos e consideramos que elas não fornecem muitas informações relevantes para a análise do estudo.
- Variáveis como 'data_de_lancamento', 'total_participation_inn_playlist', 'count_songs' foram criadas para melhorar a compreensibilidade e a utilidade dos dados. 
- Caracteres especiais foram identificados nas variáveis "track_name" e "artist_name" para melhorar a qualidade e a utilidade dos dados e, assim, melhorar a precisão e a eficiência da análise.
- Para as variáveis que descrevem as características das músicas, elas foram categorizadas em: baixa e alta, para que fosse possível aplicar testes estatísticos.
- Salvamos os dados limpos em um novo arquivo pronto para a análise descritiva, inferencial e de regressão linear.
Seguindo essas etapas, conseguimos garantir que nossos dados fossem confiáveis e bem preparados para análise.

---

## 💡 **Resultados e Conclusões**
 
 
---

## 📊 **Painel de controle (dashboard) no Power BI**

<img src="img/dashboard.png" alt="Alt text" width="800" height="500">

---

## **Referências**

- https://repositorio.uac.pt/bitstream/10400.3/5365/1/Sousa_CA_21%20Mar%C3%A7o%202019.pdf
- https://cienciadedatos.net/documentos/py10-regresion-lineal-python