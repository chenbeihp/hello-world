(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(column-number-mode t)
 '(company-auto-complete (quote (quote company-explicit-action-p)))
 '(company-dabbrev-minimum-length 3)
 '(company-dict-dir "~/.emacs.d/emacs-company-dict-master/dicts")
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(company-show-numbers t)
 '(custom-buffer-indent 4)
 '(display-time-mode t)
 '(fill-column 160)
 '(global-company-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(package-selected-packages
   (quote
    (helm helm-core fasd company-tabnine switch-window hungry-delete helm-swoop evil company autopair anzu)))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(truncate-partial-width-windows nil)
 '(verilog-auto-inst-param-value t)
 '(verilog-auto-lineup (quote all))
 '(verilog-auto-star-expand t)
 '(verilog-case-indent 4)
 '(verilog-highlight-modules t)
 '(verilog-indent-level 4)
 '(verilog-indent-level-behavioral 4)
 '(verilog-indent-level-declaration 4)
 '(verilog-indent-level-module 4)
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))

 
;;插件包管理源设置:
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

(add-to-list 'package-archives
'("popkit" . "http://elpa.popkit.org/packages/"))
(when (< emacs-major-version 24)
;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)
;;自动安装插件包:
;;(when (not (package-installed-p 'yasnippet)) (package-install 'yasnippet))    ;;自动安装YASnippet智能补全引擎
(add-to-list 'load-path "~/.emacs.d/snippets/") 
(require 'yasnippet)     ;;打开YASnippet智能补全引擎
(yas-global-mode t)     ;;打启YASnippet智能补全引擎
;;(setq ac-sources '(ac-source-semantic ac-source-yasnippet))    ;;设置自动补全列表

(add-to-list 'load-path "~/.emacs.d/parent-mode-master/") 
(require 'parent-mode)


;;company
(add-to-list 'load-path "~/.emacs.d/elpa/company-0.9.9")
(require `company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-transformers '(company-sort-by-occurrence))
(setq company-dabbrev-downcase nil)    ;;避免补全都是小写
(setq company-dabbrev-ignore-case nil)    ;;避免补全时出现部分小写部分大写混合的现象

(add-to-list 'load-path "~/.emacs.d/emacs-company-dict-master/") 
(require 'company-dict)
(setq company-dict-dir (concat user-emacs-directory "emacs-company-dict-master/dicts"))
(define-key global-map [C-tab] 'company-dict)

(defvar company-mode/enable-yas t "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend)    (member 'company-yasnippet backend)))
  backend
(append (if (consp backend) backend (list backend))
        '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;;关闭whitespace按键触发company插件自动补全的功能，避免不想补全时操作不便
(define-key company-active-map (kbd "SPC") nil)
;; Company appears to override the above keymap based on company-auto-complete-chars.
;; Turning it off ensures we have full control.
(setq company-auto-complete-chars nil)

;; 各窗口间切换  
(global-set-key [C-left] 'windmove-left)  
(global-set-key [C-right] 'windmove-right)  
(global-set-key [C-up] 'windmove-up)  
(global-set-key [C-down] 'windmove-down)    

;; switch among buffers
(global-set-key [M-up] 'previous-buffer)  
(global-set-key [M-down] 'next-buffer)    
	
;;;************注意以上插件设置要放在前面，否则会因为更改模式导致语法高亮失效  ***************;; 
;;verilog mode 插件 
(add-to-list 'load-path "~/.emacs.d/verilog-mode/") 
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
(add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))
 
;;设置工作目录
(setenv "PATH" "E:/")

;; 指针颜色设置为白色
(set-cursor-color "white")
;; 鼠标颜色设置为白色
(set-mouse-color "white") 

 
;; 设置主题颜色
(add-to-list 'load-path "~/.emacs.d/color-themes/")
(require 'color-theme)
(color-theme-initialize)
(color-theme-jsc-dark)

;;智能括号
(defun my-c-mode-auto-pair ()
(interactive)
(make-local-variable 'skeleton-pair-alist)
(setq skeleton-pair-alist '(
(?\( ? _ " )")
(?\[ ? _ " ]")
(?\{ ? _ " }")))
(setq skeleton-pair t)
(local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'verilog-mode-hook 'my-c-mode-auto-pair)
(add-hook 'global-mode-hook 'my-c-mode-auto-pair)
(add-hook 'find-file-hook 'my-c-mode-auto-pair)   ;;对所有文件生效
;;括号高亮
(show-paren-mode t) 
;;(setq show-paren-style 'parenthesis)   ;;只高亮显示成对括号
(setq show-paren-style 'expression)    ;;高亮显示成对括号及内部内容

;;时间显示设置
;;启用时间显示设置，在minibuffer上面的那个杠上（忘了叫什么来着）
(display-time-mode 1)
;;时间使用24小时制
(setq display-time-24hr-format t)
;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
;;时间栏旁边启用邮件设置
(setq display-time-use-mail-icon t)
;;时间的变化频率，单位多少来着？
(setq display-time-interval 10)

;;设置默认工作目录
(setq default-directory "E:/")

(setq visible-bell t)
;;??????
(setq inhibit-startup-message t)
;;?emacs??

(setq gnus-inhibit-startup-message t)
;;?gnus??

(fset 'yes-or-no-p 'y-or-n-p)
;; ? Emacs ??? yes ? y ?? yesn ? no

(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
;;(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))
(setq font-lock-maximum-size '((t . 5250000) (vm-mode . 5250000)))
;; ? shell-mode  text-mode ?????

;;显示行号
(require 'linum)
(global-linum-mode t);
;;(setq column-number-mode t)

(setq mouse-yank-at-point t)
;;???????????ù?λ?м????
;;???λ? minibufferм?X selection ????λá

(setq kill-ring-max 200)
;;??.??kill ring(??). ??С???

(setq-default auto-fill-function 'do-auto-fill)
; Autofill in all modes;;
(setq default-fill-column 160)
;; fill-column ? 60. ??

(setq-default indent-tabs-mode nil)
(setq basic-offset 4)
(setq default-tab-width 4)
(setq tab-stop-list ())
;; TAB ?indent, ?????? Makefile ????? makefile-mode  TAB ó TAB ????

(setq sentence-end "\\([]\\|\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
;; sentence-end ??? fill ????

(setq enable-recursive-minibuffers t)
;;??? minibuffer

(setq scroll-margin 4 scroll-conservatively 5000)
;;??? scroll-margin 4 ??3????????

(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;;????text,auto-fill??.???fundamental-mode

(setq mouse-avoidance-mode 'animate)
;;????????

(setq-default cursor-type 'bar)
;;鼠标类型
(blink-cursor-mode nil)

(global-hl-line-mode 3);;高亮当前行

(setq frame-title-format "emacs@%b")
;;显示文件头 emacs@用户名

(setq uniquify-buffer-name-style 'forward);;?
;; ????????? buffer ??foobar ?

(setq auto-image-file-mode t)
;; Emacs ???????

;(auto-compression-mode 1)
;?????

(setq global-font-lock-mode t)
;;语法高亮

(setq-default kill-whole-line t)
;;  C-k ????С

(add-hook 'comint-output-filter-functions
'comint-watch-for-password-prompt)
;;shelltelnetw3m?????,??

;; (setq version-control t);;e汾???
;; (setq kept-old-versions 2);;???汾Σ?α?????α???
;; (setq kept-new-versions 1);;μ?汾1Σ?
;; (setq delete-old-versions t);;?3а汾?汾
;; (setq backup-directory-alist '(("." . "~/backups")));;??·
;; (setq backup-by-copying t);;÷??
;; Emacs У??????( ~ β?)??
;; (?)???????е???
;; ???("~/backups")????汾μ
;; 1汾????????

(setq make-backup-files nil)
;; 趨?
(setq version-control 'never);;???汸?
(setq auto-save-mode nil)
;;???

(setq-default make-backup-files nil)
;; ??

(put 'scroll-left 'disabled nil) ;?
(put 'scroll-right 'disabled nil) ;?
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)
;;Щ???????

;;emacs??
(setq x-select-enable-clipboard t)

(setq mouse-yank-at-point t)
;;?м?

(setq user-full-name "chenbei")
(setq user-mail-address "chenbeihp@gmail.com")
;;设置用户名

(setq require-final-newline t)
;; insert new line when curser moved to end of buffer

(setq-default transient-mark-mode t)
;;Non-nil if Transient-Mark mode is enabled.

(setq track-eol t)
;; keep cursor at end-of-line when moving cursor from end of other lines

(setq Man-notify-method 'pushy)
;;  man page ??? man buffer

(setq next-line-add-newlines nil)
;;Emacs是否在行尾添加新行

(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
;;home?buffer?end?bufferβ


(global-set-key (kbd "C-,") 'scroll-up)
;; "C-,"??
(global-set-key (kbd "C-.") 'scroll-down)
;; "C-."??

;;(global-set-key [f1] 'manual-entry)
;;(global-set-key [C-f1] 'info )

;;(global-set-key [f3] 'repeat-complex-command)

;;(global-set-key [f4] 'other-window)
(global-set-key [f4] 'isearch-forward-regexp)
(global-set-key [C-f4] 'replace-regexp)
;; switch Emacs buffer

(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)
;; dired ??????
(global-set-key [C-f9] 'dired)
;;[C-f9]?dired

;;(global-set-key [f10] 'undo)
(global-set-key (kbd "C-z") 'undo)
;;撤销上次操作

;;(global-set-key [f11] 'calendar)
;;F11??Emacs ??

;;(global-set-key [f12] 'list-bookmarks)

(global-set-key [f11] 'calendar)
;;F11??Emacs ??

(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S chunyu")
;; ???α???

(global-set-key (kbd "M-g") 'goto-line)
;;M-g?goto-line

(global-set-key (kbd "C-SPC") 'set-mark-command)
;; control+space = set mark


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;???;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [(meta ?/)] 'hippie-expand) 
(setq hippie-expand-try-functions-list 
'(try-expand-line 
try-expand-line-all-buffers 
try-expand-list 
try-expand-list-all-buffers 
try-expand-dabbrev 
try-expand-dabbrev-visible 
try-expand-dabbrev-all-buffers 
try-expand-dabbrev-from-kill 
try-complete-file-name 
try-complete-file-name-partially 
try-complete-lisp-symbol 
try-complete-lisp-symbol-partially 
try-expand-whole-kill)) 


;;**********************  自定义快捷键  ************************;;
;;添加带时间戳的行注释
(defun insert-line-comment()
(interactive "*")
(insert "//")
(insert (format-time-string "%Y-%m-%d by cb"))  ;; insert date 
(insert "->"))
(global-set-key [f1] 'insert-line-comment)   ;;快捷键Ctrl+F1

;;添加区域注释
(defun insert-wrap-comment()
(interactive "*")
(insert "/**/")
;;反相寻找字符串并移动光标，此处是寻找一个空格字符，并将光标移到此字符前
(search-backward "*"))
(global-set-key [C-f1] 'insert-wrap-comment)   ;;快捷键Ctrl+F2

;;更新版本说明
(defun update-ver()
(interactive "*")
;;移动到buffer起始
(beginning-of-buffer)
;;查找Modification行
(search-forward "// Modification history :")
(search-forward "//-")   ;;寻找文件头注释的最后一行
(forward-line -1)    ;;jump back to last line
(end-of-line)   ;; move to end of line
(insert "\n// ")   ;;插入换行和注释及空格
(insert (format-time-string "%Y/%m/%d-%H:%M"))  ;; insert date 
(insert " : modified by cb")
)
(global-set-key [f6] 'update-ver)   ;;快捷键F6

;;添加verilog库目录
(defun insert-lib-dir()
(interactive "*")
(insert "// Local Variables:\n")
(insert "// verilog-library-directories:(  )\n")
(insert "// End:")
(search-backward " )"))
(global-set-key [C-f5] 'insert-lib-dir)   ;;快捷键Ctrl+F5

;;运行自动生成多行代码,Ctrl+数字 输入n值，然后Ctrl+F8进行自动生成
(defun auto-generate-increment-code (n)
	(interactive "P")
	(setq count 0)    ;;init loop count
	(beginning-of-line)   ;; first user must move to the evaluation line
	(kill-line)    ;; fetch the line 
	(insert "/*")    ;; to keep original line
	(yank)
	(forward-line -1)
	(end-of-line)
	(insert "*/")
	(newline)
	(while(< count n)
		(yank)    ;;output evaluation line in current line
		(forward-line -1)   ;; yank line command will put curser in next line, so move back one line
		(beginning-of-line)
		(replace-regexp "inc_i" (number-to-string count) nil (line-beginning-position) (line-end-position))  ;; replace "inc" to current count value
		(end-of-line)
		(forward-line)  ;;move to next line to continue
		(setq count (1+ count))))   ;; increase count

(defun auto-generate-decrement-code (n)
	(interactive "P")
	(setq count (- n 1))    ;;init loop count
	(beginning-of-line)   ;; first user must move to the evaluation line
	(kill-line)    ;; fetch the line 
	(insert "/*")    ;; to keep original line
	(yank)
	(forward-line -1)
	(end-of-line)
	(insert "*/")
	(newline)
	(while(>= count 0)
		(yank)    ;;output evaluation line in current line
		(forward-line -1)   ;; yank line command will put curser in next line, so move back one line
		(beginning-of-line)
		(replace-regexp "inc_i" (number-to-string count) nil (line-beginning-position) (line-end-position))  ;; replace "inc" to current count value
		(end-of-line)
		(forward-line)  ;;move to next line to continue
		(setq count (- count 1))))   ;; increase count
		
(global-set-key [C-f7] `auto-generate-decrement-code)   ;; Ctrl+F7 hotkey
(global-set-key [C-f8] `auto-generate-increment-code)   ;; Ctrl+F8 hotkey


;;自动高亮字符串
(add-to-list 'load-path "~/.emacs.d/idle-highlight/") 
(require `idle-highlight-mode)
(defun my-coding-hook ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t)
  (if window-system (hl-line-mode t))
  (idle-highlight-mode t))
;;(add-hook 'c-mode-hook 'my-coding-hook)
;;(add-hook 'verilog-mode-hook 'my-coding-hook)    ;;对特定文件模式生效
(add-hook 'find-file-hook 'my-coding-hook)   ;;对所有文件生效

;;启动自动最大化(数据自己调整，注意格式，如(top . 0)，圆点前后都要留有空格)
(setq initial-frame-alist '((top . 100) (left . 100) (width . 220) (height . 50)))


;; 光标不动屏幕动效果
(global-set-key [(meta n)] 'window-move-up)        
(global-set-key [(meta p)] 'window-move-down)
;; 另一个buffer窗口上下移动. 常常查看帮助用这个.
;;(global-set-key [(control n)] 'other-window-move-down)
;;(global-set-key [(control p)] 'other-window-move-up)

(defun window-move-up (&optional arg)
"Current window move-up 2 lines."
(interactive "P")
(if arg
(scroll-up arg)
(scroll-up 2)))

(defun window-move-down (&optional arg)
"Current window move-down 3 lines."
(interactive "P")
(if arg
(scroll-down arg)
(scroll-down 3)))

(defun other-window-move-up (&optional arg)
"Other window move-up 1 lines."
(interactive "p")
(scroll-other-window arg))

(defun other-window-move-down (&optional arg)
"Other window move-down 2 lines."
(interactive "P")
(if arg
(scroll-other-window-down arg)
(scroll-other-window-down 2)))

;;中文支持
(set-language-environment 'Chinese-GB)                                                                                              
(set-keyboard-coding-system 'euc-cn)                                                                                                
(set-clipboard-coding-system 'euc-cn)                                                                                               
(set-terminal-coding-system 'euc-cn)                                                                                                
(set-buffer-file-coding-system 'euc-cn)                                                                                             
(set-selection-coding-system 'euc-cn)                                                                                               
(modify-coding-system-alist 'process "*" 'euc-cn)                                                                                   
(setq default-process-coding-system                                                                                                 
            '(euc-cn . euc-cn))                                                                                                     
(setq-default pathname-coding-system 'euc-cn) 


;;将下划线视为word的一部分，避免c-r等操作时以下划线为字符串分界
;; For all programming modes
(modify-syntax-entry ?_ "w")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;使用company替换了auto-complete，所以这里注释掉
;;(add-to-list 'load-path "~/.emacs.d/auto-complete/")
;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
;;(ac-config-default)
;;(setq ac-auto-start t)

(add-to-list 'load-path "~/.emacs.d/user-extend/") 
(require 'user-verilog-extend)


;; helm-swoop 插件
(require 'helm)
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-o") 'helm-swoop-back-to-last-point)
;;进入选择阶段并应用所选择的缓冲区进行搜索
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
;;跳过选择阶段并应用所有缓冲区进行搜索
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)   

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-move-to-line-cycle-in-source t)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match nil)

;;helm use smart case match
;;输入 "foo" match "foo" and "Foo"  （仅有小写时，智能匹配所以大写和小写符合的选项）
;;输入 "Foo" match only "Foo"   （包含大写时，仅进行精确匹配）
(setq helm-case-fold-search 'smart)
;;如果需要精确匹配，设置如下：
;;(setq helm-case-fold-search t)

;;让helm-swoop启动时不默认使用光标处字符串进行搜索
;;When helm swoop starts up, it looks at the variable helm-swoop-pre-input-function. 
;;That variable stores a function that returns a string, and helm swoop uses that string as the default value. 
;;So, to not have anything in the search, make that value return an empty string
(setq helm-swoop-pre-input-function (lambda () ""))

;; 协助进行代码跳转，在某个地方打上记号，然后去另外文件操作后，直接返回记号的文件
(global-set-key [(control q)] 'ska-point-to-register)    ;; Ctrl-q
(global-set-key [(control j)] 'ska-jump-to-register)     ;; Ctrl-j
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))
		
;;查找替换时更加便利
(require 'anzu)
(global-anzu-mode +1)

(set-face-attribute 'anzu-mode-line nil
                    :foreground "blue" :weight 'bold)



(define-key isearch-mode-map [remap isearch-query-replace]  #'anzu-isearch-query-replace)
(define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu-isearch-query-replace-regexp)
(global-set-key [(meta ?\%)] `anzu-query-replace)
(global-set-key [(meta ?\$)] `anzu-query-replace-regexp)

(require 'hungry-delete)
(global-hungry-delete-mode)

;;多窗口跳转
(require 'switch-window)
(global-set-key (kbd "C-c o") 'switch-window)

;;提高性能
(setq line-move-visual nil)
;;调整emacs垃圾回收策略，优化性能
(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       'garbage-collect))
(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (k-time (garbage-collect))))))				


;;***************************helm插件的wiki配置***************************
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(helm-mode 1)
;;***************************end of helm插件的wiki配置***************************
