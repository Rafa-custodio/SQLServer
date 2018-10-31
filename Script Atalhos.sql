CREATE DATABASE TRACES

USE Traces

----------------------------------------------------------------------------------------------------------------------------
--	Cria e popula a tabela "Tabela_Teste" para a realiza��o dos testes
----------------------------------------------------------------------------------------------------------------------------
IF (OBJECT_ID('Tabela_Teste') IS NOT NULL) DROP TABLE Tabela_Teste

CREATE TABLE Tabela_Teste (
	Id_Cliente INT IDENTITY(1,1),
	Nm_Cliente VARCHAR(50),
	Dt_Nascimento DATETIME,
	CONSTRAINT PK_Tabela_Teste
	PRIMARY KEY(Id_Cliente),
	CONSTRAINT CH01_Tabela_Teste
	CHECK(Dt_Nascimento > '1900-01-01')
)

-- Cria alguns indices para a tabela
CREATE NONCLUSTERED INDEX SK01_Tabela_Teste
ON Tabela_Teste (Nm_Cliente) WITH (FILLFACTOR = 95)

CREATE NONCLUSTERED INDEX SK02_Tabela_Teste
ON Tabela_Teste (Dt_Nascimento) WITH (FILLFACTOR = 95)

-- Insere alguns registros de exemplo
INSERT INTO Tabela_Teste VALUES('Jo�o da Silva', '1978-01-29'), ('Paulo Santos', '1982-06-07'), ('Maria da Penha', '1975-08-02')
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	01) ALT + F1 � Executa o procedimento armazenado do sistema��sp_help� e exibe v�rias informa��es do objeto selecionado
----------------------------------------------------------------------------------------------------------------------------
-- Essa sem d�vida e uma das dicas que utilizo com mais frequ�ncia. Ela retorna v�rias informa��es sobre a tabela de forma simples e r�pida, 
-- ajudando a identificar rapidamente as colunas, tipos, �ndices, dentre outras informa��es da tabela.

-- Selecione o nome "Tabela_Teste" e pressione as teclas ALT + F1
SELECT * FROM Tabela_Teste


----------------------------------------------------------------------------------------------------------------------------
--	02) Selecionar Colunas: 
----------------------------------------------------------------------------------------------------------------------------
--	Pode ser �til para copiar o nome das colunas ou inserir texto.

--	Clicar na posi��o inicial + pressionar as teclas SHIFT e ALT + clicar na posi��o final

--	OBS: S� � poss�vel "inserir texto" com essa sele��o a partir do SSMS 2012 e posteriores.

Id_Cliente
Nm_Cliente
Dt_Nascimento
Id_Cliente
Nm_Cliente
Dt_Nascimento
Id_Cliente
Nm_Cliente
Dt_Nascimento
Id_Cliente
Nm_Cliente
Dt_Nascimento


----------------------------------------------------------------------------------------------------------------------------
--	03)	CTRL + Barra de Espa�o � Exibe o Intellisense com a lista de objetos do banco de dados
----------------------------------------------------------------------------------------------------------------------------
--	Muito bom para aumentar a produtividade no desenvolvimento das tarefas do dia a dia.

--	OBS: Caso o IntelliSense n�o esteja habilitado, basta ir no menu �Query -> IntelliSense Enabled� e habilitar a op��o.

--	Descomentar a linha abaixo, pressionar "CTRL + Barra de Espa�o" ap�s o FROM, come�ar a digitar o nome da 
--	tabela "Tabela_Teste" e ir� aparecer o Intellisense.

--	SELECT * FROM 


----------------------------------------------------------------------------------------------------------------------------
--	04)	CTRL + SHIFT + R � Atualiza��o de cache do Intellisense
----------------------------------------------------------------------------------------------------------------------------
--	Algumas vezes precisamos incluir / excluir colunas ou at� mesmo criar novas tabelas nas tarefas do dia a dia. 
--	Entretanto, logo ap�s realizar essas altera��es o IntelliSense n�o � atualizado automaticamente e os objetos n�o s�o exibidos corretamente. 
--	Para contornar essa situa��o, basta atualizar o cache do IntelliSense manualmente.

--	Segue abaixo um pequeno script para testar:

--	Criar uma nova coluna na tabela
ALTER TABLE Tabela_Teste
ADD Nm_Pai VARCHAR(50) NULL

--	Abrir uma nova janela de query
--	Colocar uma virgula "," e come�ar a digitar o nome da nova coluna "Nm_Pai". Ela n�o ir� aparecer no Intellisense.
SELECT Nm_Cliente
FROM Tabela_Teste

