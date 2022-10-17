# Projeto Enem
 Projeto Enem 2020 - Processo Seltivo Mesha
![image](https://user-images.githubusercontent.com/88055274/196243128-97ec51c4-e6f8-4434-be82-853647c3ad32.png)

Projeto referente ao processo seletivo da Mesha Tecnologia da unidade Maceió.

Nesse projeto, foi objetivado a **Análise dos microdados do Exame Nacional do Ensino Médio (ENEM)** de cada participate, sendo desta da edição 2020.

Logo, os dados foram disponibilizados, jutamente como dicionário deles, estes podem ser vistos na pasta *Dados* do link:  [https://docs.google.com/document/d/1UtS5hPXzrH77_KHT8RneRkpiqHiu1iR9KWb9QuQS3MI/edit](https://drive.google.com/drive/u/0/folders/1tL3c-TI7jnJbXgjPr3o9DllFtkxckiYA) 

Além disso, todos os arquivos usados no projeto estão no link acima.

# Foco do projeto

Realizar uma análise dos microdados do ENEM 2020, a fim de conseguir responder as seguintes perguntas:


**1.Qual a escola com a maior média de notas?**

**2.Qual o aluno com a maior média de notas e o valor dessa média?**

**3.Qual a média geral?**

**4.Qual o % de Ausentes?**

**5.Qual o número total de Inscritos?**

**6.Qual é o Ranking dos melhores alunos de Alagoas por disciplina?**

**7.Qual o perfil dos alunos com as notas abaixo da média? Descreva por sexo, etnia, faixa etária.**

Para tanto, foram requisitadas as seguintes condições:

**1.Uso de Funções DAX**

**2.Documentação das medidas**

**3.ETL**

**4.Modelagem dimensional dos dados**


# 1. Leitura dos dados

Por se tratar de um database de 1.8 gb aproximadamente, é necessário realizar a leitura dos dados de uma forma que nao use tanto a memória ram, visto que a máquina utilizada possui apenas 4 GB de Ram. 

Assim, foi feita a importação no MySQL, POSTGRESQL e Microsoft SQL Server, porém em todos eles não foi possível realizar a importação devido a memoria (O menor tempo estimado, dos 3 foi de 12 Horas). Dessa forma, foi usado o Python, mais epecificamente Jupyter notebook a fim de fazer essa importação.

Porém ao ser feita esta importação:
![image](https://user-images.githubusercontent.com/88055274/196234802-78482e00-93ee-4484-99a8-87546c7fbada.png)
Ocorreu novamente o erro de memória:
![image](https://user-images.githubusercontent.com/88055274/196234731-6cc140e7-2c7d-4075-9e51-05930c2d77f6.png)

Logo, a fim de conseguir importar este database, foi feita então uma sample, para ser usada neste projeto, a máquina conseguiu ler os dados a partir de 2000000 amostras (linhas), assim foi usada esta:
![image](https://user-images.githubusercontent.com/88055274/196232944-b9f2c7d9-54d4-4636-acb9-e5ebe0344b70.png)
![image](https://user-images.githubusercontent.com/88055274/196233359-cb5bae6a-2727-4c3c-8da0-afe8fc7779e0.png)

Ao analisar os dados, foi visto que não seriam usadas todas as colunas, então algumas foram dropadas, abaixando o número de columns para 36, deixando bem mais leve.
![image](https://user-images.githubusercontent.com/88055274/196233053-ad9a6cc3-b286-44d7-a589-a6e0580f2616.png)
![image](https://user-images.githubusercontent.com/88055274/196233198-ed8f82f4-8daf-45af-9f0d-93a2e7d884be.png)

# 2. ETL 
Logo, com isso, foi obtida a leitura e um pouco do drop de dados. Logo, a próxima etapa será exportar esse dados, para um banco de dados, o qual será o MYSQL, para armazenamento desses dados de forma mais fluida e segura, uma vez que segundo Junior (2021) este é um software que tem como característica:

**1.Ser muito popular**

**2.Ser flexível**

**3.Ser muito confiável**

**4.Oferece código estável**

**5.Possui alta performance**

Assim para exportar, são usadas as bibliotecas: pymysql, openpyxl e sqlalchemy. Logo, é selecionada a create.engine do sqlalchemy.engine a fim de obter a conexão do Jupyter e SQL. 
 
Após, é criado o engine, que possui:

**mysql**: Banco de dados

**pymysql**: Conexão com o Banco de Dados

**root **: Username

**bootcamp**: Password

**@127.0.0.1:3307**: IP

**projeto_enem**: Nome do banco de dados

Com a conexão, pode-se ter a conexão com df.to_sql
![image](https://user-images.githubusercontent.com/88055274/196235805-1e105d69-1169-4f99-add5-40a276dd2a59.png)

No SQL, foi feito o **ETL**, da seguinte maneira:  O arquivo CSV, que foi lido antes como dataframe no pandas, é exportado como tabela banco de dados (*Extraction*), são  criadas algumas consultas pra tratar ou criar métricas (*transform*), e criar novas tabelas com base nessas consultas (*Load*). ETL = Extract, Transform & Load. Desta maneira, são criadas as tabelas a partir da base, advinda do CSV

Para a primeira, consulta, é feito o teste do banco a fim de observar a funcionalidade do mesmo.

Já para tabela, é a tabela que possui a contagem de inscritos por cada estado:
![image](https://user-images.githubusercontent.com/88055274/196250832-08f13076-2f8a-4499-a297-4ac0206bf7b4.png)

A segunda tabela, é o perfil social dos alunos com a nota abaixo da média, para tanto deve ser criada uma tabela de consulta antes:
![image](https://user-images.githubusercontent.com/88055274/196251215-88d3e68e-c84d-48d4-907c-8ffb90bbdbc7.png)

A terceira, se trata da tabela que apresenta a média das melhoras escolas, no quesito nota
![image](https://user-images.githubusercontent.com/88055274/196252347-5ab2afc0-c1da-43b7-adb9-2d409dbbdef3.png)

Após estas consultas, é feita a importação dos dados para o BI utilizando a opção do MYSQL
![image](https://user-images.githubusercontent.com/88055274/196253044-7c117aff-23c1-4c40-9cf8-d5d032c7e9ac.png)

# 3. Modelagem do Banco

A modelagem é na parte de modelagem do Power BI, devido a facilidade do mesmo, esta: 
![image](https://user-images.githubusercontent.com/88055274/196253765-55487df5-370a-4584-8660-8c9d1274fbd2.png)

Para o relacionamento com a tabela Inscritos por Estado é feita através da Unidade Federativa:
![image](https://user-images.githubusercontent.com/88055274/196254005-25625ba5-eafd-406f-b9ea-c380673cf4b9.png)

Já para a tabela Melhores escolas é feita através da Nota Final de cada aluno, e esta faz um join com a tabela Estados:
![image](https://user-images.githubusercontent.com/88055274/196255083-41973a77-7225-4883-b727-f581271cb61b.png)

No lado direito, há a conexão com Perfil Abaixo da Média, através da Nota Final:
![image](https://user-images.githubusercontent.com/88055274/196255277-929a16df-7e61-4563-8133-4c0591d5dd04.png)

# 4. Dashboard

Antes, é alocado o layout do Dashboard, feito anteriormete no Microsoft PowerPoint, o qual se encontra em *Layout*

Para a realização do Dashboard, são feitas métricas necessárias para a realização deste:

![image](https://user-images.githubusercontent.com/88055274/196256080-4b71b50c-2d8f-45aa-9db6-07604e257a5d.png)

## Documentação das medidas

**Geral**: Média geral do ENEM 2020

**Humanas**: Média geral de Ciências Humanas 

**Linguagens**: Média geral de Linguagens 

**Matemática**: Média geral de Matemática 

**Ciências da Natureza**: Média geral de Ciências da Natureza 

**Redação**: Média geral de Redação 

**Contagem de faltantes**: Contagem dos faltantes 

**Inscritos**: Média geral de Redação 

**Porcentagem de faltantes**: Média geral de Redação 

Assim, com as métricas e os cálculos das outras tabelas, pode-se preencher o layout e realizar o dashboard, que segue no link do drive:
https://drive.google.com/drive/u/0/folders/1tL3c-TI7jnJbXgjPr3o9DllFtkxckiYA ou através do link público:  https://app.powerbi.com/view?r=eyJrIjoiNDE0NzkwZTctYTk3OS00ZTMwLThlOTctYzQ5NjU5M2QxNjY1IiwidCI6Ijg1MDA4MzQ1LWRhNTMtNGJjYy1iMzc3LWU1NTFjM2FhMDllZSJ9 

# Conclusões

• **Total de inscritos de 2 milhões, com mais da metade dos participantes ausentes (55,06%)**

• **A média geral do ENEM 2020 foi 523.95 e as notas de CN, CH, linguagens, matemática e redação são 490.45, 511.27, 523.89, 520.72 e 573.41 respectivamente**

• **O perfil para alunos que tiveram nota média menor que a média geral varia muito**

• **Os 3 estados com maiores inscrições são São Paulo, Minas Gerais e Bahia**

• **A maior nota geral foi 851.0, sendo este estudante do Ceará**

• **O Colégio Estadual Landulfo Alves De Almeida é o colégio com maior média do Brasil tendo o valor de 748.50, sendo este da Bahia**

• **As regiões que possuem um maior número de participações no ranking das 10 melhores escolas, são Sudeste e Nordeste, com 4 escolas cada** 

• **Em Alagoas, o ranking das melhores alunos por disciplina é composto pelas notas: 805.2, 824.9, 725.6, 975 e 1000 das matérias CN, CH, linguagens, matemática e redação respectivamente, já para a maior média de AL, se trata de 815.1** 

• **As regiões que possuem um maior número de participações no ranking das 10 melhores escolas, são Sudeste e Nordeste, com 4 escolas cada** 


## Referência

JUNIOR, C. Banco de dados MariaDB e MySQL: vantagens e desvantagens. Porto Fácil. 2021. Disponível em:<https://www.portofacil.net/banco-de-dados-mariadb-e-mysql.html> Acesso em: 17 de Outubro de 2022 
