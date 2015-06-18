## Passos para alterar um programa do GIS

1. Premissas
2. Alterar
3. Compilar
4. Transferir
5. Testar
6. Liberar para o usuário testar
7. Liberar em produção

### 1. Premissas
- Antes de iniciar o desenvolvimento colocar o incidente **`EM PROGRAMAÇÃO`**.

### 2. Alterar
- Executar o ícone `GIS DESENV`
- Abrir o arquivo localizado em `G:\GIS\fontes-d\`
- Fazer as alterações e salvar o arquivo

### 3. Compilar
- Após realizar as alterações, pressionar `F1` para compilar e transferir o programa para o servidor UNIX

### 4. Transferir
- Executar o ícone `HPI`
- Fazer login utilizando seu usuário e senha
- Executar o comando `gis`
- Pressionar `d` para selecionar a opção `Transferir programas para o ambiente de testes` e após `ENTER`
- Informar o nome do programa a ser transferido (exemplo: `gis222e`) e pressionar `ENTER`
  - Em caso de sucesso, pressionar `ENTER` para retornar à tela anterior
  - Em caso de falha, verificar o passo **2**

### 5. Testar
- Pressionar `t` para `Testar programas individualmente` e após `ENTER`
- Informar o nome do programa a ser testado e pressionar `ENTER`
- Testar o programa

> **Dica**: para confirmar que suas alterações foram compiladas e transferidas para o ambiente de testes, execute o programa (individualmente ou pelo menu), pressione `F2`e acesse o menu `8` (`Informações Técnicas`), verificando se o usuário e horário da última compilação coincidem com o seu.

### 6. Liberar para o usuário testar
- Colocar o incidente **`EM VALIDAÇÃO`**, salientando que o usuário deve validar utilizando o ambiente de testes
- Seguir adiante e atender outro `SDT` enquanto aguarda o retorno da validação :-)

### 7. Liberar em produção
- Após o usuário validar o incidente, abrir novamente o GIS e pressionar `p` para selecionar a opção `Transferir programas para a produção` e após `ENTER`
- Informar o nome do programa a ser transferido e pressionar `ENTER`
  - Caso ocorra o erro `Error starting the program shown below! atup.bat` no `Netterm`, verificar se o fonte foi atualizado em `G:\GIS\fontes-p`. Em caso negativo, entrar em contato com o departamento de TI
- Alterar o incidente para a situação **`FECHADO`**, informando que já foi liberado em produção

FIM! :-)