--	Pressionar as teclas "CTRL + SHIFT + R" para atualizar o Cache do Intellisense.

--	Colocar uma virgula "," e come�ar a digitar o nome da nova coluna "Nm_Pai". Dessa vez o nome da coluna ir� aparecer no Intellisense.
SELECT Nm_Cliente
FROM Tabela_Teste


----------------------------------------------------------------------------------------------------------------------------
--	05)	Exibir a numera��o das linhas
----------------------------------------------------------------------------------------------------------------------------
-- �til para melhorar a visualiza��o do c�digo e para refer�ncias visuais.

--	Basta habilitar / desabilitar a op��o no menu �Tools -> Options -> Text Editor -> All Languages -> Line numbers�.


----------------------------------------------------------------------------------------------------------------------------
--	06)	CTRL + G � Vai para a linha informada
----------------------------------------------------------------------------------------------------------------------------
--	�til quando voc� possui o n�mero da linha desejada. Por exemplo, quando ocorre algum erro e a linha � informada.


----------------------------------------------------------------------------------------------------------------------------
--	07)	CTRL + F � Exibe a janela de Pesquisa
----------------------------------------------------------------------------------------------------------------------------
--	Muito �til para pesquisar o nome de objetos na janela de query atual. 
--	Utilizo com muita frequ�ncia tamb�m para poder encontrar algo dentro de uma procedure muito grande.

--	Tamb�m possui op��es para pesquisar apenas no trecho de c�digo selecionado, em todas as janelas abertas ou na solu��o inteira.


----------------------------------------------------------------------------------------------------------------------------
--	08)	CTRL + H � Exibe a janela de Substitui��o
----------------------------------------------------------------------------------------------------------------------------
--	Muito �til para substituir texto na janela de query atual.
--	Utilizo bastante para implantar as rotinas de monitoramento do banco de dados nos clientes e substituir a parte do email que ser� enviado.

--	Tamb�m possui op��es para substituir apenas no trecho de c�digo selecionado, em todas as janelas abertas ou na solu��o inteira.


----------------------------------------------------------------------------------------------------------------------------
--	09)	CTRL + F4 � Fecha a janela da query atual
----------------------------------------------------------------------------------------------------------------------------
--	Fecha apenas a janela da query que est� aberta atualmente.


----------------------------------------------------------------------------------------------------------------------------
--	10)	CTRL + TAB � Alterna entre as janelas das consultas e pain�is
----------------------------------------------------------------------------------------------------------------------------
--	�til quando for necess�rio trabalhar com v�rias janelas de queries em paralelo e alternar entre elas.


----------------------------------------------------------------------------------------------------------------------------
--	11)	CTRL + K, CTRL + K � Inserir um marcador de c�digo
----------------------------------------------------------------------------------------------------------------------------
--	Tem uma fun��o similiar ao BREAKPOINT, mas � utilizado apenas para melhorar a visualiza��o do c�digo. 
--	Muito �til ao analisar c�digos com muitas linhas para marcar os pontos mais importantes


----------------------------------------------------------------------------------------------------------------------------
--	12)	CTRL + K, CTRL + P � Ir para o pr�ximo marcador de c�digo
----------------------------------------------------------------------------------------------------------------------------
--	Alterar para o pr�ximo marcador utilizado no c�digo


----------------------------------------------------------------------------------------------------------------------------
--	13)	CTRL + K, CTRL + L � Limpar todos os marcadores de c�digo
----------------------------------------------------------------------------------------------------------------------------
--	Utilizado para limpar todos os marcadores do c�digo. Ao pressionar as teclas ser� exibida uma mensagem para confirmar a a��o.


----------------------------------------------------------------------------------------------------------------------------
--	14)	CTRL + K, CTRL + W � Exibe o painel com todos os marcadores de c�digo
----------------------------------------------------------------------------------------------------------------------------
--	Exibe um painel na parte inferior da tela com todos os marcadores e suas respectivas posi��es (linha).
--	OBS: Voc� tamb�m pode renomear o nome do marcador para facilitar o entendimento.


----------------------------------------------------------------------------------------------------------------------------
--	15)	CTRL + K, CTRL + C � Comenta as linhas selecionadas
----------------------------------------------------------------------------------------------------------------------------
--	�til para comentar rapidamente o trecho de c�digo selecionado. 
--	Caso n�o tenha selecionado nada, ser� inserido um coment�rio na linha atual do cursor do mouse.


