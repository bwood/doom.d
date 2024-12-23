(defun bdw-org-clocktable-to-csv (ipos tables params)
  "Custom formatter to export clocktable data as CSV.
Converts clock table entries to CSV format with times in decimal hours.
Each line contains the task title and its time in hours, for level 2 entries only.
Times are rounded to 2 decimal places."
  (let* ((entries (nth 2 (car tables)))
         (level-2-entries (seq-filter
                          (lambda (entry)
                            (= (car entry) 2))
                          entries))
         (csv-lines
          (mapcar
           (lambda (entry)
             (let* ((link-text (cadr entry))
                    (plain-text (format "%s" link-text))
                    (title
                     (cond
                      ((string-match ".*\\]\\[\\([^]]*\\)\\]\\]$" plain-text)
                       (match-string 1 plain-text))
                      ((string-match "\\[\\([^]]+\\)\\]" plain-text)
                       (match-string 1 plain-text))
                      (t plain-text)))
                    (cleaned-title (replace-regexp-in-string "\\\\\\[" "["
                                   (replace-regexp-in-string "\\\\\\]" "]" title)))
                    (minutes (nth 4 entry))
                    (hours (/ (round (* (/ (float minutes) 60.0) 100.0)) 100.0)))
               (format "\"%s\", %.2f" cleaned-title hours)))
           level-2-entries)))
    (goto-char ipos)
    (insert (concat (string-join csv-lines "\n") "\n"))))
