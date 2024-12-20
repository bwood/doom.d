(defun bdw-org-clocktable-to-csv (ipos tables params)
  "Custom formatter to export clocktable data as CSV.
Converts clock table entries to CSV format with times in decimal hours."
  (let* ((entries (nth 2 (car tables)))
         (level-2-entries (seq-filter
                          (lambda (entry)
                            (= (car entry) 2))
                          entries))
         (csv-lines
          (mapcar
           (lambda (entry)
             (let* ((link-text (cadr entry))
                    ;; Debug the link text
                    (_ (message "Processing link text: %S" link-text))
                    ;; Convert to plain string
                    (plain-text (format "%s" link-text))
                    (_ (message "Plain text: %s" plain-text))
                    ;; Extract title from the link
                    (title (progn
                            (with-temp-buffer
                              (insert plain-text)
                              (goto-char (point-min))
                              ;; Look for text between last ][ and final ]
                              (if (search-forward-regexp "\\]\\[\\([^]]*\\)]$" nil t)
                                  (match-string 1)
                                plain-text))))
                    (_ (message "Extracted title: %s" plain-text))
                    (minutes (nth 4 entry))
                    (hours (/ (float minutes) 60.0)))
               (format "\"%s\", %.2f" title hours)))
           level-2-entries)))
    (concat (string-join csv-lines "\n") "\n")))
