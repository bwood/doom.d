(defun bdw-org-clocktable-to-csv (ipos tables params)
  "Custom formatter to export clocktable data as CSV.
This function can be used with the `:formatter` option in clocktables."
  ;; Debugging
  ;; TODO: experiment with remove-overlays and similar functions.
  (message "%s" tables)
  ;; Define a separator for the CSV (e.g., comma or semicolon)
  (let ((separator ","))
    ;; Insert CSV headers
    (insert (mapconcat 'identity '("Task" "Time (h)" "Subtasks") separator) "\n")
    ;; Check if tables contain data
    (when tables
      ;; Iterate over the clocked entries in the single table
      (let ((table (car tables))) ;; There's typically just one table
        (dolist (row (cdr table)) ;; Skip the header row
          (let ((task (nth 0 row))        ;; Task name
                (time (nth 1 row))        ;; Time in HH:MM format
                (subtasks (nth 2 row)))   ;; Subtasks count
            ;; Convert time from HH:MM to hours
            (let* ((hours (if (string-match "\\([0-9]+\\):\\([0-9]+\\)" (or time "0:00"))
                              (+ (string-to-number (match-string 1 time)) ;; Hours
                                 (/ (string-to-number (match-string 2 time)) 60.0)) ;; Minutes
                            0.0))
                   (rounded-hours (/ (float (round (* hours 100))) 100.0))) ;; Round to 2 decimal places
              ;; Insert CSV row
              (insert (mapconcat
                       'identity
                       (list (format "\"%s\"" (or task ""))
                             (format "%.2f" rounded-hours)
                             (format "%s" (or subtasks "0")))
                       separator)
                      "\n"))))))))
