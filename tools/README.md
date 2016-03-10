# Ferramentas e Utilidades

## Suíte de Debug

Esta suíte de debug contém algumas funções bem simples que irão padronizar e auxiliar o debug de seus programas no AIT. Além de poder armazenar mensagens ao longo da execução do programa, a suíte também realiza a contabilização do tempo de execução *automagicamente* para nós. :+1:

#### Inclua a suíte em seu programa

```abl
{include_utils.i debug}
```

#### Utilize a função `debug` para armazenar mensagens

```abl
debug("Teste").
debug("Passei por aqui").
debug("vacao = " + vacao).
```

#### Utilize a função `output-debug` em conjunto com `is-debug` para imprimir as mensagens armazenadas

Você pode utilizar da forma que achar melhor. Particularmente eu gosto de definir um elemento `<pre>` com cor destacada para exibir. A vantagem é que se o elemento não possuir nenhum conteúdo, ele não é renderizado. :smile_cat: 

Em algum ponto do HTML:

```HTML
<pre id="debug" style="background-color: #FFC7C7;"></pre>
```

E em um JavaScript *no final* da execução do seu programa.

```JavaScript
$(document).ready(function() {
  if (` string(is-debug(), "true/false") `) {
    $("#debug").html("` output-debug() `");
  }
}
```

#### Exemplo de Uso

![Suíte de Debug](http://s12.postimg.org/5vl4ykh0d/suite_debug.png)
