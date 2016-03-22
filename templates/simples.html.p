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
def new global shared var v1    as char  no-undo. /* ??? nunca deve ser usado global shared em web */
def new shared var v2  as int   no-undo. /* define uma nova variavel a ser compartilhada */
def     shared var v3  as int   no-undo. /* le a variavel que foi compartilhada no programa pai */

/* Variáveis Globais -------------------------------------------------------- */
def var vacao                   as char  no-undo init "montar t-princ".
def var vtableid                as char  no-undo init "table01".
def var vcont                   as int   no-undo.

/* Buffers ----------------------------------------------------------------- */
def buffer bf-tabela1 for tabela1.
def buffer bf-tabela2 for tabela2.

/* Temp-Table -------------------------------------------------------------- */
def temp-table tt-coisas        no-undo
  field campo1                  as char
  field campo2                  as int
  field campo3                  as decimal
  index tt01                    is primary unique campo1.

/* Stream ------------------------------------------------------------------ */
def stream s-in.

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
    // defina suas funções, que serão usadas para todas as telas, neste ponto
    
    $(document).ready(function() {
      sis_pageLoaded();
      sis_addMsgStatusBar();
      sis_show_messages();
      setFocus();
    
      // chamada a logicas, que serão executadas para todas as telas (listagem, detalhe, ...), neste ponto
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

  <div class="main-box">

  <script language="SpeedScript">
  /* ****************************** Main Block ******************************* */

  assign vacao      = trim(get-value("vacao"))
         vmodo      = trim(get-value("modo"))
         vpesquisar = trim(get-value("pesquisar"))
         .

  if vacao = "" then vacao = "montar t-princ".

  loop: do while true:
    case vacao:
  
      /* Tela Principal */
      when "montar t-princ" then do:
        run p-principal.
        leave loop.
      end.

      /* Tela Incluir */
      when "incluir" then do:
        run p-detalhe("incluir").
        leave loop.
      end.

      /* Tela Editar */
      when "editar" then do:
        run p-detalhe("editar").
        leave loop.
      end.

      /* Salvar */
      when "salvar" then do:
        run p-salva(vmodo).
        if return-value = "OK":u then 
             vacao = "montar t-princ".
        else vacao = vmodo.
        next loop.
      end.

      /* Excluir */
      when "excluir" then do:
        run p-exclui.
        if return-value = "OK":u then
          vacao = "montar t-princ".
        next loop.
      end.

      otherwise do:
        sis_queue_message("aviso", sis_idioma("msgNaoAchouAcao"), false).
        leave loop.
      end.

    end. /* case vacao */
  end. /* loop: do while true */
  
  /*------------------------------------------------------------------------------
  Objetivo: Gera tela principal.
  ------------------------------------------------------------------------------*/
  procedure p-principal:
  </script>

  <table border="0" width="100%">
    <tr>
      <td align="left" valign="top">
        <h3 class="titulo_1" align="center">
          `replace(sis_idioma("titManutencaoConceito"),"~{1~}",{&LBL-CONCEITO})`
          <script language="SpeedScript">{include_caminho_menu.i}</script>
        </h3>
        
        <form id="generico" name="generico" action="`selfURL`" method="post">
          <input type="hidden" name="sis_menupath" value="`vsis-menupath`"/>
          <input type="hidden" name="acao" value=""/>
        
          `/*<!-- FILTRO -->*/`
          <table class="filtro cabecalho" border="0" cellspacing="0" cellpadding="1" width="760">
            <tr class="cabecalho">
              <td align="left">
                <span>`sis_idioma("lblDescricao")`:&nbsp;</span><input type="text" name="pesquisar" value="`vpesquisar`" class="field_enabled_1" size="20"/>&nbsp;
                <a href="#" onclick="filtrar();"><img src="/images/icon_lupa.gif" alt="`sis_idioma('lblPesquisar')`"></a>
              </td>
              <td align="right"><span id="countReg"></span>&nbsp;`sis_idioma("lblTotaldeRegistros")`</td>
            </tr>
          </table>
          `/*<!-- FIM FILTRO -->*/`

          <script language="SpeedScript">
          {include_ordenacao.i 2 vtableid}
          {include_browse.i start 760 4 vtableid sis_pageLoading()} /* inicio do browse */
        
          assign v-brw-header-align[1] = 'center" width="8"'       v-brw-header-text[1] = ''
                 v-brw-header-align[2] = 'left" width="3"'         v-brw-header-text[2] = sis_idioma("lblCodigo")
                 v-brw-header-align[3] = 'left"'                   v-brw-header-text[3] = sis_idioma("lblDescricao")
                 v-brw-header-align[4] = 'left" width="1"'         v-brw-header-text[4] = sis_idioma("lblAtivo")
                 .
                 
          {include_browse.i header} /* exibe o cabecalho do browser */
        
          for each gmd-pacote no-lock where
                   gmd-pacote.gpc-desc matches "*" + vpesquisar + "*":
        
            assign v-brw-datarow-link     = selfURL + "?sis_menupath=" + vsis-menupath + "&link-det=s&gpc_cod=" + string(gmd-pacote.gpc-cod)
                   v-brw-datarow-align[1] = 'left"'               v-brw-datarow-text[1] = {&IMG-DETALHE}
                   v-brw-datarow-align[2] = 'left"'               v-brw-datarow-text[2] = string(gmd-pacote.gpc-cod)
                   v-brw-datarow-align[3] = 'left"'               v-brw-datarow-text[3] = trim(gmd-pacote.gpc-desc)
                   v-brw-datarow-align[4] = 'center"'             v-brw-datarow-text[4] = iif(gmd-pacote.gpc-ativo, {&IMG-ATIVO}, {&IMG-INATIVO})
                   vcont-reg              = vcont-reg + 1
                   .
            {include_browse.i datarow} /* exibe linha do browser */
          end. /* for each gmd-pacote */
          
          if vcont-reg = 0 then sis_queue_message("aviso", sis_idioma("msgNenhumRegistroEncontrado"), false).
          {include_browse.i end} /* fim do browser */
          </script>
        </form>
      </td>
    </tr>
  </table>

  <script type="text/javascript">
  
    sis_addButton(true, null, "btnIncluir", "btnIncluir", "`sis_idioma("btnIncluir")`", null, "botaoPequeno", null, "incluir()", 9);
    sis_addButton(true, null, "btnCancelar", "btnCancelar", "", "`sis_idioma("msgCliqueAquiSairTelaAtualRetornarTelaPrinc")`", "botaoPequeno", "width:22px; background-image:url(/ait/images/cancelar.png); background-repeat:no-repeat; background-position:center center;", "location='`selfURL`?sis_menupath=`vsis-menupath`';", null);

    // defina suas funções, que serão usadas apenas nesta tela, neste ponto
    
    function incluir() {
      sis_addHiddenField(document.generico, "acao", "incluir"); 
      document.generico.submit();
    }
    
    function filtrar() {
      sis_addHiddenField(document.generico, "acao", ""); 
      document.generico.submit();
    }
    
    $(document).ready(function() {
      // chamada a logicas, que serão executadas apenas nesta tela, neste ponto

      // Invoca a suíte de debug
      if (`string(is-debug(), "true/false")`) {
         $("#debug").html("`output-debug()`");
      }
    });
  </script>
  
  <script language="SpeedScript">
  end procedure. /* p-principal */

  /*------------------------------------------------------------------------------
  Objetivo: Gera tela de detalhe.
  ------------------------------------------------------------------------------*/
  procedure p-detalhe:
    def input param p-modo  as char no-undo.

    def var vid             as char no-undo.
    def var vtitulo         as char no-undo.

    case p-modo:
       when "incluir" then vtitulo = "titInclusaoConceito".
       when "editar"  then vtitulo = "titEdicaoConceito".
    end case.
  </script>
  
  <table border="0" width="100%" style="margin:6px">
    <tr>
       <td align="left" valign="top">
          <h3 class="titulo_1" align="center">
             `replace(sis_idioma(vtitulo),"~{1~}",{&LBL-CONCEITO})`
             <script language="SpeedScript">{include_caminho_menu.i}</script>
          </h3>

          <form id="generico" name="generico" action="`selfURL`" method="post">
             <input type="hidden" name="sis_menupath" value="`vsis-menupath`"/>
             <input type="hidden" name="modo" value="`p-modo`"/>

             <table class="normal" border="0">
                <tr>
                   <td class="label_enabled_1" align="right">`sis_idioma("lblCodigo")`:</td>
                   <td><input type="text" class="field_disabled_1" id="gpc_cod" name="gpc_cod" size="2" value="`vgpc-cod`" readOnly/>&nbsp;`vsis-obrig`</td>
                </tr>
                <tr>
                   <td class="label_enabled_1" align="right">`sis_idioma("lblDescricao")`:</td>
                   <td><input type="text" class="field_enabled_1" id="gpc_desc" name="gpc_desc" maxlength="40" size="40" value="`vgpc-desc`"/>&nbsp;`helpIcon(sis_idioma("lblDescricao"), sis_idioma("msgHelpDescricaoDoPacote"))`&nbsp;`vsis-obrig`</td>
                </tr>
                <tr>
                   <td>&nbsp;</td>
                   <td><input type="checkbox" class="field_enabled_1" id="gpc_ativo" name="gpc_ativo" value="yes" `iif(vgpc-ativo,"checked","")`/><span class="field_enabled_1">`sis_idioma("lblAtivo")`</span></td>
                </tr>
             </table>
           </form>
        </td>
     </tr>
  </table>

  <script type="text/javascript">
    var modo = "`p-modo`";

    sis_addButton(true, null, "btnSalvar", "btnSalvar", "`sis_idioma("btnSalvar")`", null, "botaoPequeno", null, "validaForm();", 9);
    if(modo == "editar") sis_addButton(true, null, "btnExcluir", "btnExcluir", "`sis_idioma("btnExcluir")`", null, "botaoPequeno", null, "excluiRegistro();", null);
    sis_addButton(true, null, "btnCancelar", "btnCancelar", "", "`sis_idioma("msgCliqueAquiSairTelaAtualRetornarTelaPrinc")`", "botaoPequeno", "width:22px; background-image:url(/ait/images/cancelar.png); background-repeat:no-repeat; background-position:center center;", "location='`selfURL`?sis_menupath=`vsis-menupath`';", null);

    function excluiRegistro() {
      if(!confirm('`replace(sis_idioma("msgConfirmaExclusaoConceito"), "~{1~}", sis_idioma("lblPacote"))`')) return false;
      sis_addHiddenField(document.generico, "btnExcluir", "yes");
      sis_pageLoading();
      $("#generico").submit();
    }

    function validaForm() {
      var vcampo = {};
      var verro = false;

      try {

        if(modo == "incluir") {
          vcampo = $("#gpc_cod");
          if(vcampo.val() == "") {
            sis_queue_message('erro', '`replace(sis_idioma("msgPreenchimentoObrigCampo"), "~{1~}", sis_idioma("lblCodigo"))`', false);
            vfieldFocus = vcampo;
            verro = true;
          }
        }

        vcampo = $("#gpc_desc");
        if(vcampo.val() == "") {
          sis_queue_message('erro', '`replace(sis_idioma("msgPreenchimentoObrigCampo"), "~{1~}", sis_idioma("lblDescricao"))`', false);
          vfieldFocus = vcampo;
          verro = true;
        }

        if(verro == true) {
          sis_show_messages();
          setFocus();
          return false;
        }

        sis_addHiddenField(document.generico, "btnSalvar", "yes");
        sis_pageLoading();
        $("#generico").submit();

      } catch(e) {
        alert("Erro de JavaScript! Nao foi possivel validar Formulario.");
        return false;
      }
    }

    $(document).ready(function() {
      switch(modo) {
        case "incluir":
          $("#gpc_desc").focus();
        break;
      }
    });
   </script>

   <script language="SpeedScript">
   end procedure. /* p-detalhe-pacote */

   /* adiciona botoes padroes do sistema */
   {include_help.i}
   {include_imprimir.i}
   {include_favoritos.i}
   {include_prog_inicial.i}
   </script>
</body>
</html>

<script language="SpeedScript">
/* ****************************** Procedures ******************************** */
/*------------------------------------------------------------------------------
Objetivo: Elimina os relacionamentos do usuario com pacote (N2 e N3)
------------------------------------------------------------------------------*/
procedure p-exclui-relacao-pacote-conta:

end procedure.

/* ****************************** Functions ********************************* */
/*------------------------------------------------------------------------------
Objetivo: Fazer alguma coisa.
------------------------------------------------------------------------------*/
function minhaFuncao returns char (input f-param as char):
   return f-param.
end function.

</script>