----------------------------------------------------------------------------------------------------------------------------
--	16)	CTRL + K, CTRL + U � Descomenta as linhas selecionadas
----------------------------------------------------------------------------------------------------------------------------
--	�til para descomentar rapidamente o trecho de c�digo selecionado. 
--	Caso n�o tenha selecionado nada, ser� removido um coment�rio na linha atual do cursor do mouse.


----------------------------------------------------------------------------------------------------------------------------
--	17)	CTRL + SHIFT + L � Transforma todas as letras do texto selecionado em Min�sculo (LOWER)
----------------------------------------------------------------------------------------------------------------------------
--	Tem a mesma funcionalidade que o LOWER(string).
SELECT LOWER('TRANSFORMAR PARA MIN�SCULO')


----------------------------------------------------------------------------------------------------------------------------
--	18)	CTRL + SHIFT + U � Transforma todas as letras do texto selecionado em Mai�sculo (UPPER) 
----------------------------------------------------------------------------------------------------------------------------
--	Tem a mesma funcionalidade que o UPPER(string).
SELECT UPPER('transformar para mai�sculo')


----------------------------------------------------------------------------------------------------------------------------
--	19)	CTRL + T � Exibe o Resultado como Texto 
----------------------------------------------------------------------------------------------------------------------------
--	�til quando utilizamos uma query din�mica para retornar um script como resultado e depois copiamos o resultado para poder executar.
--	Por exemplo, utilizar uma query para montar um script para realizar o Backup de todas as databases da inst�ncia.
SELECT * FROM Tabela_Teste

SELECT 'BACKUP DATABASE ' + name + ' TO DISK = ''C:\SQL Server\' + name + '.bak'' WITH  FORMAT, CHECKSUM , COMPRESSION, STATS = 1'
FROM sys.databases
WHERE name <> 'tempdb'


----------------------------------------------------------------------------------------------------------------------------
--	20)	CTRL + D � Exibe o Resultado como Grid 
----------------------------------------------------------------------------------------------------------------------------
--	Exibe o resultado normalmente como uma tabela com as linhas numeradas a esquerda.


----------------------------------------------------------------------------------------------------------------------------
--	21)	F1 � Abre o Menu de Ajuda
----------------------------------------------------------------------------------------------------------------------------
--	Exibe o conte�do de ajuda do SQL Server. Se algum texto estiver selecionado, ser� feito um filtro com esse texto.
SELECT CONVERT(VARCHAR(10), GETDATE(), 120)


----------------------------------------------------------------------------------------------------------------------------
--	22)	F2 � Altera o nome do objeto selecionado na janela do Object Explorer
----------------------------------------------------------------------------------------------------------------------------
--	OBS: Tomar bastante cuidado antes de alterar o nome de algum objeto para n�o causar erros em outras rotinas que o utilizam.
--		 Pois ao alterar o nome do objeto pelo Object Explorer, as rotinas que utilizam esse objeto n�o ser�o atualizadas para o novo nome.


----------------------------------------------------------------------------------------------------------------------------
--	23)	F3 � Localiza a pr�xima ocorr�ncia do texto de pesquisa
----------------------------------------------------------------------------------------------------------------------------
--	�til para ir para a pr�xima ocorr�ncia da pesquisa sem precisar utilizar o mouse. Pode aumentar a sua produtividade.


----------------------------------------------------------------------------------------------------------------------------
--	24)	F4 � Exibe a janela de Propriedades
----------------------------------------------------------------------------------------------------------------------------
--	Exibe o painel de Propriedades com diversas informa��es. Por exemplo: Login name, Server name, SPID, etc...


----------------------------------------------------------------------------------------------------------------------------
--	25)	F5 � Executa a parte selecionada da query ou toda a query se nada estiver selecionado
----------------------------------------------------------------------------------------------------------------------------
--	OBS: Tomar bastante cuidado antes de executar um script, lembrando sempre de conferir se est� na inst�ncia / database corretos.


----------------------------------------------------------------------------------------------------------------------------
--	26)	F6 � Alterna entre o painel de consulta e de resultados
----------------------------------------------------------------------------------------------------------------------------
--	Alterna o cursor do mouse entre o painel de consulta e de resultados.


----------------------------------------------------------------------------------------------------------------------------
--	27)	F7 � Exibe a janela Object Explorer Details com os detalhes dos objetos do Banco de Dados 
----------------------------------------------------------------------------------------------------------------------------
--	Muito �til para gerar o script de cria��o de v�rios objetos de uma database.


