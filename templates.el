(defun template-insert ()
  "insert a template if the buffer is empty and if a template corresponding to the file name or file name extension exists"
  (interactive)
  (let ((file-name (buffer-file-name)))
    (when file-name
      (let*
          (
           (fn (file-name-nondirectory file-name))
           (ext (file-name-extension fn))
           ;; candidate template for direct match
           (template-file-name-fn (concat "~/templates/template." fn))
           ;; candidate template for extension match
           (template-file-name-ext (concat "~/templates/template." ext))
           ;; if a direct match exists, use that
           ;; otherwise check for extension match
           ;; if neither exists, set template-file-name to nil
           (template-file-name (or (and (file-readable-p template-file-name-fn)
                                        template-file-name-fn)
                                   (and (file-readable-p template-file-name-ext)
                                        template-file-name-ext)))
           )
        (when (and
               (= 0 (buffer-size))
               template-file-name)
          (goto-char (point-min))
          (insert-file-contents template-file-name)

          ;; 3rd arg of re-search-forward 't: no error,
          ;; return nil instead when search not successful
          (while (re-search-forward "[^\s-][^\s-][\s-]*FIlE_NAME" nil 't)
            (delete-region (match-beginning 0) (point))
            (insert (capitalize (file-name-sans-extension (file-name-nondirectory file-name)))))

          (goto-char (point-min))

          (if (re-search-forward "[^\s-][^\s-][\s-]*CURSOR_POS" nil 't)
              (delete-region (match-beginning 0) (point))
            (goto-char (point-max))))))))

(add-hook 'find-file-hook 'template-insert)
