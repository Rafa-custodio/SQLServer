/*******************************************************************************************************************************
(C) 2015, Fabrício Lima Soluções em Banco de Dados

Site: http://www.fabriciolima.net/

Feedback: contato@fabriciolima.net
*******************************************************************************************************************************/

--------------------------------------------------------------------------------------------------------------------------------
--	Segue passo a passo para realizar a DEMO sobre gerenciamento de Acesso
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
--	1)	Olhar via interface gráfica onde ficam os Logins e onde ficam os usuários das bases de dados.
--------------------------------------------------------------------------------------------------------------------------------
--	Logins fica em: "Security" -> "Logins"
--	Usuários ficam em: "Databases" -> Nome Database -> "Security" -> "Users"

--------------------------------------------------------------------------------------------------------------------------------
--	2)	Criação de duas databases para realizar os testes de gerenciamento de acessos
--------------------------------------------------------------------------------------------------------------------------------
if exists(select name from sys.databases where name = 'Treinamento_Modulo02_1')
	drop database Treinamento_Modulo02_1

Create database Treinamento_Modulo02_1

if exists(select name from sys.databases where name = 'Treinamento_Modulo02_2')
	drop database Treinamento_Modulo02_2

Create database Treinamento_Modulo02_2

--------------------------------------------------------------------------------------------------------------------------------
--	3)	Criação de um Login chamado "Fabricio"
--------------------------------------------------------------------------------------------------------------------------------
--	Via interface gráfica, seguir os passos abaixo:

--	3.1)	No "Object Explorer", em "Security" -> "Logins"

--	3.2)	Clicar com o botão direito em "Logins" -> "New Login"

--	3.3)	Colocar o nome "Fabricio"

--	3.4)	Escolher a opção "SQL Server Authentication"

--	3.5)	Definir uma senha: "fabricio@123"

--	3.6)	Habilitar a opção "Enforce password policy"

--	3.7)	Em "Default database", escolher a database "Treinamento_Modulo02_1" como a database default desse login

--	3.8)	No canto esquerdo da tela de criação de login, clicar em "User Mapping"

--	3.9)	Em "Users mapped to this login", selecionar a database "Treinamento_Modulo02_1"

--	3.10)	Se dermos um OK nesse momento já criamos o login. Contudo, vamos gerar o script de criação desse login. Para isso 
--			basta clicar em "Script" na parte superior da tela de criação de Login. Após a geração do script, podemos cancelar a 
--			criação do login via interface gráfica.

--	3.11)	Ao fazer isso, uma nova tela é aberta com o script abaixo. Nele podemos ver o nome do login que criamos, 
--			a senha, a database default, a opção de policy habilitada e etc. Execute esse script para criar o login:

--	Script para a criação do Login
USE [master]
GO

CREATE LOGIN [Fabricio] WITH PASSWORD=N'fabricio@123', 
DEFAULT_DATABASE=Treinamento_Modulo02_1, 
CHECK_EXPIRATION=OFF, CHECK_POLICY=ON

GO
--	Script para a criação do usuário dentro da database Treinamento_Modulo02
USE Treinamento_Modulo02_1
GO
CREATE USER [Fabricio] FOR LOGIN [Fabricio]
GO

--------------------------------------------------------------------------------------------------------------------------------
--	4)	Validação do login criado
--------------------------------------------------------------------------------------------------------------------------------
--	Query para ver informações dos logins criados no banco de dados
SELECT	name,
		create_date,
		modify_date,
		LOGINPROPERTY(name, 'DaysUntilExpiration') DaysUntilExpiration,
		LOGINPROPERTY(name, 'PasswordLastSetTime') PasswordLastSetTime,
		LOGINPROPERTY(name, 'IsExpired') IsExpired,
		LOGINPROPERTY(name, 'IsMustChange') IsMustChange,*
From sys.sql_logins 

--------------------------------------------------------------------------------------------------------------------------------
--	5)	Logar no SQL Server com o Login Fabricio.
--------------------------------------------------------------------------------------------------------------------------------
--	No "Object Explorer" -> "Connect" -> "Database Engine" -> Mudar o modo de autenticação de "Windows Authentication"
--	para "SQL Server Authentication" -> Colocar o usuário que criamos "Fabricio" e a senha "fabricio@123"

--------------------------------------------------------------------------------------------------------------------------------
--	6)	Ao logar com Login Fabricio, o SQL Server já abre uma conexão no banco para esse usuário.
--------------------------------------------------------------------------------------------------------------------------------
--	Query para conferir as conexões de um determinado usuário
select * from sys.sysprocesses 
where loginame = 'Fabricio' 