----------------------------------------------------------------------------------------------------------------------------
--	28)	F8 � Exibe a janela Object Explorer com os objetos do Banco de Dados 
----------------------------------------------------------------------------------------------------------------------------
--	Muito �til para visualizar os objetos do Banco de Dados. Por exemplo: Inst�ncias, databases, tabelas, procedures, etc...


----------------------------------------------------------------------------------------------------------------------------
--	29)	Selecionar C�digo + TAB � Incrementa uma identa��o no c�digo selecionado
----------------------------------------------------------------------------------------------------------------------------
--	Fazer o teste com o c�digo abaixo. C�digo para a direita ->
CREATE TABLE [dbo].[CheckList_Database_Growth_Email] (
	[Nm_Servidor]	VARCHAR(50) NULL,
	[Nm_Database]	VARCHAR(100) NULL,
	[Tamanho_Atual] NUMERIC(38, 2) NULL,
	[Cresc_1_dia]	NUMERIC(38, 2) NULL,
	[Cresc_15_dia]	NUMERIC(38, 2) NULL,
	[Cresc_30_dia]	NUMERIC(38, 2) NULL,
	[Cresc_60_dia]	NUMERIC(38, 2) NULL
)


----------------------------------------------------------------------------------------------------------------------------
--	30)	Selecionar C�digo + SHIFT + TAB � Decrementa uma identa��o no c�digo selecionado
----------------------------------------------------------------------------------------------------------------------------
--	Fazer o teste com o c�digo abaixo. C�digo para a esquerda <-
CREATE TABLE [dbo].[CheckList_Database_Growth_Email] (
		[Nm_Servidor]	VARCHAR(50) NULL,
		[Nm_Database]	VARCHAR(100) NULL,
		[Tamanho_Atual] NUMERIC(38, 2) NULL,
		[Cresc_1_dia]	NUMERIC(38, 2) NULL,
		[Cresc_15_dia]	NUMERIC(38, 2) NULL,
		[Cresc_30_dia]	NUMERIC(38, 2) NULL,
		[Cresc_60_dia]	NUMERIC(38, 2) NULL
)


----------------------------------------------------------------------------------------------------------------------------
--	31)	Alterar colora��o da barra status (por inst�ncia) � �File -> Connect Object Explorer... -> Options -> Select -> Selecionar uma cor -> Connect�
----------------------------------------------------------------------------------------------------------------------------
--	Muito �til para diferenciar visualmente as inst�ncias do servidor. Pode identificar facilmente uma inst�ncia antes de executar um script em produ��o!
--	Por exemplo: 
--	Instancia 1: Produ��o			->	Cor: Vermelho
--	Instancia 2: Desenvolvimento	->	Cor: Amarelo
--	Instancia 3: Homologa��o		->	Cor: Verde


----------------------------------------------------------------------------------------------------------------------------
--	32)	CTRL + A � Seleciona todo o texto da query 
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	33)	SHIFT + PAGE UP � Seleciona uma pagina de texto para cima 
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	34)	SHIFT + PAGE DOWN � Seleciona uma pagina de texto para baixo 
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	35)	SHIFT + HOME � Seleciona o texto at� o in�cio da linha 
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	36)	SHIFT + END � Seleciona o texto at� o final da linha 
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	37)	CTRL + SHIFT + ESC � Abre o Gerenciador de Tarefas 
----------------------------------------------------------------------------------------------------------------------------
--	Apesar de n�o fazer parte do Management Studio, � �til para auxiliar na an�lise de performance (CPU) e mem�ria.


----------------------------------------------------------------------------------------------------------------------------
--	38)	CTRL + M � Habilita / Desabilita o Plano de Execu��o Atual 
----------------------------------------------------------------------------------------------------------------------------
--	Habilita / Desabilita a exibi��o do Plano de Execu��o Atual. O plano ser� exibido apenas quando algum c�digo for executado.
SELECT * FROM Tabela_Teste where Nm_Cliente like 'Joao%'


----------------------------------------------------------------------------------------------------------------------------
--	39)	CTRL + L � Executa o Plano de Execu��o Estimado para o trecho de c�digo selecionado
----------------------------------------------------------------------------------------------------------------------------
--	OBS: Exibe o plano de execu��o estimado para o trecho de c�digo selecionado sem executar o c�digo efetivamente.
SELECT * FROM Tabela_Teste where Nm_Cliente like 'Joao%'


