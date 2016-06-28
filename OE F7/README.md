## Configuração de banco Progress local para alterações de dicionário

1. Setar variáveis de ambiente progress
2. Copiar Arquivos
3. Configurações
4. Criar Banco

### 1. Setar variáveis de ambiente progress
- Em Painel de Controle\Sistema e Segurança\Sistema\Configurações Avançadas do Sistema; 
- Aba Avançado, botão Variáveis de Ambiente, Novo...

|Variável |Valor                 |
|:---------|:----------------------|
|DLC      |C:\DLC102B            |
|PATH     |%PATH%;%DLC%;%DLC%\bin|

### 2. Copiar Arquivos
- Copiar para pasta os arquivos do OE F7 em c:\users\teu.usuario\<onde desejar>

### 3. Configurações
- Alterar iniciar em propriedades do ícone: C:\Users\teu.usuario\<onde desejar>\icone
- Salvar arquivos carrega-bancos.p e connect-db.p C:\Users\teu.usuario\<pasta dos teus projetos, se prefirir usar uma>
- Altarar o propath editando o arquivo ".ini" dentro da pasta ini. Colocar o caminho onde salvou o carrega-bancos.p no propath
	- Onde: PROPATH=.,t:\,t:\includes,g:\gis\fontes-t,g:\gis\fontes-p,g:\gis\....
	- Fica: PROPATH=.,C:\Users\teu.usuario\<pasta onde está o carrega-bancos.p>,t:\,t:\includes,g:\gis\fontes-t,g:\gis\fontes-p,g:\gis\....

### 4. Criar Banco
- Dentro do diretório db, executar o resetDB.bat, recriará o banco F7 toda vez que executá-lo.

> **Obs**: Como eu já tinha a estrutura criada, copiei os arquivos para o citrix e saí executando, tentei descrever aqui todos os passos necessários,mas pode ser que faltou alguma coisa, vamos ajustando a medida que forem aparecendo os problemas... 