--------------------------------------------------------------------------------------------------------------------------------
--	7)	Abrir uma nova query com o usuário "Fabricio"
--------------------------------------------------------------------------------------------------------------------------------
--	No "Object Explorer" -> Clicar em cima da conexão desse login -> "New Query"

--------------------------------------------------------------------------------------------------------------------------------
--	8)	Nessa nova query que foi aberta com o usuário Fabricio executar os comandos abaixo
--------------------------------------------------------------------------------------------------------------------------------
--	Tentar se conectar em outra base de dados de usuário que exista no seu SQL Server
use Treinamento_Modulo02_2

--	Como não demos acesso a essa database, recebemos o erro abaixo:
--	The server principal "Fabricio" is not able to access the database Treinamento_Modulo02_2 under the current security context.

--------------------------------------------------------------------------------------------------------------------------------
--	9)	Com seu login de "sysadmin", criar a tabela abaixo e inserir os registros na base "Treinamento_Modulo02_1"
--------------------------------------------------------------------------------------------------------------------------------
use Treinamento_Modulo02_1

Create Table Modulo02(
	Id_Treinamento int identity,
	Dt_Referencia datetime default(getdate()),
	Ds_Observacao varchar(1000))
GO
 
insert into Modulo02(Ds_Observacao)
select 'Teste Acesso Database'
GO 10  -- Esse comando GO 10, repete 10 vezes o meu comando de insert

-- Tentar executar esse select com o usuário "Fabricio" em outra conexão
select * from Modulo02 

-- Recebemos um erro
--	Msg 229, Level 14, State 5, Line 1
--	The SELECT permission was denied on the object 'Modulo02', database 'Treinamento_Modulo02', schema 'dbo'.

-- Liberar esse acesso com seu login "sysadmin"
GRANT SELECT ON Modulo02 TO Fabricio

-- Tentar fazer o mesmo select com o login "Fabricio"
select * from Modulo02 

-- Agora o comando é executado com sucesso.

--------------------------------------------------------------------------------------------------------------------------------
--	10)	Liberação de acesso para Função
--------------------------------------------------------------------------------------------------------------------------------
--	Criar a função abaixo com o Login "sysadmin"
create function fncModulo02 (@Id int)
returns table
as
return 
(
	select *
	from Modulo02
	where Id_Treinamento = @Id
)

--	Tentar executar a função com o usuário "Fabricio"
select *
from fncModulo02(1)

--	Recebemos um erro
--	Msg 229, Level 14, State 5, Line 1
--	The SELECT permission was denied on the object 'fncModulo02', database 'Treinamento_Modulo02', schema 'dbo'.

--	Liberar esse acesso com seu login "sysadmin"
GRANT SELECT ON fncModulo02 TO Fabricio

--	Tentar executar a função com o usuário "Fabricio"
select *
from fncModulo02(1)

--	Agora o comando é executado com sucesso.

--------------------------------------------------------------------------------------------------------------------------------
--	11)	Liberação de acesso para uma VIEW
--------------------------------------------------------------------------------------------------------------------------------
--	Criar a View abaixo com o Login "sysadmin"
Create View vwModulo02 
AS
select *
from Modulo02

--	Tentar executar a função com o usuário "Fabricio"
select * from vwModulo02

--	Recebemos um erro
--	Msg 229, Level 14, State 5, Line 1
--	The SELECT permission was denied on the object 'vwModulo02', database 'Treinamento_Modulo02', schema 'dbo'.

--	Liberar esse acesso com seu login "sysadmin"
GRANT SELECT ON vwModulo02 TO Fabricio

--	Tentar executar a função com o usuário "Fabricio"
select * from vwModulo02

--	Agora o comando é executado com sucesso.

--------------------------------------------------------------------------------------------------------------------------------
--	12) Liberação de acesso para uma Procedure
--------------------------------------------------------------------------------------------------------------------------------
--	Criar a Procedure abaixo com o Login "sysadmin"
Create procedure stpModulo02
AS
select *
from Modulo02

--	Tentar executar a procedure com o usuário "Fabricio"
exec stpModulo02

--	Recebemos um erro
--	Msg 229, Level 14, State 5, Procedure stpModulo02, Line 1
--	The EXECUTE permission was denied on the object 'stpModulo02', database 'Treinamento_Modulo02', schema 'dbo'.

--	Liberar esse acesso com seu login "sysadmin"
GRANT EXECUTE ON stpModulo02 TO Fabricio

--	Tentar executar a Procedure com o usuário "Fabricio"
exec stpModulo02

--	Agora o comando é executado com sucesso.

--------------------------------------------------------------------------------------------------------------------------------
--	13) Liberação de acessos para várias procedures
--------------------------------------------------------------------------------------------------------------------------------
--	Criar as Procedures abaixo com o Login "sysadmin"
Create procedure stpModulo02_2
AS
select *
from Modulo02