----------------------------------------------------------------------------------------------------------------------------
--	40)	CTRL + ALT + P � Abre o SQL Server Profiler 
----------------------------------------------------------------------------------------------------------------------------
--	O SQL Server Profiler pode ser usado para visualizar sess�es ao vivo de atividades no SQL Server. 
--	Podemos colher informa��es importantes como, por exemplo, quantas consultas o banco de dados est� executando, quanto tempo est�o demandando estas consultas, 
--	qual banco de dados est� executando qual consulta e assim por diante.

--	Veja tamb�m:
--	http://www.fabriciolima.net/blog/2010/06/05/passo-a-passo-para-encontrar-as-querys-mais-demoradas-do-banco-de-dados-parte-1/
--	http://www.fabriciolima.net/blog/2010/06/05/passo-a-passo-para-encontrar-as-querys-mais-demoradas-do-banco-de-dados-parte-2/
--	http://www.fabriciolima.net/blog/2011/01/26/querys-do-dia-a-dia-acompanhando-as-querys-mais-demoradas-do-banco-de-dados/


----------------------------------------------------------------------------------------------------------------------------
--	41)	CTRL + 0 at� CTRL + 9 � Executa o procedimento armazenado configurado para esses atalhos atrav�s dos menus��Tools -> Options -> Environment ->�Keyboard�-> Query shortcuts�
----------------------------------------------------------------------------------------------------------------------------
--	Atalhos �teis para procedimentos executados com frequ�ncia. Podem aumentar a sua produtividade. Por Exemplo:
--	CTRL + 1 � Executar o procedimento armazenado do sistema��sp_who�
--	CTRL + 2 � Executar o procedimento armazenado do sistema��sp_lock�


----------------------------------------------------------------------------------------------------------------------------
--	42)	Gerar script colunas separadas por v�rgula � Object Explorer + Arrastar "Columns" para a query
----------------------------------------------------------------------------------------------------------------------------
--	�til quando voc� precisa fazer um SELECT / INSERT em uma tabela que possui muitas colunas.


----------------------------------------------------------------------------------------------------------------------------
--	43)	CTRL + U � Alterar a database Ao
----------------------------------------------------------------------------------------------------------------------------
--	atual pressionar as teclas o foco � alterado para a caixa de sele��o com os nomes das databases.


----------------------------------------------------------------------------------------------------------------------------
--	44)	CTRL + ALT + T � Exibe a janela de Templates
----------------------------------------------------------------------------------------------------------------------------
--	Permite que voc� utilize scripts padronizados e com parametros para realizar tarefas repetitivas.
--	Ap�s abrir o Template desejado, clique no menu "Query -> Specify Values for Template Parameters..." ou pressione CTRL + SHIFT + M.
--	Ser� aberta uma janela onde voc� deve preencher o valor do par�metro no campo "Value".

--	Para criar o seu pr�prio template, clique com o bot�o direito em alguma pasta (ou crie uma nova) no painel "Template Explorer" -> New Template.
--	Coloque o nome desejado no arquivo que ser� criado. Agora, clique com o bot�o direito no arquivo -> "Edit" -> uma nova janela ser� aberta.
--	Por fim, basta escreve o script desejado e incluir o c�digo <Parameter, Type, Value> como par�metro.
--	OBS: Todas as ocorr�ncias do c�digo <Parameter, Type, Value> ser�o substitu�das ap�s o preenchimento dos par�metros.

--	Refer�ncia:
--	http://sqlmag.com/database-administration/introduction-using-template-explorer-sql-server-management-studio


----------------------------------------------------------------------------------------------------------------------------
--	45)	CTRL + R � Exibe / Esconde o Painel de Resultado de query
----------------------------------------------------------------------------------------------------------------------------
--	Utilizado para exibir o Painel de Resultado ou para esconder e visualizar melhor o c�digo da query.


----------------------------------------------------------------------------------------------------------------------------
--	46)	CTRL + SHIFT + C � Copia a grade de resultados e o cabe�alho para a �rea de transfer�ncia
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	47)	CTRL + N � Cria uma nova janela de query
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	48)	CTRL + O � Exibe a caixa de di�logo�Abrir Arquivo�para abrir um arquivo existente
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	49)	CTRL + SHIFT + N � Exibe a caixa de di�logo Novo Projeto
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--	50)	CTRL + S � Salva a query
----------------------------------------------------------------------------------------------------------------------------
--	OBS: Importante sempre salvar a query com as modifica��es realizadas para evitar perda em caso de desastres. Por exemplo: queda de energia.