(defun bdw-org-clocktable-to-csv (ipos tables params)
  "Custom formatter to export clocktable data as CSV.
Converts clock table entries to CSV format with times in decimal hours."
  (let* ((entries (nth 2 (car tables)))
         ;; Extract year and week from block parameter
         (block-spec (format "%s" (plist-get params :block)))
         (year (progn
                (string-match "\\([0-9]+\\)-W\\([0-9]+\\)" block-spec)
                (string-to-number (match-string 1 block-spec))))
         (week (string-to-number (match-string 2 block-spec)))
         ;; Calculate date for Friday (day 5) of the given week
         (time (encode-time 0 0 0 ; sec min hour
                          5 ; 5th day (Friday)
                          1 ; Month (temporary)
                          year
                          t ; daylight savings: unspecified
                          nil)) ; timezone: current
         (friday-date (format-time-string "%m\\%d\\%Y"
                                        (time-add time
                                                 (days-to-time (* (1- week) 7)))))
         (level-2-entries (seq-filter
                          (lambda (entry)
                            (= (car entry) 2))
                          entries))
         (csv-lines
          (mapcar
           (lambda (entry)
             (let* ((link-text (cadr entry))
                    (plain-text (format "%s" link-text))
                    ;; Extract the title using regexp patterns
                    (title
                     (cond
                      ((string-match ".*\\]\\[\\([^]]*\\)\\]\\]$" plain-text)
                       (match-string 1 plain-text))
                      ((string-match "\\[\\([^]]+\\)\\]" plain-text)
                       (match-string 1 plain-text))
                      (t plain-text)))
                    ;; Clean up any escaped brackets
                    (cleaned-title (replace-regexp-in-string "\\\\\\[" "["
                                   (replace-regexp-in-string "\\\\\\]" "]" title)))
                    (minutes (nth 4 entry))
                    (hours (/ (round (* (/ (float minutes) 60.0) 100.0)) 100.0)))
               (format "\"%s\",\"%s\",%.2f" friday-date cleaned-title hours)))
           level-2-entries)))
    (goto-char ipos)
    (insert (concat (string-join csv-lines "\n") "\n"))))
