(defun tlt ()
  "Insert a LaTeX Template"
  (interactive)
  (goto-char (point-min))
  (insert-file-contents
   (expand-file-name "template_latex.tex"
                     (expand-file-name "templates" "~")))
  (setq e (goto-char (search-forward "CURSOR_POS")))
  (beginning-of-line)
  (delete-region (point) e))
