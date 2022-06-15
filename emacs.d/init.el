;;; init.el --- Emacs initializations.

;; Enable installation of packages from MELPA.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

;; Custom set variables.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" default))
 '(package-selected-packages
   '(monokai-theme fill-column-indicator golden-ratio-scroll-screen async popup helm helm-swoop yasnippet))
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Install packages.
(package-install-selected-packages)

;; Keybinding override minor mode (overrides all other keybindings).
;; Use as: (define-key my-keys-minor-mode-map (kbd "C-i") 'some-function)
;; From: http://stackoverflow.com/questions/683425/\
;;   globally-override-key-binding-in-emacs
(defvar my-keys-minor-mode-map (make-keymap) "Keymap for my-keys-minor-mode.")
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override major modes."
  t "my-keys" 'my-keys-minor-mode-map)

;;; Display

;; Remove tool and scroll bars.
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Turn on syntax highlighting.
(global-font-lock-mode t)

;; Display the column number in the status bar.
(setq column-number-mode t)

;; Highlight the region bounded by the mark and the point.
(setq transient-mark-mode t)

;; Highlight matching parentheses, braces, and brackets.
(show-paren-mode t)

;; Display line numbers in all modes.
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; Bind "C-c n" key sequence to toggle line numbering.
(define-key my-keys-minor-mode-map (kbd "C-c n") 'display-line-numbers-mode)

;; Fill column indicator.
(require 'fill-column-indicator)
(add-hook 'prog-mode-hook 'fci-mode)

;;; Navigation

;; Enable arrow key buffer switch commands using Shift + (arrow key).
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; Change windmove-default-keybindings to C-M-{j,k,l,;}
;; Matches i3 home row navigation.
(define-key my-keys-minor-mode-map (kbd "C-M-j") 'windmove-left)
(define-key my-keys-minor-mode-map (kbd "C-M-;") 'windmove-right)
(define-key my-keys-minor-mode-map (kbd "C-M-l") 'windmove-up)
(define-key my-keys-minor-mode-map (kbd "C-M-k") 'windmove-down)

;; Bind the "Control-x l" (the letter "ell") key sequence to
;; the function "goto-line".
(define-key my-keys-minor-mode-map (kbd "C-x l") 'goto-line)

;; Bind the Home and End keys for PuTTY.
(define-key my-keys-minor-mode-map (kbd "\C-[[1~") 'beginning-of-line)
(define-key my-keys-minor-mode-map (kbd "\C-[[4~") 'end-of-line)

;; Bind the Home and End keys for the Linux GNOME Terminal.
(define-key my-keys-minor-mode-map (kbd "\C-[OH") 'beginning-of-line)
(define-key my-keys-minor-mode-map (kbd "\C-[OF") 'end-of-line)

;; Golden ratio scrolling.
(require 'golden-ratio-scroll-screen)
(global-set-key [remap scroll-down-command] 'golden-ratio-scroll-screen-down)
(global-set-key [remap scroll-up-command] 'golden-ratio-scroll-screen-up)

;;; Editing.

;; Increase mark ring to 5000 entries.
;; (setq global-mark-ring-max 5000)
;; (setq mark-ring-max 5000)

;; Add newline to end of the file.
(setq mode-require-final-newline t)

;; Set default tab width to 2.
(setq tab-width 2)

;; Use spaces instead of tabs.
(setq indent-tabs-mode nil)

;; Increase kill ring to 5000 entries.
;; (setq kill-ring-max 5000)

;; When killing a line, move the next line up.
(setq kill-whole-line t)

;; Set character set to utf-8.
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; Delete selected text using either Backspace or Delete.
(delete-selection-mode)

;; Show trailing whitespace in programming modes.
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; Toggle viewing all whitespace characters.
(define-key my-keys-minor-mode-map (kbd "C-c w") 'whitespace-mode)

;; Delete all trailing whitespace.
(define-key my-keys-minor-mode-map (kbd "C-x w") 'delete-trailing-whitespace)

;; Use auto fill with a limit of 80 characters.
(setq-default fill-column 80)
(add-hook 'prog-mode-hook 'turn-on-auto-fill)

;; Keybinding to unfill region.
(defun unfill-region (beg end)
  "Unfill the region from BEG to END joining paragraphs into a single line."
  (interactive "*r")
  (let ((fill-column (point-max)))
    (fill-region beg end)))

(define-key my-keys-minor-mode-map (kbd "C-c u") 'unfill-region)

;; Keybinding to revert buffer.
(define-key my-keys-minor-mode-map (kbd "C-c r") 'revert-buffer)

;; Indent after newline.
(global-set-key (kbd "RET") 'newline-and-indent)

(add-hook 'diff-mode-hook
          (lambda ()
            "Show all whitespace in diff mode."
            (setq-local whitespace-style
                        '(face
                          tabs
                          tab-mark
                          spaces
                          space-mark
                          trailing
                          indentation::space
                          indentation::tab
                          newline
                          newline-mark))
            (whitespace-mode 1)))

;; Indent region or buffer.
;;   From prelude-core.el.
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

;; Suppress auto-indenting in certain modes.
;;   From prelude-editing.el.
(defcustom prelude-indent-sensitive-modes
  '(coffee-mode python-mode slim-mode haml-mode yaml-mode)
  "Modes for which auto-indenting is suppressed."
  :type 'list
  :group 'prelude-indent-sensitive-modes)

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (unless (member major-mode prelude-indent-sensitive-modes)
    (save-excursion
      (if (region-active-p)
          (progn
            (indent-region (region-beginning) (region-end))
            (message "Indented selected region."))
        (progn
          (indent-buffer)
          (message "Indented buffer.")))
      (whitespace-cleanup))))

(global-set-key (kbd "C-c i") 'indent-region-or-buffer)

;; Automatically indent yanked text if in programming-modes.
;;   From prelude-editor.el.
(defvar yank-indent-modes
  '(LaTeX-mode TeX-mode)
  "Modes in which to indent regions that are yanked (or yank-popped).
Only modes that don't derive from `prog-mode' should be listed here.")

(defvar yank-indent-blacklisted-modes
  '(python-mode slim-mode haml-mode)
  "Modes for which auto-indenting is suppressed.")

(defvar yank-advised-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur.")

(defun yank-advised-indent-function (beg end)
  "Do indentation from BEG to END, as long as the region isn't too large."
  (if (<= (- end beg) yank-advised-indent-threshold)
      (indent-region beg end nil)))

(defadvice yank (after yank-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text.
With prefix arg, don't indent."
  (if (and (not (ad-get-arg 0))
           (not (member major-mode yank-indent-blacklisted-modes))
           (or (derived-mode-p 'prog-mode)
               (member major-mode yank-indent-modes)))
      (let ((transient-mark-mode nil))
        (yank-advised-indent-function (region-beginning) (region-end)))))

(defadvice yank-pop (after yank-pop-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text.
With prefix arg, don't indent."
  (when (and (not (ad-get-arg 0))
             (not (member major-mode yank-indent-blacklisted-modes))
             (or (derived-mode-p 'prog-mode)
                 (member major-mode yank-indent-modes)))
    (let ((transient-mark-mode nil))
      (yank-advised-indent-function (region-beginning) (region-end)))))

(defun prelude-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'prelude-move-beginning-of-line)

;; (defadvice kill-ring-save (before slick-copy activate compile)
;;   "When called interactively with no active region, copy a single
;; line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (message "Copied line")
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))

;; (defadvice kill-region (before slick-cut activate compile)
;;   "When called interactively with no active region, kill a single
;;   line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;            (line-beginning-position 2)))))

;; (defadvice kill-line (before check-position activate)
;;   "Kill a line, including whitespace characters, until the next
;; non-whitespace character of the next line."
;;   (if (member major-mode
;;               '(emacs-lisp-mode scheme-mode lisp-mode
;;                                 c-mode c++-mode objc-mode
;;                                 latex-mode plain-tex-mode))
;;       (if (and (eolp) (not (bolp)))
;;           (progn (forward-char 1)
;;                  (just-one-space 0)
;;                  (backward-char 1)))))

;; Yasnippets.
(require 'yasnippet)
(yas-reload-all)
(yas-global-mode 1)

;;; Helm.

(require 'helm-config)
(helm-mode 1)

;; ;; To fix error at compile:
;; ;; Error (bytecomp): Forgot to expand macro with-helm-buffer in
;; ;; (with-helm-buffer helm-echo-input-in-header-line)
;; (if (version< "26.0.50" emacs-version)
;;     (eval-when-compile (require 'helm-lib)))

;; (defun helm-hide-minibuffer-maybe ()
;;   (when (with-helm-buffer helm-echo-input-in-header-line)
;;     (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
;;       (overlay-put ov 'window (selected-window))
;;       (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
;;                               `(:background ,bg-color :foreground ,bg-color)))
;;       (setq-local cursor-type nil))))
;; (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap switch-to-buffer] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

;; (require 'helm-grep)

;; (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
;; (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
;; (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

;; (when (executable-find "curl")
;;   (setq helm-google-suggest-use-curl-p t))

;; Open helm buffer in current window.
(setq helm-split-window-in-side-p t)

;; Fuzzy matching.
(setq helm-mode-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-semantic-fuzzy-match t
      helm-M-x-fuzzy-match t
      helm-imenu-fuzzy-match t
      helm-lisp-fuzzy-completion t
      ;; helm-apropos-fuzzy-match t
      helm-locate-fuzzy-match t)

;; Show input in header line (instead of just footer).
(setq helm-echo-input-in-header-line t)

;; (setq helm-google-suggest-use-curl-p t
;;       helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
;;       ;; helm-quick-update t ; do not display invisible candidates
;;       helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.

;;       ;; you can customize helm-do-grep to execute ack-grep
;;       ;; helm-grep-default-command "ack-grep -Hn --smart-case --no-group --no-color %e %p %f"
;;       ;; helm-grep-default-recurse-command "ack-grep -H --smart-case --no-group --no-color %e %p %f"

;;       ;; helm-candidate-number-limit 500 ; limit the number of displayed canidates
;;       helm-ff-file-name-history-use-recentf t
;;       helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
;;       helm-buffer-skip-remote-checking t

;;       helm-org-headings-fontify t
;;       ;; helm-find-files-sort-directories t
;;       ;; ido-use-virtual-buffers t
;;       helm-buffer-skip-remote-checking t
;;       helm-display-header-line nil)

;; (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

;; (global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; ;; (global-set-key (kbd "C-c r") 'helm-recentf)
;; (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
;; (global-set-key (kbd "C-c h o") 'helm-occur)

;; (global-set-key (kbd "C-c h w") 'helm-wikipedia-suggest)
;; (global-set-key (kbd "C-c h g") 'helm-google-suggest)

;; (global-set-key (kbd "C-c h x") 'helm-register)
;; ;; (global-set-key (kbd "C-x r j") 'jump-to-register)

;; (define-key 'help-command (kbd "C-f") 'helm-apropos)
;; (define-key 'help-command (kbd "r") 'helm-info-emacs)
;; (define-key 'help-command (kbd "C-l") 'helm-locate-library)

;; ;; use helm to list eshell history
;; (add-hook 'eshell-mode-hook
;;           #'(lambda ()
;;               (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

;; ;;; Save current position to mark ring
;; (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

;; ;; show minibuffer history with Helm
;; (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
;; (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)

;; (define-key global-map [remap find-tag] 'helm-etags-select)

;; Helm Swoop
(require 'helm-swoop)

(define-key global-map (kbd "C-c s") 'helm-swoop)
;; (define-key global-map (kbd "C-c s") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

;; ;; Save buffer when helm-multi-swoop-edit complete
;; (setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows t)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; ;; If nil, you can slightly boost invoke speed in exchange for text color
;; (setq helm-swoop-speed-or-color t)

;; Disable C-x C-c by binding it to delete-frame instead of exit.
(define-key my-keys-minor-mode-map (kbd "C-x C-c") 'delete-frame)

;; Enable my-keys-minor-mode. Must be last statement of init.el.
(my-keys-minor-mode 1)

;; Load the Monokai theme.
(load-theme 'monokai t)

(provide 'init)
;;; init.el ends here
