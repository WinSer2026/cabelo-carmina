/* ============================================================
   Cabelo Carmina — conteudo.js
   EDITE AQUI para alterar textos, serviços, preços, promoções,
   depoimentos, dicas e programa de indicação. Não precisa de mexer no HTML.
   ============================================================ */
const CONFIG = {
  salon: {
    nome: "Cabelo Carmina",
    dona: "Carmina Langa",
    telefone1: "842 785 461",
    telefone2: "870 508 213",
    whatsapp1: "258842785461",
    whatsapp2: "258870508213",
    local: "Malhampsene, Matola - Maputo, Moçambique",
    mapsEmbed: "https://maps.google.com/maps?q=Malhampsene%2C%20Matola%2C%20Mocambique&output=embed",
    mapsLink: "https://maps.google.com/?q=Malhampsene%2C%20Matola%2C%20Mocambique",
    heroImg: "assets/imagens/15f6aeca9793449702054abd78677a57.jpg",
    fotoPerfil: "assets/imagens/3a85e2c7aff9430f6a7af488f10452bd.jpg",
    sobre: "A Carmina Langa é especialista em traçar cabelo, tranças e simulação de próteses capilares em Malhampsene, Matola. Com anos de experiência, alia técnica, materiais de qualidade e muito cuidado para devolver a cada cliente confiança e beleza natural. O atendimento é personalizado: cada cabeça é avaliada antes de começar, para um resultado que dura e respeita a saúde do couro cabeludo.",
    horario: [
      ["Segunda - Sexta", "08:00 – 18:00"],
      ["Sábado", "08:00 – 16:00"],
      ["Domingo", "Mediante marcação"]
    ]
  },

  /* Categorias usadas no menu do agendamento */
  categorias: ["Tranças", "Próteses Capilares", "Extensões", "Tratamento", "Eventos", "Coloração", "Corte", "Geral"],

  /* CATÁLOGO DE SERVIÇOS — altere nome, desc, tag, categoria, preco e img */
  servicos: [
    { id:"tracar", nome:"Traçar Cabelo (Crochet / Tricot)", categoria:"Tranças",
      desc:"Instalação de tranças ou fios sintéticos e naturais sobre a base do seu cabelo com a técnica de crochet. Visual volumoso, protegido e sem tensão excessiva no couro cabeludo.",
      tag:"A partir de consulta", preco:"A partir de 1.500 MT", img:"assets/imagens/0026cfc5c7cf5a156cc307e97156dec2.jpg" },
    { id:"proteses", nome:"Simulação de Próteses Capilares", categoria:"Próteses Capilares",
      desc:"Solução estética para queda de cabelo ou áreas com falhas. Criamos a prótese sob medida que imita o seu tom e textura, devolvendo volume e autoestima com discrição total.",
      tag:"Personalizado", preco:"Sob consulta", img:"assets/imagens/01e08757dc973bbed43af0862d8c7d00.jpg" },
    { id:"trancas", nome:"Tranças Tradicionais & Box Braids", categoria:"Tranças",
      desc:"Tranças nagô, box braids, twist e estilos modernos feitos com precisão. Protegem o cabelo e duram semanas com manutenção simples.",
      tag:"Longa duração", preco:"A partir de 2.000 MT", img:"assets/imagens/03f135712a6a2e2bc8f879690180e1c2.jpg" },
    { id:"extensoes", nome:"Extensões & Alongamento", categoria:"Extensões",
      desc:"Aplicação de extensões para dar comprimento e densidade imediatas. Técnicas invisíveis que se fundem ao seu cabelo natural.",
      tag:"Efeito natural", preco:"A partir de 2.500 MT", img:"assets/imagens/03f46e397d53077a8f29f586532d8282.jpg" },
    { id:"tratamentos", nome:"Tratamentos & Hidratação", categoria:"Tratamento",
      desc:"Recuperação capilar com hidratação profunda, reconstrução e nutrição do couro cabeludo. Cabelo saudável como base de qualquer penteado.",
      tag:"Saúde capilar", preco:"A partir de 800 MT", img:"assets/imagens/04679ec09ea4aacabbf5d6915aa35b7a.jpg" },
    { id:"eventos", nome:"Penteados para Eventos", categoria:"Eventos",
      desc:"Visuais para casamentos, formaturas e ocasiões especiais. Do clássico ao ousado, desenhado para brilhar na sua data importante.",
      tag:"Eventos", preco:"A partir de 1.200 MT", img:"assets/imagens/06dac3e899e578c18e467fa2cff62f72.jpg" },
    { id:"mechas", nome:"Coloração & Mechas", categoria:"Coloração",
      desc:"Aplicação de cor, mechas, ombré e raiz esbatida com produtos de baixa agressividade. Tom uniforme e luminoso que realça o seu rosto.",
      tag:"Cor & estilo", preco:"A partir de 1.500 MT", img:"assets/imagens/08b6ac6ea23695bc6f5586986917f11d.jpg" },
    { id:"selagem", nome:"Selagem Térmica & Alisamento", categoria:"Tratamento",
      desc:"Tratamento que reduz o volume e disciplina os fios, deixando o cabelo liso, brilhante e fácil de pentear por semanas.",
      tag:"Liso duradouro", preco:"A partir de 1.800 MT", img:"assets/imagens/093739ff91c25d8ace76bab35050adaf.jpg" },
    { id:"corte", nome:"Corte & Design", categoria:"Corte",
      desc:"Corte personalizado ao formato do seu rosto e estilo de vida. Da manutenção ao visual renovado, com acabamento profissional.",
      tag:"Renovação", preco:"A partir de 500 MT", img:"assets/imagens/0a47e29134426c4513fa7642befd2773.jpg" },
    { id:"manutencao", nome:"Manutenção & Retoque", categoria:"Geral",
      desc:"Retoque de raiz, lavagem e cuidado das suas tranças ou próteses para prolongar o visual e manter a higiene.",
      tag:"Acompanhamento", preco:"A partir de 600 MT", img:"assets/imagens/0b440460fbbcc0842d40904b97cc9ca5.jpg" }
  ],

  /* PROMOÇÕES / PACOTES — remova ou adicione itens */
  promos: [
    { titulo:"Pacote Noiva", desc:"Tranças ou penteado de evento + hidratação profunda. Visual impecável no grande dia.", code:"NOIVA10" },
    { titulo:"Trança + Tratamento", desc:"Faça a sua trança e ganhe 20% no tratamento de recuperação.", code:"DURAVEL" },
    { titulo:"Indique e Ganhe", desc:"Indique uma amiga e ambas recebem 10% no próximo serviço.", code:"CARMINA10" }
  ],

  /* ANTES / DEPOIS — substitua pelos ficheiros reais (antes.jpg / depois.jpg) */
  antesDepois: [
    { antes:"assets/imagens/0b4d5327d2ce7e52298f0efa924f9893.jpg", depois:"assets/imagens/0c9b5bb2f9fc3989eb2c1b1c847cc650.jpg", legenda:"Transformação com box braids" },
    { antes:"assets/imagens/12c5b5bcc2676963cd1b6ba6b14d868e.jpg", depois:"assets/imagens/132b0667ae29cd703960db3ee1979bb5.jpg", legenda:"Protese capilar sob medida" },
    { antes:"assets/imagens/161dcf51394a3ee1f617fb9989bfbf7a.jpg", depois:"assets/imagens/18d984fd57ee53a58f8e0739700f9366.jpg", legenda:"Tratamento + cor" }
  ],

  /* DEPOIMENTOS — aparecem na home e na página Depoimentos */
  depoimentos: [
    { nome:"Ana M., Matola", texto:"Fiz as minhas box braids e adorei o acabamento. Durou semanas e o atendimento foi impecável.", estrelas:5 },
    { nome:"Esperança C.", texto:"A simulação da prótese devolveu-me a confiança. Ninguém nota e sinto-me linda outra vez.", estrelas:5 },
    { nome:"Teresa N., Maputo", texto:"Profissional, pontual e muito cuidadosa. Recomendo a todas as minhas amigas.", estrelas:5 }
  ],

  /* DICAS DE CUIDADOS — blog curto */
  dicas: [
    { titulo:"Como manter as tranças por mais tempo", texto:"Evite o excesso de produto, durma com touca de seda e hidrate o couro cabeludo 2x por semana. Lave com água morna e seque bem." },
    { titulo:"Cuidados com a prótese capilar", texto:"Escove com cerdas macias, lave com shampoo suave e guarde num suporte quando não usar. Evite calor excessivo." },
    { titulo:"Hidratação em casa", texto:"Aplique uma máscara de hidratação 15 minutos antes do champô, 1x por semana, para cabelo macio e brilhante." },
    { titulo:"Proteja o cabelo do sol", texto:"Use lenços ou chapéus e um leave-in com proteção UV nos dias de muito sol em Maputo." }
  ],

  /* PROGRAMA DE INDICAÇÃO */
  indicacao: {
    titulo:"Programa de Indicação",
    texto:"Indique a Cabelo Carmina a uma amiga. Quando ela marcar um serviço e der o seu código, ambas recebem 10% de desconto na próxima visita. Partilhe o seu código no WhatsApp!",
    codigo:"CARMINA10"
  },

  /* TEXTO PARTILHÁVEL (botões de partilha) */
  shareText: "Olhe este visual do Cabelo Carmina (Malhampsene, Matola): "
};
