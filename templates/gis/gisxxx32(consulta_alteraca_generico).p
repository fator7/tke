
/*-------------------------------------------------------------------------
  Empresa...: ThyssenKrupp Elevadores
  Sistema...: GIS - Sistema de Gestao Industrial
  Programa..: gisxxx32
  Descricao.: Template Consulta e alteração genérico
  Autor.....: Gian Winckler
  Data......: Out 2016

  Data       Autor    Alteracao
  ---------- -------- -----------------------------------------------------
-------------------------------------------------------------------------*/

{uticrip.i gisxxx32}
{utidvar.i}

def temp-table tt-item no-undo
    field ite-cod   as int  label "Cod item"
    field ite-desc  as char format "x(20)"
    field ite-data  as date.

def var v-ite-cod like tt-item.ite-cod.

/*Apenas para preencher informações do exemplo, remover antes do uso*/
def var i as int.
run carrega-tt.

form
    tt-item.ite-cod     label "Item"
    tt-item.ite-desc    label "Descricao"
    tt-item.ite-data    label "Data"
    with frame f-item center side-label row 10 1 column width 40.

repeat:
   assign
      v-ite-cod = 0.

   update
      v-ite-cod auto-return
      help "Entre com o codigo do item, F5 p/ escolher ou F4 p/ sair."
      go-on(F9) with frame f1 center row 10 side-labels

      editing:
          readkey.
          if keylabel(lastkey) = "F5" then do:
               {utiselr2.i
               &file=tt-item
               &cfield=tt-item.ite-cod
               &where= true
               &form="row 6 overlay center"}
               if avail tt-item then do:
                   v-ite-cod = tt-item.ite-cod.
                   disp v-ite-cod with frame f1.
                   apply 13.
               end.
          end.
          else apply lastkey.
      end.

      find first tt-item where
                 tt-item.ite-cod = v-ite-cod no-lock no-error.

      if avail tt-item then do:
         hide frame f1.

         disp
             tt-item.ite-cod
             tt-item.ite-desc
             tt-item.ite-data
             with frame f-item.

         xsubm = "[Selecionar] [Alterar] [Fim]".
         {utisubm.i}
         if xopc = "S" then next.
         if xopc = "F" then leave.
         else if xopc = "A" then
         update
            tt-item.ite-desc
            with frame f-item.
      end.
      else do:
        next.
      end.
end.



procedure carrega-tt:

    do i = 1 to 10:
        create tt-item.
        assign
            tt-item.ite-cod     = i
            tt-item.ite-desc    = "Item-" + string(i)
            tt-item.ite-data    = today.
    end.

end procedure.
