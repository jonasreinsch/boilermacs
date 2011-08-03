(defun template-insert ()
  "insert a template if the buffer is empty and if a template corresponding to the file name or file name extension exists"
  (interactive)
  (let ((file-name (buffer-file-name)))
    (when file-name
      (let*
          ((e (or (file-name-extension file-name) (file-name-nondirectory file-name)))
           (template-file-name (concat "~/templates/template." e)))
        (when (and
               (= 0 (buffer-size))
               (file-readable-p template-file-name))
          (goto-char (point-min))
          (insert-file-contents template-file-name)
          ;; 3rd arg 't: no error, return nil instead when search not successful
          (if (re-search-forward "[^\s-][^\s-][\s-]*CURSOR_POS" nil 't)
              (delete-region (match-beginning 0) (point))
            (goto-char (point-max))))))))

(add-hook 'find-file-hook 'template-insert)
