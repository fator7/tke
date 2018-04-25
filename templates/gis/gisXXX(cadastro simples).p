/*------------------------------------------------------------------------- 
  Empresa...: ThyssenKrupp Elevadores 
  Sistema...: GIS - Sistema de Gestao Industrial 
  Programa..: gis8d6.p 
  Descricao.: Manutencao da tabela codigo Municipio
  Autor.....: Rodrigo Krigger (Fator 7)
  Data......: abr 2018
 
  Data     Autor    Alteracao
  -------- -------- -----------------------------------------------------
  25/04/18 Krigger  WEB-2107
-------------------------------------------------------------------------*/
 
{uticrip.i gis8d6}
{utidvar.i}
 
def var msn    as log format "S/N" no-undo. 
def var mcod   like tb-municipio.mun-cod no-undo. 

repeat:
   assign mcod = 0.

   update
     mcod help "Informe o cod. do municipio, F9 p/ todos ou F4 p/ sair."
          validate(mcod > 0 or keylabel(lastkey) = "F9","Cod. invalido.")
     go-on(F9) with side-labels frame f1 row 5 center.

   /*** Consulta todos os codigos ***/
   if keylabel(lastkey) = "F9" then do:
      hide frame f1.
      {utiemi.i
        &frame = f2
        &file  = tb-municipio
        &down  = " "
        &line  = "mun-cod mun-desc"
        &with  = "row 5 center"
        &find  = " "
        &hide  = yes
        &nmax  = 1500
        &subm  = "[Selecionar]  [Imprimir]  [Fim]"}
      if xopc = "F" then return.
      if xopc = "I" then do:
         {utiir80.i
          &rel-nome = "Cod. de Municipios"
          &rel-sai  = "*"
          &rel-cab  = " "}
         for each tb-municipio:
            {uticpag.i}
            disp tb-municipio with center.
         end.
         {utifrel.i}
      end.
      next.
   end.

   find first tb-municipio where tb-municipio.mun-cod = mcod no-lock no-error.
   if not avail tb-municipio then do:
      /*** Cadastra codigo ***/
      create tb-municipio.
      message "Codigo novo. Entre seus dados ou F4 para cancelar.".
      update tb-municipio.mun-desc with side-labels frame f3 row 10 center.
      assign tb-municipio.mun-cod = mcod.
      message "Codigo " mcod " criado.".
   end.
   else do:
      /*** Consulta um codigo ***/
      disp mun-desc with frame f3.
      repeat:
         xsubm = "[Selecionar]  [Alterar]  [Excluir]  [Fim]".
         {utisubm.i}
         if xopc = "S" then leave.
         else if xopc = "A" then do:
            if not xp1 then do:
               message "Usuario nao autorizado.".
               next.
            end.
            /*** Altera codigo ***/
            find tb-municipio where tb-municipio.mun-cod = mcod exclusive-lock no-error no-wait.
            if not avail tb-municipio then
               if locked tb-municipio then
                    message "Registro sendo alterado por outro usuario.Tente mais tarde.".
               else message "Registro excluido por outro usuario.".
            else do:
               update tb-municipio.mun-desc with frame f3.
               message "Codigo " mcod " alterado.".
            end.
            leave.
         end.
         else if xopc = "E" then do:
            if not xp1 then do:
               message "Usuario nao autorizado.".
               next.
            end.
            /*** Exclui codigo ***/
            find tb-municipio where tb-municipio.mun-cod = mcod exclusive-lock no-error no-wait.
            if not available tb-municipio then
               if locked tb-municipio then
                    message "Registro sendo alterado por outro usuario.Tente mais tarde.".
               else message "Registro ja' excluido por outro usuario.".
            else do:
               msn = no.
               message color normal "Exclusao confirmada (S/N)?" update msn auto-return.
               /* validacao */
               if can-find(first conhecimento no-lock where conhecimento.mun-cod-ini = tb-municipio.mun-cod) or
                  can-find(first conhecimento no-lock where conhecimento.mun-cod-fim = tb-municipio.mun-cod) then do:
                  message "Codigo sendo utilizado no Conhecimento de Frete".
                  leave.
               end.
               if msn then do:
                  delete tb-municipio.
                  message "Codigo " mcod " excluido.".
               end.
               else message "Codigo " mcod " nao excluido.".
            end.
            leave.
         end.
         else return.
      end. /* repeat */
   end.
   hide frame f3.
end. /* repeat */

/* fim gis8d6.p */
