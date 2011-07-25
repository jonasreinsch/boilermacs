(defun tgi ()
  "Insert a gitignore Template"
  (interactive)
  (goto-char (point-min))
  (insert-file-contents
   (expand-file-name "template_gitignore.txt"
                     (expand-file-name "templates" "~")))
  (goto-char (point-max)))
