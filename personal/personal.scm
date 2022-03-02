(define-module (personal)
  #:use-module (gnu)
  #:use-module (guix transformations)
  #:use-module (guix packages))

(define-public guix-with-sk-support
  (letrec ((libssh-as-git-transformer
          (options->transformation
           '((with-git-url . "libssh=https://git.libssh.org/projects/libssh.git"))))
         (libssh-with-commit-transformer
          (options->transformation
           '((with-commit . "libssh=04ae110c612f0dabc03882a52bf5be56be560020"))))
         (libssh-with-patch-transformer
          (options->transformation
           '((with-patch . "libssh=./patches/0001-Add-sk-ssh-ed25519-to-PUBLIC_KEY_ALGORITHMS.patch"))))
         (libssh-with-sk-support-transformer
          (compose
           libssh-with-patch-transformer
           libssh-with-commit-transformer
           libssh-as-git-transformer)))
  (libssh-with-sk-support-transformer
   (specification->package "guix"))))
