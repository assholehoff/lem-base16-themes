(in-package :lem-base16-themes)

(defparameter *light-threshold* 112)

(defmacro define-base16-color-theme (name &body colors)
  (labels ((color (name) (getf colors name))
           (rgb (color) (mapcar (lambda (i) (parse-integer (subseq color i (+ i 2)) :radix 16)) '(1 3 5)))
           (gray (c) (+ (* 0.3 (nth 0 c)) (* 0.59 (nth 1 c)) (* 0.11 (nth 2 c))))
           (dark (color) (< (gray (rgb color)) *light-threshold*)))
    `(lem:define-color-theme ,name ()
       (:display-background-mode ,(if (dark (color :base00)) :dark :light))
       (:foreground ,(color :base05))
       (:background ,(color :base00))
       (:inactive-window-background ,(color :base00))
       (lem:region :foreground nil :background ,(color :base02))
       (lem:syntax-warning-attribute :foreground ,(color :base08))
       (lem:syntax-string-attribute :foreground ,(color :base0B))
       (lem:syntax-comment-attribute :foreground ,(color :base03))
       (lem:syntax-keyword-attribute :foreground ,(color :base0E))
       (lem:syntax-constant-attribute :foreground ,(color :base09))
       (lem:syntax-function-name-attribute :foreground ,(color :base0D))
       (lem:syntax-variable-attribute :foreground ,(color :base08))
       (lem:syntax-type-attribute :foreground ,(color :base0A))
       (lem:syntax-builtin-attribute :foreground ,(color :base0C))
       
       ;; Modeline
       (lem:modeline :background ,(color :base02) :foreground ,(color :base07))
       (lem:modeline-inactive :background ,(color :base01) :foreground ,(color :base03))
       (lem:modeline-name-attribute :foreground ,(color :base09))
       (lem:inactive-modeline-name-attribute :foreground ,(color :base03))
       (lem:modeline-major-mode-attribute :foreground ,(color :base0D))
       (lem:inactive-modeline-major-mode-attribute :foreground ,(color :base03))
       (lem:modeline-minor-modes-attribute :foreground ,(color :base07))
       (lem:inactive-modeline-minor-modes-attribute :foreground ,(color :base03))
       (lem:modeline-position-attribute :foreground ,(color :base06) :background ,(color :base01))
       (lem:inactive-modeline-position-attribute :foreground ,(color :base03) :background ,(color :base01))
       (lem:modeline-posline-attribute :foreground ,(color :base00) :background ,(color :base05))
       (lem:inactive-modeline-posline-attribute :foreground ,(color :base00) :background ,(color :base02))

       ;; Multiplexer
       (lem/frame-multiplexer:frame-multiplexer-active-frame-name-attribute
        :foreground ,(color :base01) :background ,(color :base0A) :bold t)
       (lem/frame-multiplexer:frame-multiplexer-frame-name-attribute
        :foreground ,(color :base01) :background ,(color :base04) :bold t)
       (lem/frame-multiplexer:frame-multiplexer-background-attribute
        :foreground ,(color :base0A) :background ,(color :base01))
       
       ,@(loop :for (name color) :on colors :by #'cddr
               :collect (list name color)))))
