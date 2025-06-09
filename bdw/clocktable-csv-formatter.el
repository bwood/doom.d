(defun bdw-org-clocktable-to-csv (ipos tables params)
  "Custom formatter to export clocktable data as CSV.
Converts clock table entries to CSV format with times in decimal hours.
If a title contains a ticket ID like ABC-123:, splits it into two CSV fields."
  (let* ((entries (nth 2 (car tables)))
         (block-spec (format "%s" (plist-get params :block)))
         (year (progn
                 (string-match "\\([0-9]+\\)-W\\([0-9]+\\)" block-spec)
                 (string-to-number (match-string 1 block-spec))))
         (week (string-to-number (match-string 2 block-spec)))
         (time (encode-time 0 0 0 5 1 year t nil))
         (friday-date (format-time-string "%m\\%d\\%Y"
                                          (time-add time (days-to-time (* (1- week) 7)))))
         (level-2-entries
          (seq-filter (lambda (entry) (= (car entry) 2)) entries))
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
               ;; Check for pattern like "ABC-123: Something"
               (if (string-match "\\([A-Za-z]+-[0-9]+\\):\\s-*\\(.*\\)" cleaned-title)
                   (let ((ticket (match-string 1 cleaned-title))
                         (desc (match-string 2 cleaned-title)))
                     (format "\"%s\",\"%s\",\"%s\",%.2f" friday-date ticket desc hours))
                 ;; Else just one title field
                 (format "\"%s\",\"%s\",%.2f" friday-date cleaned-title hours))))
           level-2-entries)))
    (goto-char ipos)
    (insert (concat (string-join csv-lines "\n") "\n"))))
