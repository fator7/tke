## Passos para alterar um programa do GIS

0. Premissas

1. Alterar
2. Compilar
3. Transferir
4. Testar
5. Liberar para o usuário

### 0. Premissas

Antes de iniciar o desenvolvimento **colocar o incidente `EM PROGRAMAÇÃO`**.

### 1. Alterar
- Executar o ícone `GIS DESENV`
- Abrir o arquivo localizado em `G:\GIS\fontes-d\`
- Fazer as alterações e salvar o arquivo

### 2. Compilar
- Após realizar as alterações, pressionar `F1` para compilar e transferir o programa para o servidor UNIX

### 3. Transferir
- Abrir o ícone `HPI`
- Fazer login utilizando seu usuário e senha
- Executar o comando `gis`
- Pressionar `d` para selecionar a opção `Transferir programas para o ambiente de testes` e após `ENTER`
- Informar o nome do programa a ser transferido (exemplo: `gis222e`) e pressionar `ENTER`
  - Em caso de sucesso, pressionar `ENTER` para retornar à tela anterior
  - Em caso de falha, verificar o passo **2**

### 4. Testar
- Pressionar `t` para `Testar programas individualmente` e após `ENTER`
- Informar o nome do programa a ser testado e pressionar `ENTER`
- Testar o programa

### 5. Liberar para o usuário

- Colocar o incidente **EM VALIDAÇÃO**, salientando que o usuário deve validar utilizando o ambiente de testes
- Seguir adiante e atender outro SDT enquanto aguarda o retorno da validação :-)