GO

Create procedure stpModulo02_3
AS
select *
from Modulo02

--	Tentar executar a procedure com o usuário "Fabricio"
exec stpModulo02_2
exec stpModulo02_3

--	Liberação de execute para TODAS as procedures do banco
GRANT EXECUTE TO Fabricio

--	Tentar executar a procedure com o usuário "Fabricio"
exec stpModulo02_2
exec stpModulo02_3

--	Agora as procedures são executadas com sucesso

--	Retirando o acesso de uma procedure. 
DENY EXECUTE ON stpModulo02_2 TO Fabricio

--	Agora ele tem acesso a todas as procedures, com exceção dessa "stpModulo02_2"

--	Tentar executar a procedure com o usuário "Fabricio"
exec stpModulo02_2
exec stpModulo02_3

--	A procedure "stpModulo02_3" funciona e a procedure "stpModulo02_2" retorna o erro abaixo:
--	Msg 229, Level 14, State 5, Procedure stpModulo02_2, Line 1
--	The EXECUTE permission was denied on the object 'stpModulo02_2', database 'Treinamento_Modulo02', schema 'dbo'.

--------------------------------------------------------------------------------------------------------------------------------
--	14) Liberando acesso para uma procedure que acessa duas databases
--------------------------------------------------------------------------------------------------------------------------------
--	Criar uma tabela na database "Treinamento_Modulo02_2"
use Treinamento_Modulo02_2

Create table Modulo02_Database2(cod int)

insert into Modulo02_Database2
select 20

--	Voltar para a base principal de teste
use Treinamento_Modulo02_1

--	Criar a Procedure abaixo com o Login "sysadmin"
Create procedure stpModulo02_4
AS
BEGIN
	select *
	from Modulo02

	select * from Treinamento_Modulo02_2..Modulo02_Database2
END

--	Tentar executar a procedure com o usuário "Fabricio"
exec stpModulo02_4

--	A procedure retorna o primeiro select, mas da um erro no segundo:
--	Msg 916, Level 14, State 1, Procedure stpModulo02_4, Line 7
--	The server principal "Fabricio" is not able to access the database "Treinamento_Modulo02_2" under the current security context.

--	Isso acontece porque o usuario "Fabricio" não tem acesso na database "Treinamento_Modulo02_2" e tabela "Modulo02_Database2"

--	Criar o usuario na database "Treinamento_Modulo02_2"
USE Treinamento_Modulo02_2
GO
CREATE USER [Fabricio] FOR LOGIN [Fabricio]
GO

USE Treinamento_Modulo02_2

GRANT SELECT ON Modulo02_Database2 TO [Fabricio]

-- Tentar novamente executar a procedure com o usuário "Fabricio"
USE Treinamento_Modulo02_1
exec stpModulo02_4

--------------------------------------------------------------------------------------------------------------------------------
--	15) Realizando testes com o DENY e REVOKE
--------------------------------------------------------------------------------------------------------------------------------
USE Treinamento_Modulo02_1

--	Query para retornar as permissões que são dadas a nível de objetos (Mt bacana!)
SELECT	STATE_DESC,prmssn.permission_name AS [Permission], sp.type_desc, sp.name, 
		grantor_principal.name AS [Grantor], grantee_principal.name AS [Grantee] 
FROM sys.all_objects AS sp 
	INNER JOIN sys.database_permissions AS prmssn ON prmssn.major_id = sp.object_id AND prmssn.minor_id = 0 AND prmssn.class = 1 
	INNER JOIN sys.database_principals AS grantor_principal ON grantor_principal.principal_id = prmssn.grantor_principal_id 
	INNER JOIN sys.database_principals AS grantee_principal ON grantee_principal.principal_id = prmssn.grantee_principal_id 
WHERE grantee_principal.name = 'Fabricio'

--	Query para visualizar as Database Roles. Deve executar em cada database separadamente. (Mt Legal tb!!!)
SELECT p.name, p.type_desc, pp.name, pp.type_desc, pp.is_fixed_role
FROM sys.database_role_members roles 
	JOIN sys.database_principals p ON roles.member_principal_id = p.principal_id
	JOIN sys.database_principals pp ON roles.role_principal_id = pp.principal_id
ORDER BY 1

--	Executar esse select com o Login Fabricio
SELECT * from Modulo02

--	Revogar a permissão de SELECT dada para esse objeto e conferir com a primeira query do passo 15 dessa DEMO
REVOKE SELECT ON Modulo02 TO Fabricio

--	Liberar novamente a permissão de SELECT e conferir com a primeira query do passo 15 dessa DEMO
GRANT SELECT ON Modulo02 TO Fabricio

