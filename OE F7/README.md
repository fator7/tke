# Configuração de banco Progress local

## Resumo

1. Definir variáveis de ambiente
2. Copiar arquivos
3. Criar banco
4. Testar

### 1. Definir variáveis de ambiente
- Clicar com o botão direito em `Meu Computador > Propriedades > Configurações Avançadas do Sistema`
- Acessar a aba `Avançado > Variáveis de Ambiente > Novo...`

|Variável |Valor                   |
|:--------|:-----------------------|
|DLC      |`C:\DLC102B            `|
|PATH     |`%PATH%;%DLC%;%DLC%\bin`|

### 2. Copiar arquivos
- Fazer o download dos arquivos de configuração em https://github.com/fator7/tke/archive/master.zip
- Extrair o conteúdo da pasta `OE F7` (dentro do arquivo `zip`) para `P:\SVNUsers\<seu.usuario>\`

  A estrutura de diretórios ficará assim:
  ```
  P:\SVNUsers\<seu.usuario>\
  ├── db
  |   ├── dbsF7.st
  |   └── resetDB.bat
  └── icone
      ├── AIT F7.lnk
      |── carrega-bancos.p
      ├── ini
      |   └── f7.ini
      └── pf
          └── dbs.pf
  ```

> Evite armazenar seus arquivos na unidade `C:\`. Há relatos de problemas bizarros relacionados a isto. Utilize a pasta `P:\SVNUsers\`.

### 3. Criar banco
- Execute o script `P:\SVNUsers\<seu.usuario>\db\resetDB.bat`

### 4. Testar
- Abra o atalho `P:\SVNUsers\<seu.usuario>\icone\AIT F7.lnk`, selecione o banco da `Fator 7` e verifique se está correto.

> Atenção: em um banco recém criado não haverá nenhuma tabela.
