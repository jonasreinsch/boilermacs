(defun tpl ()
  "Insert a Perl Template"
  (interactive)
  (goto-char (point-min))
  (insert-file-contents
   (expand-file-name "template_perl.pl"
                     (expand-file-name "templates" "~")))
  (setq e (goto-char (search-forward "CURSOR_POS")))
  (beginning-of-line)
  (delete-region (point) e))