--	Executar um DENY de SELECT nessa tabela e conferir com a primeira query do passo 15 dessa DEMO
DENY SELECT ON Modulo02 TO Fabricio

--	Como pode ser visto na query o DENY substitui a permissão de select. Se executarmos o GRANT, ele também substitui o DENY

--	Liberar novamente a permissão de SELECT e conferir com a primeira query do passo 15 dessa DEMO
GRANT SELECT ON Modulo02 TO Fabricio

--	Se não quero dar nem GRANT e nem DENY, o REVOKE retira a última permissão liberada para esse objeto, seja ele GRANT ou DENY.
--	Esse REVOKE vai remover o GRANT, que foi a última permissão dada nessa tabela para esse login
REVOKE SELECT ON Modulo02 TO Fabricio

--	Agora vamos dar um DENY para negar o acesso a tabela
DENY SELECT ON Modulo02 TO Fabricio

--	Esse REVOKE vai retirar o DENY, que foi a última permissão dada nessa tabela para esse login
REVOKE SELECT ON Modulo02 TO Fabricio

--------------------------------------------------------------------------------------------------------------------------------
--	16) Caso de uso do DENY em uma situação real do dia a dia
--------------------------------------------------------------------------------------------------------------------------------
--	Liberação de read em todas as tabelas da base

--	Liberando permissão de leitura para todas as tabelas, functions e views da database Treinamento_Modulo02_1 para 
--	o login Fabricio
USE Treinamento_Modulo02_1
GO
ALTER ROLE [db_datareader] ADD MEMBER [Fabricio]

GO
--	Criação de uma tabela de salário nessa database
if object_id('Salario') is not null
	drop table Salario

CREATE TABLE Salario(
	Id_Colaborador int identity,
	Nm_Colaborador varchar(100),
	Vl_Salario numeric(9,2) 
)

--	Inserção dos salários. Dados meramente ilustrativos!!!!!
insert into Salario(Nm_Colaborador,Vl_Salario)
select 'Estagiario', 675.00
insert into Salario(Nm_Colaborador,Vl_Salario)
select 'Gerente', 20000
insert into Salario(Nm_Colaborador,Vl_Salario)
select 'DBA em São Paulo', 10000
insert into Salario(Nm_Colaborador,Vl_Salario)
select 'DBA em Vitória', 3000

--	Executar esse select com o Login Fabricio
select * from Salario

--	Deixar o usuário Fabricio ter acesso a todas as tabelas, com exceção da tabela de Salário
DENY SELECT on Salario TO [Fabricio]

--	Ao tentar executar novamente o select com o login Fabricio recebemos o erro abaixo
--	Msg 229, Level 14, State 5, Line 1
--	The SELECT permission was denied on the object 'Salario', database 'Treinamento_Modulo02', schema 'dbo'.

--	Pronto. Agora ninguém vai ficar olhando salário dos companheiros de trabalho e ficar pedindo aumento para o chefe.

DENY SELECT on Salario TO [Fabricio]

--Retira o DENY e o Fabricio tem acesso novamente
REVOKE SELECT on Salario TO [Fabricio]

-- Nega acesso apenas a coluna Salário
DENY SELECT on Salario(Vl_Salario) TO [Fabricio]

-- Agora ele só tem acesso as outras colunas
select Id_Colaborador, Nm_Colaborador from Salario

--------------------------------------------------------------------------------------------------------------------------------
--	17) Exclusão do Login Fabricio
--------------------------------------------------------------------------------------------------------------------------------
--	Nesse último teste da demo vamos excluir o Login "Fabricio"

--	Script para conferir se o login Fabricio tem alguma conexão aberta
select loginame, 'kill ' + cast(spid as char(2)),*
from sysprocesses
where loginame = 'Fabricio'

--	Matar a conexão aberta para excluir o Login
kill 53
kill 55

--	17.1) Para excluir o Login via interface gráfica, basta ir no "Object Explorer" -> "Security" -> "Login"

--	Em seguida clicar com o botão direito em cima do login "Fabricio" -> Escolher a opção "Delete" 
--	-> Clicar em "OK" -> Confirmar a operação em "OK" novamente.

--	Feito isso o Login está excluído.

--	17.2) Contudo, o usuário "Fabricio" não é excluído automaticamente da base de dados.

--	Ele tem que ser excluído manualmente para não ficar lixo.

--	Se Abrir a base "Treinamento_Modulo02_1" -> "Security" -> "Users".

--	Vai ver que o Login "Fabricio" está Lá.

--	O que fazer?????

--	Basta clicar com o botão direito -> Escolher a opção "Delele" para excluir esse usuário.

--	Não sei porque, mas o SQL Server trabalha assim e temos que realizar essas exclusões manualmente para não deixar lixo nas bases de dados.