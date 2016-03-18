<script language="SpeedScript">
/*------------------------------------------------------------------------------
  Empresa...: ThyssenKrupp Elevadores
  Sistema...: AIT - Aplicacoes Integradas TKE
  Programa..: ait_MODX9.html
  Descricao.: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  Autor.....: NOME (DEPARTAMENTO ou EMPRESA)
  Data......: 99/99/9999

  Data       Autor    Alteracao
  ---------- -------- ----------------------------------------------------------
  99/99/9999 NOME     SDT 999999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
------------------------------------------------------------------------------*/

/* Literais ----------------------------------------------------------------- */
&scoped-define IMG-DETALHE  '<img src="/ait/images/detalhe.gif"/>'
&scoped-define IMG-ATIVO    '<img src="/ait/images/marcadorok.gif"/>'
&scoped-define IMG-INATIVO  '<img src="/ait/images/marcadorproibido.gif"/>'
&scoped-define LBL-CONCEITO sis_idioma("lblPacote")

/* Includes ----------------------------------------------------------------- */
{include_variaveis_globais.i}
{include_idioma.i}

/* Funções Importadas ------------------------------------------------------- */
{include_utils.i debug}

/* Funções ------------------------------------------------------------------ */
function minhaFuncao returns char (input f-param as char) forward.

/* Variáveis Compartilhadas ------------------------------------------------- */
def new global shared var v1  as char  no-undo init "".
def     global shared var v2  as int   no-undo init 0.

/* Variáveis Globais -------------------------------------------------------- */
def var vacao                 as char  no-undo init "montar t-princ".
def var vtableid              as char  no-undo init "table01".
def var vcont-reg             as int   no-undo init 0.

/* Buffers ----------------------------------------------------------------- */
def buffer btabela1 for tabela1.
def buffer btabela2 for tabela2.

/* Temp-Table -------------------------------------------------------------- */
def temp-table tt-coisas no-undo
   field tt-rowid  as rowid
   field tt-campo1 as char
   field tt-campo2 as int
   field tt-campo3 as decimal
   index tt01 is primary unique tt-rowid.

/* Stream ------------------------------------------------------------------ */
def stream st-in.

/*------------------------------------------------------------------------------
Objetivo:   Processa Requisição HTML
------------------------------------------------------------------------------*/
procedure output-headers:
   /* remove linhas de comentario HTML de creditos do StarWeb no inicio e fim do programa */
   desativarHeaderPadraoDoSWFW().

   /* manipulações de cookies por parte do servidor StarWeb devem ocorrer neste ponto */
end procedure.
</script>

<!DOCTYPE html>
<html>
   <head>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>`sis_idioma("titJanela")`</title>
      <link rel="stylesheet" type="text/css" href="/ait/css/estilo.css">
      `/*<link rel="stylesheet" type="text/css" href="/ait/javascript/jquery/ui/jquery-ui.min.css">*/`
      <script type="text/javascript" src="/ait/javascript/jquery/jquery-1.11.3.min.js"></script>
      `/*<script type="text/javascript" src="/ait/javascript/jquery/ui/jquery-ui.min.js"></script>*/`
      <style type="text/css">
      </style>
      <script type="text/javascript">
        // defina suas funções neste ponto

         $(document).ready(function() {
            sis_pageLoaded();
            sis_addMsgStatusBar();
            sis_show_messages();
            setFocus();

            // invoque suas funções DEPOIS deste ponto
         });
      </script>
   </head>
   <body class="body_1">
      <script language="SpeedScript">
         {include_javascript_cookie.i}
         {include_ajax.i}
         {include_tooltip.i}
         {include_botao.i}
         {include_mensagem.i}
         {include_status.i}
         {include_seguranca.i}
         {include_perm_prog.i}
         {include_log.i "menu"}
         {include_log.i "programa"}
         {include_browse.i init}
         {include_ordenacao.i 1}
         {include_div_carregando.i}
         {include_div_areas_do_sistema.i}
         {include_bloqueio.i}
      </script>
      <script type="text/javascript">sis_pageLoading();</script>
      <table border="0" width="99%" style="margin:6px">
         <tr>
            <td align="left" valign="top">
               <script language="SpeedScript">
                  vacao = trim(get-value("vacao")).
                  if vacao = "" then vacao = "montar t-princ".

                  loop: do while true:
                     debug("vacao = " + vacao).

                     case vacao:
                        when "montar t-princ" then do:
                           run p-principal.
                           leave loop.
                        end.
                        when "editar" then do:
                           run p-editar.
                           leave loop.
                        end.
                        when "novo" then do:
                           run p-novo.
                           leave loop.
                        end.
                        when "criar" then do:
                           run p-criar.
                           if not can-find(first tt-erros) then do:
                              vacao = "montar t-princ".
                              next.
                           end.
                           verros = true.
                           vacao = "novo".
                        end.
                        when "atualizar" then do:
                           run p-atualizar.
                           if not can-find(first tt-erros) then do:
                              vacao = "montar t-princ".
                              next.
                           end.
                           verros = true.
                           vacao = "editar".
                        end.
                        when "excluir" then do:
                           run p-excluir.
                           if not can-find(first tt-erros) then do:
                              vacao = "montar t-princ".
                              next.
                           end.
                           verros = true.
                           vacao = "editar".
                        end.
                        otherwise do:
                           sis_queue_message("aviso", sis_idioma("msgNaoAchouAcao"), false).
                           leave loop.
                        end.
                     end case. /* case vacao */
                  end. /* loop: do while true */
               </script>
            </td>
         </tr>
      </table>
      <script type="text/javascript">
         $(document).ready(function() {
            // Use este espaço para fazer coisas legais

            // Invoca a suíte de debug
            if (` string(is-debug(), "true/false") `) {
               $("#debug").html("` output-debug() `");
            }
         });
      </script>
   </body>
</html>

<script language="SpeedScript">

/* Procedures Principais ---------------------------------------------------- */

/*------------------------------------------------------------------------------
Objetivo: Exibir uma lista com os registros existentes.
------------------------------------------------------------------------------*/
procedure p-principal:
end procedure.

/*------------------------------------------------------------------------------
Objetivo: Exibir tela para inclusão de um novo registro.
------------------------------------------------------------------------------*/
procedure p-novo:
   run p-formulario.
end procedure.

/*------------------------------------------------------------------------------
Objetivo: Exibir tela para para edição de um registro já existente.
------------------------------------------------------------------------------*/
procedure p-editar:
   run p-formulario.
end procedure.

/*------------------------------------------------------------------------------
Objetivo: Validar e persistir a criação de um novo registro.
------------------------------------------------------------------------------*/
procedure p-criar:
end procedure.

/*------------------------------------------------------------------------------
Objetivo: Validar e persistir a atualização de um registro existente.
------------------------------------------------------------------------------*/
procedure p-atualizar:
end procedure.

/*------------------------------------------------------------------------------
Objetivo: Validar a operação e excluir um registro existente.
------------------------------------------------------------------------------*/
procedure p-excluir:
end procedure.

/* Procedures Auxiliares ---------------------------------------------------- */

/*------------------------------------------------------------------------------
Objetivo: Montar o form para edição para edição de um registro (novo ou edição).
------------------------------------------------------------------------------*/
procedure p-formulario:
end procedure.

/* Implementação de Funções ------------------------------------------------- */

/*------------------------------------------------------------------------------
Objetivo: Fazer alguma coisa.
------------------------------------------------------------------------------*/
function minhaFuncao returns char (input f-param as char):
   return f-param.
end function.

</script>
