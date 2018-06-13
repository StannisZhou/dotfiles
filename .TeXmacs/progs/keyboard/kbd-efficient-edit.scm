;++ redefinition of important keys
(texmacs-module (keyboard kbd-efficient-edit)
		(:use
		  (math math-edit))
		(table table-edit))

(kbd-map
  (:mode in-text?)

  ;-- Delete by words
  ("M-delete" (begin (kbd-select traverse-right) (clipboard-cut "ternary")))
  ("M-backspace" (begin (kbd-select traverse-left) (clipboard-cut "ternary")))

  ;-- <C-Return> inserts equation array
  ("C-return"  (begin (make 'eqnarray) (temp-proof-fix)))
  )

(kbd-map
  (:mode in-math?)
  ;-- Easy movement in equations
  ;;
  ;; and <space> produces a logical multiplicaton
  ;;Simplified products

  ("space" "*")
  ("space var" " ")  ; same as S-space

  ;; <$> switches to text mode

  ("$" (make-with "mode" "text"))

  ;; this would be cool; probably requires binding these key names
  ;; (obtained from xev) to TeXmacs-recognized keynames; see
  ;; config-kbd.scm

  ("XF86Forward" structured-exit-right)
  ("XF86Back" structured-exit-left)

  )
