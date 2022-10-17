# Projeto Enem
 Projeto Enem 2020 - Processo Seltivo Mesha
![image](https://user-images.githubusercontent.com/88055274/196243128-97ec51c4-e6f8-4434-be82-853647c3ad32.png)

Projeto referente ao processo seletivo da Mesha Tecnologia da unidade Maceió.

Nesse projeto, foi objetivado a **Análise dos microdados do Exame Nacional do Ensino Médio (ENEM)** de cada participate, sendo desta da edição 2020.

Logo, os dados foram disponibilizados, jutamente como dicionário deles, estes podem ser vistos na pasta *Dados*. 

Para a descrição das variáveis, estas vão ser descritas a medida que elas forem aparecendo no projeto.

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

Por se tratar de um database de 1.8 gb aproximadamente, é necessário realizar a leitura dos dados de uma forma que nao use tanto a memória ram, visto que o máquina utilizada possui apenas 4 GB de Ram. 

Assim, foi feita a importação em no MySQL, POSTGRESQL e Microsoft SQL Server, porém em todos eles não foi possível realizar a importação devido a memoria (O menor tempo estimado, dos 3 foi de 12 Horas). Dessa forma, foi usado o Python, mais epecificamente Jupyter notebook a fim de fazer essa importação.

Porém ao ser feita esta importação:
![image](https://user-images.githubusercontent.com/88055274/196234802-78482e00-93ee-4484-99a8-87546c7fbada.png)
Ocorreu novamente o erro de memória:
![image](https://user-images.githubusercontent.com/88055274/196234731-6cc140e7-2c7d-4075-9e51-05930c2d77f6.png)

Logo, a fim de conseguir impotar este database, foi feita então uma sample, para ser usada neste projeto, a máquina conseguiu ler os dados a partir de 2000000 amostras (linhas), assim foi usada esta:
![image](https://user-images.githubusercontent.com/88055274/196232944-b9f2c7d9-54d4-4636-acb9-e5ebe0344b70.png)
![image](https://user-images.githubusercontent.com/88055274/196233359-cb5bae6a-2727-4c3c-8da0-afe8fc7779e0.png)

Ao analisar os dados, foi visto que não seriam usadas todas as colunas, então algumas foram dropadas, abaixando o número de columns para 36, deixando bem mais leve.
![image](https://user-images.githubusercontent.com/88055274/196233053-ad9a6cc3-b286-44d7-a589-a6e0580f2616.png)
![image](https://user-images.githubusercontent.com/88055274/196233198-ed8f82f4-8daf-45af-9f0d-93a2e7d884be.png)

Logo, com isso, foi obtida a leitura e um pouco do drop de dados. Logo, a próxima etapa será exportar esse dados, para um banco de dados, o qual será o MYSQL, para armazenamento desses dados de forma mais fluida e segura, uma vez que segundo Junior (2021) este é um software que tem como característica:

**1.Ser muitop popular**

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

**5.projeto_enem**: Nome do banco de dados

Com a conexão, pode-se estabeelcar a conexão com df.to_sql
![image](https://user-images.githubusercontent.com/88055274/196235805-1e105d69-1169-4f99-add5-40a276dd2a59.png)

Basicamente, jogar o CSV numa tabela banco de dados (Extraction), criar algumas consultas pra tratar ou criar métricas (transform), e criar novas tabelas com base nessas consultas (Load). ETL = Extract, Transform & Load
